//
//  FlexibleFramesAdvancedConstants.swift
//  ThinkingInSwiftUI
//
//  Exploring CGFloat constants with flexible frames
//  Shows what happens with .infinity, .greatestFiniteMagnitude, mathematical constants, etc.
//

import SwiftUI

struct FlexibleFramesAdvancedConstants: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                sectionHeader("Special CGFloat Constants")

                specialConstantsSection

                sectionHeader("Mathematical Constants")

                mathematicalConstantsSection

                sectionHeader("Extreme Values")

                extremeValuesSection

                sectionHeader("Practical vs Impractical")

                practicalGuidanceSection

                sectionHeader("Comparison Table")

                comparisonTable
            }
            .padding()
        }
    }

    // MARK: - Special Constants

    private var specialConstantsSection: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "1. CGFloat.infinity",
                description: "The standard way to request maximum available space. SwiftUI treats this specially.",
                value: "∞ (infinity)",
                code: ".frame(maxWidth: .infinity)"
            ) {
                Text("Hello")
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.3))
                    .border(Color.blue, width: 2)
            }

            exampleCard(
                title: "2. CGFloat.greatestFiniteMagnitude",
                description: "Largest representable finite number. Behaves ALMOST like infinity but is technically finite.",
                value: "1.7976931348623157e+308",
                code: ".frame(maxWidth: .greatestFiniteMagnitude)"
            ) {
                Text("Hello")
                    .frame(maxWidth: .greatestFiniteMagnitude)
                    .background(Color.green.opacity(0.3))
                    .border(Color.green, width: 2)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Comparison:")
                    .font(.headline)

                Text("• .infinity: True mathematical infinity, SwiftUI's preferred way")
                Text("• .greatestFiniteMagnitude: 1.79769313 × 10³⁰⁸ - effectively infinite for UI purposes")
                Text("• Both fill available space in practice")
                Text("• Use .infinity - it's clearer and more idiomatic")
            }
            .font(.caption)
            .padding()
            .background(Color.yellow.opacity(0.1))
            .cornerRadius(8)
        }
    }

    // MARK: - Mathematical Constants

    private var mathematicalConstantsSection: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "1. CGFloat.pi",
                description: "The value of π ≈ 3.14159. Creates a 3.14pt constraint - rarely useful for layout.",
                value: "≈ 3.14159",
                code: ".frame(maxWidth: .pi)"
            ) {
                VStack(spacing: 10) {
                    Text("Wide Text Here")
                        .frame(maxWidth: .pi)
                        .background(Color.orange.opacity(0.3))
                        .border(Color.orange, width: 2)

                    Text("maxWidth is only 3.14pts - text can't fit!")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "2. Custom Mathematical Values",
                description: "You can use any mathematical expression",
                value: "Various",
                code: ".frame(maxWidth: CGFloat.pi * 50)"
            ) {
                VStack(spacing: 10) {
                    Text("Pi × 50")
                        .frame(maxWidth: CGFloat.pi * 50)
                        .background(Color.purple.opacity(0.3))
                        .border(Color.purple, width: 2)

                    Text("Pi × 100")
                        .frame(maxWidth: CGFloat.pi * 100)
                        .background(Color.purple.opacity(0.3))
                        .border(Color.purple, width: 2)

                    Text("Width = π × multiplier ≈ \(Int(CGFloat.pi * 50)) and \(Int(CGFloat.pi * 100)) pts")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }

    // MARK: - Extreme Values

    private var extremeValuesSection: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "1. CGFloat.leastNormalMagnitude",
                description: "Smallest positive normal value. Creates an effectively zero-width constraint.",
                value: "2.2250738585072014e-308",
                code: ".frame(maxWidth: .leastNormalMagnitude)"
            ) {
                VStack(spacing: 10) {
                    Text("Tiny")
                        .frame(maxWidth: .leastNormalMagnitude)
                        .background(Color.red.opacity(0.3))
                        .border(Color.red, width: 2)

                    Text("maxWidth ≈ 0 - uses text's natural width")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "2. CGFloat.leastNonzeroMagnitude",
                description: "Smallest positive nonzero value. Even tinier than leastNormalMagnitude.",
                value: "4.9406564584124654e-324",
                code: ".frame(maxWidth: .leastNonzeroMagnitude)"
            ) {
                VStack(spacing: 10) {
                    Text("Ultra Tiny")
                        .frame(maxWidth: .leastNonzeroMagnitude)
                        .background(Color.pink.opacity(0.3))
                        .border(Color.pink, width: 2)

                    Text("maxWidth ≈ 0 - uses text's natural width")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "3. Zero",
                description: "Explicitly zero. Common in the pattern .frame(minWidth: 0, maxWidth: .infinity)",
                value: "0",
                code: ".frame(minWidth: 0)"
            ) {
                VStack(spacing: 10) {
                    Text("Zero Min")
                        .frame(minWidth: 0)
                        .background(Color.cyan.opacity(0.3))
                        .border(Color.cyan, width: 2)

                    Text("minWidth: 0 means no minimum constraint")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "4. Negative Values",
                description: "Technically allowed but creates weird behavior. Don't use in production!",
                value: "-50",
                code: ".frame(maxWidth: -50)"
            ) {
                VStack(spacing: 10) {
                    Text("Negative?")
                        .frame(maxWidth: -50)
                        .background(Color.red.opacity(0.3))
                        .border(Color.red, width: 2)

                    Text("⚠️ Negative values create undefined behavior")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
        }
    }

    // MARK: - Practical Guidance

    private var practicalGuidanceSection: some View {
        VStack(spacing: 16) {
            practicalCard(
                title: "✅ PRACTICAL - Use These",
                items: [
                    (".infinity", "For maximum available space", Color.green),
                    ("0", "For minimum constraints (minWidth: 0)", Color.green),
                    ("Concrete values", "44, 100, 200, etc. for specific sizes", Color.green)
                ]
            )

            practicalCard(
                title: "⚠️ THEORETICAL - Don't Use",
                items: [
                    (".greatestFiniteMagnitude", "Use .infinity instead", Color.orange),
                    (".pi", "Too small for layout (3.14pts)", Color.orange),
                    (".leastNormalMagnitude", "Essentially zero, just use 0", Color.orange),
                    (".leastNonzeroMagnitude", "Essentially zero, just use 0", Color.orange)
                ]
            )

            practicalCard(
                title: "❌ INVALID - Never Use",
                items: [
                    ("Negative values", "Creates undefined behavior", Color.red),
                    (".nan", "Not a number - will crash or behave unpredictably", Color.red)
                ]
            )
        }
    }

    // MARK: - Comparison Table

    private var comparisonTable: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Constants Reference Table")
                .font(.headline)

            VStack(spacing: 0) {
                tableHeader
                tableDivider
                tableRow(constant: ".infinity", value: "∞", practical: "✅ Yes", useCase: "Fill available space")
                tableDivider
                tableRow(constant: ".greatestFiniteMagnitude", value: "1.8e+308", practical: "⚠️ No", useCase: "Use .infinity instead")
                tableDivider
                tableRow(constant: ".pi", value: "3.14159", practical: "❌ No", useCase: "Too small for UI")
                tableDivider
                tableRow(constant: ".leastNormalMagnitude", value: "2.2e-308", practical: "❌ No", useCase: "Effectively zero")
                tableDivider
                tableRow(constant: ".leastNonzeroMagnitude", value: "4.9e-324", practical: "❌ No", useCase: "Effectively zero")
                tableDivider
                tableRow(constant: "0", value: "0", practical: "✅ Yes", useCase: "No minimum constraint")
                tableDivider
                tableRow(constant: "44, 100, etc.", value: "Exact", practical: "✅ Yes", useCase: "Specific sizes")
            }
            .font(.system(.caption, design: .monospaced))
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }

    private var tableHeader: some View {
        HStack(spacing: 8) {
            Text("Constant")
                .frame(width: 140, alignment: .leading)
                .fontWeight(.bold)
            Text("Value")
                .frame(width: 80, alignment: .leading)
                .fontWeight(.bold)
            Text("Practical?")
                .frame(width: 70, alignment: .leading)
                .fontWeight(.bold)
            Text("Use Case")
                .frame(maxWidth: .infinity, alignment: .leading)
                .fontWeight(.bold)
        }
        .padding(.vertical, 8)
        .background(Color.gray.opacity(0.2))
    }

    private func tableRow(constant: String, value: String, practical: String, useCase: String) -> some View {
        HStack(spacing: 8) {
            Text(constant)
                .frame(width: 140, alignment: .leading)
            Text(value)
                .frame(width: 80, alignment: .leading)
            Text(practical)
                .frame(width: 70, alignment: .leading)
            Text(useCase)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 6)
        .background(Color.white.opacity(0.01))
    }

    private var tableDivider: some View {
        Divider()
            .background(Color.gray.opacity(0.3))
    }

    // MARK: - Helper Views

    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.title2)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top)
    }

    private func exampleCard<Content: View>(
        title: String,
        description: String,
        value: String,
        code: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)

            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary)

            HStack {
                Text("Value:")
                    .fontWeight(.semibold)
                Text(value)
                    .font(.system(.caption, design: .monospaced))
            }
            .font(.caption)

            Text(code)
                .font(.system(.caption, design: .monospaced))
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(4)

            content()
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }

    private func practicalCard(
        title: String,
        items: [(constant: String, description: String, color: Color)]
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)

            ForEach(items.indices, id: \.self) { index in
                HStack(alignment: .top, spacing: 8) {
                    Circle()
                        .fill(items[index].color)
                        .frame(width: 8, height: 8)
                        .padding(.top, 5)

                    VStack(alignment: .leading, spacing: 2) {
                        Text(items[index].constant)
                            .font(.system(.body, design: .monospaced))
                            .fontWeight(.semibold)
                        Text(items[index].description)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
}

// MARK: - Interactive Comparison

struct ConstantsComparison: View {
    @State private var selectedConstant: ConstantOption = .infinity

    enum ConstantOption: String, CaseIterable {
        case infinity = "infinity"
        case greatestFinite = "greatestFiniteMagnitude"
        case pi = "pi"
        case leastNormal = "leastNormalMagnitude"
        case leastNonzero = "leastNonzeroMagnitude"
        case zero = "0"
        case custom100 = "100"
        case custom200 = "200"

        var value: CGFloat {
            switch self {
            case .infinity: return .infinity
            case .greatestFinite: return .greatestFiniteMagnitude
            case .pi: return .pi
            case .leastNormal: return .leastNormalMagnitude
            case .leastNonzero: return .leastNonzeroMagnitude
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
            case .leastNormal: return "2.2e-308"
            case .leastNonzero: return "4.9e-324"
            case .zero: return "0"
            case .custom100: return "100"
            case .custom200: return "200"
            }
        }
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Interactive Constants Comparison")
                .font(.title2)
                .fontWeight(.bold)

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

                Text("Short")
                    .frame(minWidth: selectedConstant.value)
                    .background(Color.orange.opacity(0.3))
                    .border(Color.orange, width: 2)

                Text("Longer Text Here")
                    .frame(minWidth: selectedConstant.value)
                    .background(Color.purple.opacity(0.3))
                    .border(Color.purple, width: 2)
            }
            .padding()
            .background(Color.gray.opacity(0.05))
            .cornerRadius(12)

            Spacer()
        }
        .padding()
    }
}

// MARK: - Preview

#Preview("Constants Guide") {
    FlexibleFramesAdvancedConstants()
}

#Preview("Interactive Comparison") {
    ConstantsComparison()
}

/*
 CGFLOAT CONSTANTS REFERENCE:

 ## Special Values:

 1. **.infinity**
    - Value: ∞ (mathematical infinity)
    - Use: Maximum available space in flexible frames
    - Practical: ✅ YES - Standard SwiftUI pattern
    - Example: .frame(maxWidth: .infinity)

 2. **.greatestFiniteMagnitude**
    - Value: 1.7976931348623157e+308 (largest representable finite number)
    - Use: Technically finite but effectively infinite for UI
    - Practical: ⚠️ NO - Use .infinity instead for clarity
    - Why exists: Represents the largest number a Double/CGFloat can hold

 3. **.pi**
    - Value: 3.14159265358979323846...
    - Use: Mathematical calculations
    - Practical: ❌ NO - Too small for UI layout (3.14 points)
    - Example: Might use in calculations like .frame(width: .pi * 100)

 4. **.leastNormalMagnitude**
    - Value: 2.2250738585072014e-308 (smallest positive normal value)
    - Use: Scientific computing, not UI
    - Practical: ❌ NO - Effectively zero for UI purposes
    - Use 0 instead

 5. **.leastNonzeroMagnitude**
    - Value: 4.9406564584124654e-324 (smallest positive nonzero value)
    - Use: Scientific computing edge cases
    - Practical: ❌ NO - Even tinier than leastNormalMagnitude
    - Use 0 instead

 6. **.nan (Not a Number)**
    - Value: NaN
    - Use: Error handling in calculations
    - Practical: ❌ NEVER - Will cause crashes or undefined behavior in frames

 ## Why These Constants Exist:

 CGFloat is a Double on modern platforms, so it inherits all Double constants:
 - .infinity and .greatestFiniteMagnitude: For representing unbounded values
 - .pi: Mathematical constant
 - .leastNormalMagnitude & .leastNonzeroMagnitude: IEEE 754 floating-point spec
 - .nan: Error representation

 ## Best Practices for Frames:

 ✅ DO USE:
 - .infinity for max constraints
 - 0 for min constraints
 - Concrete values (44, 100, 200, etc.)

 ❌ DON'T USE:
 - .greatestFiniteMagnitude (use .infinity)
 - .pi (unless in calculations)
 - .leastNormalMagnitude (use 0)
 - .leastNonzeroMagnitude (use 0)
 - .nan (never!)
 - Negative values (undefined behavior)

 ## Common Patterns:

 .frame(maxWidth: .infinity)                    // Fill width
 .frame(minWidth: 0, maxWidth: .infinity)       // Accept proposed width
 .frame(minWidth: 44, minHeight: 44)            // Minimum tappable area
 .frame(width: CGFloat.pi * 100, height: 100)   // Math in calculations (rare)
 */
