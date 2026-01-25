import SwiftUI

struct FlexibleFramesSpecialConstants: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Understanding .infinity, 0, and other CGFloat constants")
                .font(.subheadline)
                .foregroundColor(.secondary)

            constantCard(
                title: ".infinity",
                value: "∞",
                usage: "Maximum available space",
                practical: true,
                description: "Standard SwiftUI pattern for flexible sizing"
            )

            constantCard(
                title: ".greatestFiniteMagnitude",
                value: "1.8e+308",
                usage: "Largest finite number",
                practical: false,
                description: "Use .infinity instead for clarity"
            )

            constantCard(
                title: "0 (Zero)",
                value: "0",
                usage: "Explicit minimum boundary",
                practical: true,
                description: "Frame can be 0 or larger"
            )
            
            Text("Note: minWidth: 0 alone is useless (0 is the default minimum). It only affects layout when combined with maxWidth: .infinity to create \"accept exactly proposed size\" behavior.")
                .font(.caption)
                .foregroundColor(.orange)
                .padding(8)
                .background(Color.orange.opacity(0.1))
                .cornerRadius(6)


            constantCard(
                title: ".pi",
                value: "3.14159...",
                usage: "Mathematical calculations",
                practical: false,
                description: "Too small for UI layout (3.14 points)"
            )

            Text("Best Practice: Use .infinity for max constraints, 0 for min constraints, and concrete values for fixed sizes")
                .font(.caption)
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(8)
        }
    }
}

#Preview {
    FlexibleFramesSpecialConstants()
}
