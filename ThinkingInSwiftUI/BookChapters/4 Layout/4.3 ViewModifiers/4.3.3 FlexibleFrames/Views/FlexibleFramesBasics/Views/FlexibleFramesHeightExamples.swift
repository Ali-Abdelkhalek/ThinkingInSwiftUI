import SwiftUI

struct FlexibleFramesHeightExamples: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "1. maxHeight Only",
                description: "Frame becomes at least proposed height, or subview height if taller",
                code: ".frame(maxHeight: .infinity)"
            ) {
                HStack(spacing: 20) {
                    Text("Fills\nAvailable\nHeight")
                        .frame(maxHeight: .infinity)
                        .background(Color.blue.opacity(0.3))
                        .border(Color.blue, width: 2)

                    Text("Also\nFills")
                        .frame(maxHeight: .infinity)
                        .background(Color.blue.opacity(0.3))
                        .border(Color.blue, width: 2)
                }
                .frame(height: 150)
            }

            exampleCard(
                title: "2. minHeight Only",
                description: "Frame becomes at least minHeight, at most subview height",
                code: ".frame(minHeight: 100)"
            ) {
                HStack(spacing: 20) {
                    Text("Short")
                        .frame(minHeight: 100)
                        .background(Color.orange.opacity(0.3))
                        .border(Color.orange, width: 2)

                    Text("Tall\nText\nWith\nMany\nLines")
                        .frame(minHeight: 100)
                        .background(Color.orange.opacity(0.3))
                        .border(Color.orange, width: 2)
                }
            }

            exampleCard(
                title: "3. minHeight + maxHeight",
                description: "Frame becomes exactly proposed height (clamped)",
                code: ".frame(minHeight: 0, maxHeight: .infinity)"
            ) {
                Text("Accepts\nProposed\nHeight")
                    .frame(minHeight: 0, maxHeight: .infinity)
                    .background(Color.purple.opacity(0.3))
                    .border(Color.purple, width: 2)
                    .frame(height: 120)
            }
        }
    }
}

#Preview {
    FlexibleFramesHeightExamples()
}
