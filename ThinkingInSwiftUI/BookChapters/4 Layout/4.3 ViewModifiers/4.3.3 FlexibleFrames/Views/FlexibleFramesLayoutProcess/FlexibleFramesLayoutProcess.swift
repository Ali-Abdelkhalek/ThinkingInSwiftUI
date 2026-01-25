import SwiftUI

struct FlexibleFramesLayoutProcess: View {
    @State private var selectedExample = 0
    @State private var minWidth: CGFloat = 0
    @State private var maxWidth: CGFloat = 400
    @State private var useMinWidth = false
    @State private var useMaxWidth = true
    @State private var useMaxWidthInfinity = true

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
                "6. Frame width: max(300, 44) capped at ∞ = 300",
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
                "3. Frame clamps: max(0, min(∞, 300)) = 300",
                "4. Frame proposes to Text: 300×50",
                "5. Text reports: 50×17",
                "6. Frame width = 300",
                "7. Frame reports: 300×17",
                "Result: Accepts exactly proposed width"
            ]
        )
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                sectionHeader("Step-by-Step Layout Process")
                layoutProcessSection

                sectionHeader("Understanding the Two-Pass System")
                FlexibleFramesTwoPassExplanation()

                sectionHeader("Interactive Frame Sandbox")
                interactiveSandbox
            }
            .padding()
        }
    }

    // MARK: - Layout Process Section

    private var layoutProcessSection: some View {
        VStack(spacing: 20) {
            Text("See how proposals flow through flexible frames")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Picker("Example", selection: $selectedExample) {
                ForEach(examples.indices, id: \.self) { index in
                    Text(examples[index].title).tag(index)
                }
            }
            .pickerStyle(.menu)
            .padding()

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
                                .font(.subheadline)
                        }
                    }
                }
                .padding()
                .background(Color.blue.opacity(0.05))
                .cornerRadius(12)
            }
        }
    }

    // MARK: - Interactive Sandbox

    private var interactiveSandbox: some View {
        VStack(spacing: 20) {
            Text("Build your own frame modifier")
                .font(.headline)

            // Controls
            VStack(alignment: .leading, spacing: 16) {
                Toggle("Use minWidth", isOn: $useMinWidth)
                if useMinWidth {
                    HStack {
                        Text("minWidth:")
                            .frame(width: 80)
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
                                .frame(width: 80)
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
            VStack(spacing: 12) {
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
        }
        .padding()
        .background(Color.purple.opacity(0.05))
        .cornerRadius(12)
    }

    // MARK: - Computed Properties

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

#Preview {
    FlexibleFramesLayoutProcess()
}
