import SwiftUI

struct FlexibleFramesConflictsMultipleFrames: View {
        var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Stacked Frames",
                description: "Multiple frames wrap each other"
            ) {
                VStack(spacing: 10) {
                    Text("Wrapped")
                        .background(Color.red)
                        .frame(width: 100)
                        .background(Color.green.opacity(0.3))
                        .frame(width: 150)
                        .background(Color.blue.opacity(0.3))
                        .frame(width: 200)
                        .background(Color.purple.opacity(0.3))

                    Text("Hierarchy: 200pt (purple) → 150pt (blue) → 100pt (green) → Text (red)")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("Result: Outer frame (200pt) determines final size")
                        .font(.caption)
                        .fontWeight(.bold)
                }
            }
        }
    }
}

#Preview {
    FlexibleFramesConflictsMultipleFrames()
}
