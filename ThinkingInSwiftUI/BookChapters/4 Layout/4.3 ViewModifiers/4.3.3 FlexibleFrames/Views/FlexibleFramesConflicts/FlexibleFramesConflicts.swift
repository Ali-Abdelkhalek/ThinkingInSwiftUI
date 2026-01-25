import SwiftUI

struct FlexibleFramesConflicts: View {
    @State private var outerWidth: CGFloat = 150
    @State private var innerWidth: CGFloat = 200
    @State private var useOuterFixed = true
    @State private var useInnerFixed = true

    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                sectionHeader("Understanding Frame Conflicts")
                FlexibleFramesConflictsIntro()

                sectionHeader("Fixed Child in Constrained Parent")
                FlexibleFramesConflictsFixedChild()

                sectionHeader("Multiple Frames on Same View")
                FlexibleFramesConflictsMultipleFrames()

                sectionHeader("Conflicting Min/Max Constraints")
                FlexibleFramesConflictsConstraints()

                sectionHeader("Parent vs Child Size Demands")
                FlexibleFramesConflictsParentChild()

                sectionHeader("Interactive Conflict Simulator")
                conflictSimulator

                sectionHeader("How SwiftUI Resolves Conflicts")
                FlexibleFramesConflictsResolution()
            }
            .padding()
        }
    }

    // MARK: - Interactive Conflict Simulator

    private var conflictSimulator: some View {
        VStack(spacing: 20) {
            Text("Test frame conflicts interactively")
                .font(.headline)

            VStack(alignment: .leading, spacing: 16) {
                Text("Outer Frame:")
                    .font(.headline)

                Toggle("Fixed Width", isOn: $useOuterFixed)

                HStack {
                    Text("Width: \(Int(outerWidth))")
                        .frame(width: 80)
                    Slider(value: $outerWidth, in: 50...300)
                }

                Divider()

                Text("Inner Frame:")
                    .font(.headline)

                Toggle("Fixed Width", isOn: $useInnerFixed)

                HStack {
                    Text("Width: \(Int(innerWidth))")
                        .frame(width: 80)
                    Slider(value: $innerWidth, in: 50...300)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)

            VStack(spacing: 12) {
                Text("Result:")
                    .font(.headline)

                Text("Hello World")
                    .background(Color.red)
                    .modifier(ConditionalFrameModifier(width: innerWidth, isFixed: useInnerFixed, color: .orange))
                    .modifier(ConditionalFrameModifier(width: outerWidth, isFixed: useOuterFixed, color: .blue))

                Text(conflictDescription)
                    .font(.caption)
                    .padding(8)
                    .background(Color.yellow.opacity(0.1))
                    .cornerRadius(4)

                Text(currentCode)
                    .font(.system(.caption2, design: .monospaced))
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

    private var conflictDescription: String {
        if useOuterFixed && useInnerFixed {
            if innerWidth > outerWidth {
                return "Both fixed: Inner (\(Int(innerWidth))pt) > Outer (\(Int(outerWidth))pt) → Inner wins, overflows!"
            } else {
                return "Both fixed: Outer (\(Int(outerWidth))pt) ≥ Inner (\(Int(innerWidth))pt) → Outer contains inner"
            }
        } else if useOuterFixed {
            return "Outer fixed (\(Int(outerWidth))pt), inner flexible → Inner adapts to outer"
        } else if useInnerFixed {
            return "Inner fixed (\(Int(innerWidth))pt), outer flexible → Outer adapts to inner"
        } else {
            return "Both flexible → Frames negotiate based on constraints"
        }
    }

    private var currentCode: String {
        var code = "Text(\"Hello World\")\n"
        code += "    .frame(\(useInnerFixed ? "width: \(Int(innerWidth))" : "maxWidth: .infinity"))\n"
        code += "    .frame(\(useOuterFixed ? "width: \(Int(outerWidth))" : "maxWidth: .infinity"))"
        return code
    }
}

#Preview {
    FlexibleFramesConflicts()
}
