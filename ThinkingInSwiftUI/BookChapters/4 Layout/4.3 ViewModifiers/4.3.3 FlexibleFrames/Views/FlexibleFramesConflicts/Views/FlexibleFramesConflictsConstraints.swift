import SwiftUI

struct FlexibleFramesConflictsConstraints: View {
        var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Impossible Constraint: min > max",
                description: "When minWidth > maxWidth"
            ) {
                VStack(spacing: 10) {
                    Text("Conflict!")
                        .frame(minWidth: 200, maxWidth: 100)
                        .background(Color.orange.opacity(0.3))
                        .border(Color.orange, width: 2)

                    Text("minWidth: 200, maxWidth: 100")
                        .font(.caption)
                        .fontDesign(.monospaced)

                    Text("Result: SwiftUI uses minWidth (200pt)")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
            }

            Text("Rule: When min > max, SwiftUI prioritizes min")
                .font(.caption)
                .foregroundColor(.orange)
                .padding()
                .background(Color.orange.opacity(0.1))
                .cornerRadius(8)
        }
    }
}

#Preview {
    FlexibleFramesConflictsConstraints()
}
