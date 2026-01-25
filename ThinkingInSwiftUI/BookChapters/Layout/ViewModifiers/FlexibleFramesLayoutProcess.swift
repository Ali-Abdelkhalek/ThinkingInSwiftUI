//
//  FlexibleFramesLayoutProcess.swift
//  ThinkingInSwiftUI
//
//  Visual demonstration of the flexible frames layout process
//  Shows step-by-step how proposals and sizes flow through the view tree
//

import SwiftUI

struct FlexibleFramesLayoutProcess: View {
    @State private var selectedExample = 0

    let examples: [(title: String, view: AnyView, steps: [String])] = [
        (
            title: "maxWidth: .infinity",
            view: AnyView(
                Text("Hello")
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.3))
                    .border(Color.blue, width: 2)
            ),
            steps: [
                "1. Container proposes: 300×50",
                "2. Frame receives: 300×50",
                "3. Frame clamps width: min(∞, 300) = 300",
                "4. Frame proposes to Text: 300×50",
                "5. Text reports: 44×17",
                "6. Frame determines width: max(300, 44) capped at ∞ = 300",
                "7. Frame reports: 300×17",
                "Result: Frame fills proposed width"
            ]
        ),
        (
            title: "minWidth: 200",
            view: AnyView(
                Text("Hi")
                    .frame(minWidth: 200)
                    .background(Color.orange.opacity(0.3))
                    .border(Color.orange, width: 2)
            ),
            steps: [
                "1. Container proposes: 300×50",
                "2. Frame receives: 300×50",
                "3. Frame clamps width: max(200, 300) = 300",
                "4. Frame proposes to Text: 300×50",
                "5. Text reports: 17×17",
                "6. Frame width = max(200, 17) = 200",
                "7. Frame reports: 200×17",
                "Result: Frame becomes at least minWidth"
            ]
        ),
        (
            title: "minWidth: 0, maxWidth: .infinity",
            view: AnyView(
                Text("Accept")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.purple.opacity(0.3))
                    .border(Color.purple, width: 2)
            ),
            steps: [
                "1. Container proposes: 300×50",
                "2. Frame receives: 300×50",
                "3. Frame clamps width: max(0, min(∞, 300)) = 300",
                "4. Frame proposes to Text: 300×50",
                "5. Text reports: 50×17",
                "6. Frame width = max(0, min(∞, 300)) = 300",
                "7. Frame reports: 300×17",
                "Result: Frame accepts exactly proposed width"
            ]
        ),
        (
            title: "minWidth: 100, maxWidth: 250",
            view: AnyView(
                Text("Clamped")
                    .frame(minWidth: 100, maxWidth: 250)
                    .background(Color.green.opacity(0.3))
                    .border(Color.green, width: 2)
            ),
            steps: [
                "1. Container proposes: 300×50",
                "2. Frame receives: 300×50",
                "3. Frame clamps width: max(100, min(250, 300)) = 250",
                "4. Frame proposes to Text: 250×50",
                "5. Text reports: 65×17",
                "6. Frame width = max(100, min(250, 300)) = 250",
                "7. Frame reports: 250×17",
                "Result: Frame width clamped to maxWidth"
            ]
        ),
        (
            title: "idealWidth: 200 (with nil proposed)",
            view: AnyView(
                HStack {
                    Color.clear.frame(width: 0)
                    Text("Ideal")
                        .frame(idealWidth: 200)
                        .background(Color.cyan.opacity(0.3))
                        .border(Color.cyan, width: 2)
                }
            ),
            steps: [
                "1. HStack proposes: nil×50 to flexible items",
                "2. Frame receives: nil×50",
                "3. Frame uses idealWidth: 200",
                "4. Frame proposes to Text: 200×50",
                "5. Text reports: 35×17",
                "6. Frame width = 200 (ignores subview size)",
                "7. Frame reports: 200×17",
                "Result: Frame uses ideal width when nil proposed"
            ]
        )
    ]

    var body: some View {
        VStack(spacing: 20) {
            Text("Flexible Frames Layout Process")
                .font(.title)
                .fontWeight(.bold)

            Picker("Example", selection: $selectedExample) {
                ForEach(examples.indices, id: \.self) { index in
                    Text(examples[index].title).tag(index)
                }
            }
            .pickerStyle(.menu)
            .padding()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Visual Example
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Visual Result:")
                            .font(.headline)

                        examples[selectedExample].view
                            .frame(width: 300)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)

                    // Step-by-Step Process
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Layout Process:")
                            .font(.headline)

                        ForEach(examples[selectedExample].steps, id: \.self) { step in
                            HStack(alignment: .top, spacing: 8) {
                                Text("•")
                                Text(step)
                                    .font(.system(.body, design: .monospaced))
                            }
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)

                    // Diagram
                    layoutDiagram
                }
                .padding()
            }
        }
    }

    private var layoutDiagram: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Two-Pass System:")
                .font(.headline)

            VStack(alignment: .leading, spacing: 16) {
                passSection(
                    title: "Pass 1: Proposing to Subview",
                    color: .blue,
                    steps: [
                        "Container → Frame: proposes size",
                        "Frame: clamps by min/max parameters",
                        "Frame → Subview: proposes clamped size",
                        "Subview: calculates and returns its size"
                    ]
                )

                Divider()

                passSection(
                    title: "Pass 2: Reporting Own Size",
                    color: .green,
                    steps: [
                        "Frame: receives subview's size",
                        "Frame: fills missing boundaries with subview size",
                        "Frame: clamps proposed size by boundaries",
                        "Frame → Container: reports final size"
                    ]
                )
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }

    private func passSection(title: String, color: Color, steps: [String]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(color)

            ForEach(steps, id: \.self) { step in
                HStack(alignment: .top, spacing: 8) {
                    Circle()
                        .fill(color)
                        .frame(width: 6, height: 6)
                        .padding(.top, 6)
                    Text(step)
                        .font(.caption)
                }
            }
        }
    }
}

// MARK: - Complete Example from Book

struct CompleteBookExample: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Complete Example from Book")
                .font(.title2)
                .fontWeight(.bold)

            // The actual example
            Text("Hello, World!")
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.teal)
                .padding(10)
                .border(Color.red, width: 2)

            // Step-by-step breakdown
            VStack(alignment: .leading, spacing: 12) {
                Text("Layout Steps (assuming 320×480 screen):")
                    .font(.headline)

                layoutStep(num: 1, text: "System proposes 320×480 to padding")
                layoutStep(num: 2, text: "Padding proposes 300×460 to background")
                layoutStep(num: 3, text: "Background proposes 300×460 to frame (primary)")
                layoutStep(num: 4, text: "Frame proposes 300×460 to Text")
                layoutStep(num: 5, text: "Text reports 76×17")
                layoutStep(num: 6, text: "Frame width = max(0, min(∞, 300)) = 300")
                layoutStep(num: 7, text: "Background proposes 300×17 to Color (secondary)")
                layoutStep(num: 8, text: "Color accepts and reports 300×17")
                layoutStep(num: 9, text: "Background reports 300×17")
                layoutStep(num: 10, text: "Padding adds 10pts each side, reports 320×37")
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)

            // Visual hierarchy
            viewHierarchy
        }
        .padding()
    }

    private func layoutStep(num: Int, text: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Text("\(num).")
                .fontWeight(.semibold)
                .frame(width: 25, alignment: .leading)
            Text(text)
                .font(.system(.callout, design: .monospaced))
        }
    }

    private var viewHierarchy: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("View Hierarchy:")
                .font(.headline)

            VStack(alignment: .leading, spacing: 4) {
                hierarchyItem(level: 0, name: "padding", proposals: "→ 320×480, ← 320×37")
                hierarchyItem(level: 1, name: "background", proposals: "→ 300×460, ← 300×17")
                hierarchyItem(level: 2, name: "frame (primary)", proposals: "→ 300×460, ← 300×17")
                hierarchyItem(level: 3, name: "Text", proposals: "→ 300×460, ← 76×17")
                hierarchyItem(level: 2, name: "Color (secondary)", proposals: "→ 300×17, ← 300×17")
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }

    private func hierarchyItem(level: Int, name: String, proposals: String) -> some View {
        HStack(spacing: 4) {
            Text(String(repeating: "  ", count: level) + "└─")
                .foregroundColor(.secondary)
            Text(name)
                .fontWeight(.medium)
            Spacer()
            Text(proposals)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .font(.system(.callout, design: .monospaced))
    }
}

// MARK: - Interactive Sandbox

struct FlexibleFramesSandbox: View {
    @State private var minWidth: CGFloat = 0
    @State private var maxWidth: CGFloat = 400
    @State private var useMinWidth = false
    @State private var useMaxWidth = true
    @State private var useMaxWidthInfinity = true

    var body: some View {
        VStack(spacing: 20) {
            Text("Flexible Frames Sandbox")
                .font(.title2)
                .fontWeight(.bold)

            // Controls
            VStack(alignment: .leading, spacing: 16) {
                Toggle("Use minWidth", isOn: $useMinWidth)
                if useMinWidth {
                    HStack {
                        Text("minWidth:")
                        Slider(value: $minWidth, in: 0...300)
                        Text("\(Int(minWidth))")
                            .frame(width: 40)
                    }
                }

                Toggle("Use maxWidth", isOn: $useMaxWidth)
                if useMaxWidth {
                    Toggle("Infinity", isOn: $useMaxWidthInfinity)
                    if !useMaxWidthInfinity {
                        HStack {
                            Text("maxWidth:")
                            Slider(value: $maxWidth, in: 50...400)
                            Text("\(Int(maxWidth))")
                                .frame(width: 40)
                        }
                    }
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)

            // Result
            VStack(spacing: 8) {
                Text("Result:")
                    .font(.headline)

                Text("Hello, World!")
                    .modifier(DynamicFrameModifier(
                        minWidth: useMinWidth ? minWidth : nil,
                        maxWidth: useMaxWidth ? (useMaxWidthInfinity ? .infinity : maxWidth) : nil
                    ))
                    .background(Color.blue.opacity(0.3))
                    .border(Color.blue, width: 2)

                Text(currentFrameCode)
                    .font(.system(.caption, design: .monospaced))
                    .padding(8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(4)
            }

            Spacer()
        }
        .padding()
    }

    private var currentFrameCode: String {
        var params: [String] = []
        if useMinWidth {
            params.append("minWidth: \(Int(minWidth))")
        }
        if useMaxWidth {
            params.append("maxWidth: \(useMaxWidthInfinity ? ".infinity" : "\(Int(maxWidth))")")
        }

        if params.isEmpty {
            return "No frame modifier"
        }
        return ".frame(\(params.joined(separator: ", ")))"
    }
}

struct DynamicFrameModifier: ViewModifier {
    let minWidth: CGFloat?
    let maxWidth: CGFloat?

    func body(content: Content) -> some View {
        content
            .frame(
                minWidth: minWidth,
                maxWidth: maxWidth
            )
    }
}

// MARK: - Combined View

struct FlexibleFramesLayoutProcessContainer: View {
    var body: some View {
        TabView {
            FlexibleFramesLayoutProcess()
                .tabItem {
                    Label("Process", systemImage: "arrow.right.circle")
                }

            CompleteBookExample()
                .tabItem {
                    Label("Book Example", systemImage: "book")
                }

            FlexibleFramesSandbox()
                .tabItem {
                    Label("Sandbox", systemImage: "hammer")
                }
        }
    }
}

// MARK: - Preview

#Preview("Layout Process") {
    FlexibleFramesLayoutProcess()
}

#Preview("Book Example") {
    CompleteBookExample()
}

#Preview("Sandbox") {
    FlexibleFramesSandbox()
}

#Preview("All") {
    FlexibleFramesLayoutProcessContainer()
}
