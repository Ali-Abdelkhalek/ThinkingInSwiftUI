import SwiftUI

struct FlexibleFramesCommonPatterns: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Pattern: Full Width",
                description: "Make view span entire available width",
                code: ".frame(maxWidth: .infinity)"
            ) {
                Text("Full Width Button")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            exampleCard(
                title: "Pattern: Accept Proposed Width",
                description: "Ignore subview width, use proposed width",
                code: ".frame(minWidth: 0, maxWidth: .infinity)"
            ) {
                Text("Hi")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color.teal)
                    .foregroundColor(.white)
            }

            exampleCard(
                title: "Pattern: Minimum Size",
                description: "Ensure minimum tappable area",
                code: ".frame(minWidth: 44, minHeight: 44)"
            ) {
                Text("Tap")
                    .frame(minWidth: 44, minHeight: 44)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            exampleCard(
                title: "Pattern: Aspect Ratio Container",
                description: "Fill width, constrain height",
                code: ".frame(maxWidth: .infinity, maxHeight: 200)"
            ) {
                Color.blue
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .overlay(Text("Image Placeholder").foregroundColor(.white))
            }

            exampleCard(
                title: "Pattern: Centered Fixed Size",
                description: "Fixed size centered in available space",
                code: ".frame(width: 100, height: 100)"
            ) {
                Circle()
                    .fill(Color.orange)
                    .frame(width: 100, height: 100)
            }
        }
    }

}

#Preview {
    FlexibleFramesCommonPatterns()
}
