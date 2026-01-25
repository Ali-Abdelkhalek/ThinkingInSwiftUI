import SwiftUI

struct FlexibleFramesTwoPassExplanation: View {
        var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Pass 1: Proposing to Subview")
                .font(.headline)
                .foregroundColor(.blue)

            VStack(alignment: .leading, spacing: 8) {
                bulletPoint("Frame receives proposal from parent")
                bulletPoint("Frame clamps by min/max parameters")
                bulletPoint("Frame proposes clamped size to subview")
            }
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(8)

            Text("Pass 2: Reporting Own Size")
                .font(.headline)
                .foregroundColor(.green)

            VStack(alignment: .leading, spacing: 8) {
                bulletPoint("Subview reports its size")
                bulletPoint("Frame determines its own size")
                bulletPoint("Missing boundaries substituted with subview size")
                bulletPoint("Frame reports size to parent")
            }
            .padding()
            .background(Color.green.opacity(0.1))
            .cornerRadius(8)

            Text("Example: .frame(maxWidth: 250) with 100pt subview")
                .font(.headline)

            VStack(alignment: .leading, spacing: 6) {
                Text("• Proposed: 300 → Clamped: 250 → Proposes to child: 250")
                    .font(.caption)
                Text("• Child reports: 100")
                    .font(.caption)
                Text("• Frame size: max(100, min(250, 300)) = 250")
                    .font(.caption)
                    .fontWeight(.bold)
            }
            .padding()
            .background(Color.orange.opacity(0.1))
            .cornerRadius(8)
        }
    }
}

#Preview {
    FlexibleFramesTwoPassExplanation()
}
