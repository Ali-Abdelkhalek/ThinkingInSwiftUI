import SwiftUI

struct FlexibleFramesAlignmentExamples: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "1. Default Alignment (Center)",
                description: "Subview centered in frame",
                code: ".frame(width: 200, height: 100)"
            ) {
                Text("Centered")
                    .background(Color.red)
                    .frame(width: 200, height: 100)
                    .background(Color.gray.opacity(0.3))
                    .border(Color.gray, width: 2)
            }

            exampleCard(
                title: "2. Top Leading Alignment",
                description: "Subview positioned at top-leading corner",
                code: ".frame(width: 200, height: 100, alignment: .topLeading)"
            ) {
                Text("Top Leading")
                    .background(Color.red)
                    .frame(width: 200, height: 100, alignment: .topLeading)
                    .background(Color.gray.opacity(0.3))
                    .border(Color.gray, width: 2)
            }

            exampleCard(
                title: "3. Bottom Trailing Alignment",
                description: "Subview positioned at bottom-trailing corner",
                code: ".frame(width: 200, height: 100, alignment: .bottomTrailing)"
            ) {
                Text("Bottom Trailing")
                    .background(Color.red)
                    .frame(width: 200, height: 100, alignment: .bottomTrailing)
                    .background(Color.gray.opacity(0.3))
                    .border(Color.gray, width: 2)
            }

            exampleCard(
                title: "4. Flexible Frame with Alignment",
                description: "maxWidth with leading alignment",
                code: ".frame(maxWidth: .infinity, alignment: .leading)"
            ) {
                Text("Leading")
                    .background(Color.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.3))
                    .border(Color.gray, width: 2)
            }
        }
    }

}

#Preview {
    FlexibleFramesAlignmentExamples()
}
