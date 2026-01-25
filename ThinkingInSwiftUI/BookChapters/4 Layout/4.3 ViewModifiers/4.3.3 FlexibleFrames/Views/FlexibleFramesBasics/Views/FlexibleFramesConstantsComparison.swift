import SwiftUI

// MARK: - Interactive Constants Comparison

struct FlexibleFramesConstantsComparison: View {
    @State private var selectedConstant: ConstantOption = .infinity

    enum ConstantOption: String, CaseIterable {
        case infinity = "infinity"
        case greatestFinite = "greatestFiniteMagnitude"
        case pi = "pi"
        case zero = "0"
        case custom100 = "100"
        case custom200 = "200"

        var value: CGFloat {
            switch self {
            case .infinity: return .infinity
            case .greatestFinite: return .greatestFiniteMagnitude
            case .pi: return .pi
            case .zero: return 0
            case .custom100: return 100
            case .custom200: return 200
            }
        }

        var displayValue: String {
            switch self {
            case .infinity: return "∞"
            case .greatestFinite: return "1.8e+308"
            case .pi: return "3.14159..."
            case .zero: return "0"
            case .custom100: return "100"
            case .custom200: return "200"
            }
        }
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Test different constants interactively")
                .font(.headline)

            Picker("Constant", selection: $selectedConstant) {
                ForEach(ConstantOption.allCases, id: \.self) { option in
                    Text(option.rawValue).tag(option)
                }
            }
            .pickerStyle(.menu)
            .padding()

            VStack(alignment: .leading, spacing: 8) {
                Text("Selected: .\(selectedConstant.rawValue)")
                    .font(.headline)

                Text("Value: \(selectedConstant.displayValue)")
                    .font(.system(.body, design: .monospaced))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)

            VStack(spacing: 12) {
                Text("maxWidth Behavior:")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("Hello World")
                    .frame(maxWidth: selectedConstant.value)
                    .background(Color.blue.opacity(0.3))
                    .border(Color.blue, width: 2)

                Text("Long Text That Might Overflow")
                    .frame(maxWidth: selectedConstant.value)
                    .background(Color.green.opacity(0.3))
                    .border(Color.green, width: 2)
            }
            .padding()
            .background(Color.gray.opacity(0.05))
            .cornerRadius(12)

            VStack(spacing: 12) {
                Text("minWidth Behavior:")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)

                if selectedConstant.value != .infinity && selectedConstant.value != .greatestFiniteMagnitude {
                    Text("Short")
                        .frame(minWidth: selectedConstant.value)
                        .background(Color.orange.opacity(0.3))
                        .border(Color.orange, width: 2)

                    Text("Longer Text Here")
                        .frame(minWidth: selectedConstant.value)
                        .background(Color.purple.opacity(0.3))
                        .border(Color.purple, width: 2)
                } else {
                    Text("⚠️ minWidth cannot be infinity")
                        .font(.subheadline)
                        .foregroundColor(.orange)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(8)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.05))
            .cornerRadius(12)
        }
        .padding()
        .background(Color.blue.opacity(0.05))
        .cornerRadius(12)
    }
}

#Preview {
    FlexibleFramesConstantsComparison()
}
