import SwiftUI

struct FlexibleFramesConflictsFixedChild: View {
        var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Child Larger Than Parent Proposal",
                description: "Parent proposes 100pt, child demands 200pt"
            ) {
                VStack(spacing: 10) {
                    Text("Hello World")
                        .background(Color.red)
                        .frame(width: 200)  // Child demands 200
                        .background(Color.orange.opacity(0.3))
                        .border(Color.orange, width: 2)
                        .frame(width: 100)  // Parent offers only 100
                        .background(Color.blue.opacity(0.3))
                        .border(Color.blue, width: 2)

                    Text("Result: Child overflows parent! Inner frame reports 200, outer frame also becomes 200.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Text("Key Insight: Fixed frames always win - they ignore all proposals")
                .font(.caption)
                .foregroundColor(.orange)
                .padding()
                .background(Color.orange.opacity(0.1))
                .cornerRadius(8)
        }
    }
}

#Preview {
    FlexibleFramesConflictsFixedChild()
}
