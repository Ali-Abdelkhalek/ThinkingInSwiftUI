import SwiftUI

struct FlexibleFramesConflictsParentChild: View {
        var body: some View {
        VStack(spacing: 20) {
            Text("Common conflict scenarios")
                .font(.headline)

            exampleCard(
                title: "Parent offers 100pt, child wants 200pt",
                description: "Text with minWidth larger than container"
            ) {
                VStack(spacing: 8) {
                    Text("Long Text Content")
                        .frame(minWidth: 200)
                        .background(Color.green.opacity(0.3))
                        .border(Color.green, width: 2)
                        .frame(width: 100)
                        .background(Color.blue.opacity(0.3))
                        .border(Color.blue, width: 2)

                    Text("Child's minWidth wins: 200pt")
                        .font(.caption)
                        .fontWeight(.bold)
                }
            }

            exampleCard(
                title: "Parent offers 200pt, child wants 50pt",
                description: "Using maxWidth: .infinity"
            ) {
                VStack(spacing: 8) {
                    Text("Hi")
                        .frame(maxWidth: .infinity)
                        .background(Color.purple.opacity(0.3))
                        .border(Color.purple, width: 2)
                        .frame(width: 200)

                    Text("maxWidth fills all proposed space: 200pt")
                        .font(.caption)
                        .fontWeight(.bold)
                }
            }
        }
    }
}

#Preview {
    FlexibleFramesConflictsParentChild()
}
