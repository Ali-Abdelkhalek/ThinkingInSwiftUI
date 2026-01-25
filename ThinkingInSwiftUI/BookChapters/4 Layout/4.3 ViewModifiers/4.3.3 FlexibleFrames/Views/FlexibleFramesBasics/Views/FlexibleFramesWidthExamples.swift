import SwiftUI

struct FlexibleFramesWidthExamples: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "1. maxWidth Only",
                description: "Frame becomes at least proposed width, or subview width if wider",
                code: ".frame(maxWidth: .infinity)"
            ) {
                Text("Short")
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.3))
                    .border(Color.blue, width: 2)
            }

            exampleCard(
                title: "2. maxWidth with Fixed Value",
                description: "Frame becomes min(proposed, maxWidth) or subview width if smaller",
                code: ".frame(maxWidth: 150)"
            ) {
                VStack(spacing: 10) {
                    Text("Short")
                        .frame(maxWidth: 150)
                        .background(Color.green.opacity(0.3))
                        .border(Color.green, width: 2)

                    Text("Very Long Text That Exceeds 150")
                        .frame(maxWidth: 150)
                        .background(Color.green.opacity(0.3))
                        .border(Color.green, width: 2)
                }
            }

            exampleCard(
                title: "3. minWidth Only",
                description: "Frame becomes at least minWidth, at most subview width",
                code: ".frame(minWidth: 200)"
            ) {
                VStack(spacing: 10) {
                    Text("Short")
                        .frame(minWidth: 200)
                        .background(Color.orange.opacity(0.3))
                        .border(Color.orange, width: 2)

                    Text("Very Long Text That Exceeds 200 Points Width")
                        .frame(minWidth: 200)
                        .background(Color.orange.opacity(0.3))
                        .border(Color.orange, width: 2)
                }
            }

            exampleCard(
                title: "4. minWidth + maxWidth",
                description: "Frame becomes exactly proposed width (clamped between min and max)",
                code: ".frame(minWidth: 0, maxWidth: .infinity)"
            ) {
                Text("Any Size")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.purple.opacity(0.3))
                    .border(Color.purple, width: 2)
            }

            exampleCard(
                title: "5. minWidth + maxWidth (Fixed Range)",
                description: "Frame width clamped between 100-250",
                code: ".frame(minWidth: 100, maxWidth: 250)"
            ) {
                VStack(spacing: 10) {
                    Text("Hi")
                        .frame(minWidth: 100, maxWidth: 250)
                        .background(Color.pink.opacity(0.3))
                        .border(Color.pink, width: 2)

                    Text("Medium Text Here")
                        .frame(minWidth: 100, maxWidth: 250)
                        .background(Color.pink.opacity(0.3))
                        .border(Color.pink, width: 2)

                    Text("Very Long Text That Would Exceed 250 Points")
                        .frame(minWidth: 100, maxWidth: 250)
                        .background(Color.pink.opacity(0.3))
                        .border(Color.pink, width: 2)
                }
            }
        }
    }
}

#Preview {
    FlexibleFramesWidthExamples()
}
