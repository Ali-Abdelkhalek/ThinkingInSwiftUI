import SwiftUI

struct FlexibleFramesCombinedExamples: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "1. Fill All Available Space",
                description: "Takes all proposed width and height",
                code: ".frame(maxWidth: .infinity, maxHeight: .infinity)"
            ) {
                Text("Fills Everything")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.blue.opacity(0.3))
                    .border(Color.blue, width: 2)
                    .frame(height: 150)
            }

            exampleCard(
                title: "2. Accept Proposed Size",
                description: "Accepts exactly what's proposed for both dimensions",
                code: ".frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)"
            ) {
                Text("Exact\nProposed")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .background(Color.purple.opacity(0.3))
                    .border(Color.purple, width: 2)
                    .frame(height: 100)
            }

            exampleCard(
                title: "3. Constrained Both Dimensions",
                description: "Width: 100-250, Height: 50-150",
                code: ".frame(minWidth: 100, maxWidth: 250, minHeight: 50, maxHeight: 150)"
            ) {
                Text("Constrained\nBox")
                    .frame(minWidth: 100, maxWidth: 250, minHeight: 50, maxHeight: 150)
                    .background(Color.green.opacity(0.3))
                    .border(Color.green, width: 2)
            }

            exampleCard(
                title: "4. Ideal Width + Max Height",
                description: "Uses ideal width when nil proposed, fills height",
                code: ".frame(idealWidth: 200, maxHeight: .infinity)"
            ) {
                Text("Ideal W\nMax H")
                    .frame(idealWidth: 200, maxHeight: .infinity)
                    .background(Color.orange.opacity(0.3))
                    .border(Color.orange, width: 2)
                    .frame(height: 100)
            }
        }
    }

}

#Preview {
    FlexibleFramesCombinedExamples()
}
