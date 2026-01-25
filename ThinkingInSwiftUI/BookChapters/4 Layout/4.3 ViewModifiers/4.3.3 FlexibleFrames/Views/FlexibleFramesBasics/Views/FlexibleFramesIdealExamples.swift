import SwiftUI

struct FlexibleFramesIdealExamples: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "1. idealWidth",
                description: "Used when nil is proposed for width. Frame proposes idealWidth to subview and reports it as own width",
                code: ".frame(idealWidth: 200)"
            ) {
                HStack {
                    Color.clear.frame(width: 0)
                    Text("Ideal")
                        .frame(idealWidth: 200)
                        .background(Color.cyan.opacity(0.3))
                        .border(Color.cyan, width: 2)
                }
            }

            exampleCard(
                title: "2. idealWidth + minWidth + maxWidth",
                description: "idealWidth used when nil proposed, otherwise clamped between min/max",
                code: ".frame(minWidth: 100, idealWidth: 200, maxWidth: 300)"
            ) {
                VStack(spacing: 10) {
                    Text("With Constraints")
                        .frame(minWidth: 100, idealWidth: 200, maxWidth: 300)
                        .background(Color.mint.opacity(0.3))
                        .border(Color.mint, width: 2)

                    Text("Explanation: If proposed nil → uses 200. If proposed 50 → becomes 100. If proposed 250 → becomes 250. If proposed 400 → becomes 300.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "3. idealHeight",
                description: "Used when nil is proposed for height",
                code: ".frame(idealHeight: 100)"
            ) {
                VStack {
                    Color.clear.frame(height: 0)
                    Text("Ideal\nHeight")
                        .frame(idealHeight: 100)
                        .background(Color.indigo.opacity(0.3))
                        .border(Color.indigo, width: 2)
                }
            }
        }
    }

}

#Preview {
    FlexibleFramesIdealExamples()
}
