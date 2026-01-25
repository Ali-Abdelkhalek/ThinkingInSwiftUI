//
//  LayoutAlgorithm.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - The Layout Algorithm
//

import SwiftUI

struct LayoutAlgorithmView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 30) {
                Text("The Layout Algorithm")
                    .font(.title)
                    .bold()

                howLayoutWorksSection
                exampleSection
                fourStepsSection
                keyPrincipleSection
                detailedExampleSection
            }
            .padding()
        }
    }

    // MARK: - Sections

    private var howLayoutWorksSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("How SwiftUI's Layout Works")
                    .font(.headline)

                Text("""
                SwiftUI's layout algorithm is straightforward:

                1. Parent proposes a size to child
                2. Child determines its own size (based on proposal)
                3. Child reports size back to parent
                4. Parent places child

                The goal: Give each view a position and a size.
                """)
                .font(.caption)
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }

    private var exampleSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("Example: VStack with Image and Text")
                    .font(.headline)

                VStack(spacing: 10) {
                    Image(systemName: "globe")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                    Text("Hello, World!")
                }
                .padding()
                .border(Color.blue, width: 2)

                Text("""
                Layout Steps:

                1. Window proposes safe area size to VStack
                2. VStack proposes size to Image
                   → Image reports its size (based on globe symbol)
                3. VStack proposes size to Text
                   → Text reports its size (based on string)
                4. VStack places subviews beneath each other
                5. VStack computes own size (union of frames)
                6. VStack reports back to window
                """)
                .font(.caption)
                .foregroundColor(.secondary)
            }
        }
    }

    private var fourStepsSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("The Four Steps (Formal)")
                    .font(.headline)

                VStack(alignment: .leading, spacing: 8) {
                    StepView(
                        step: "1",
                        title: "Parent proposes a size",
                        description: "Container asks: 'I have this much space, how big do you want to be?'"
                    )

                    StepView(
                        step: "2",
                        title: "Child determines its size",
                        description: "Recursively starts at step 1 if it has subviews"
                    )

                    StepView(
                        step: "3",
                        title: "Child reports size",
                        description: "This is DEFINITIVE - parent cannot change it unilaterally"
                    )

                    StepView(
                        step: "4",
                        title: "Parent places child",
                        description: "Using alignment and child's alignment guides"
                    )
                }
            }
        }
    }

    private var keyPrincipleSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("Key Principle")
                    .font(.headline)

                Text("The size reported by the subview in step 3 is the DEFINITIVE size. The parent cannot alter this size unilaterally. It could propose a different size (go back to step 2), but at the end of the day, the subview determines its own size.")
                    .font(.caption)
                    .padding(8)
                    .background(Color.orange.opacity(0.2))
                    .cornerRadius(5)

                Text("This is why sometimes views render 'out of bounds' - the child can report a larger size than proposed, and the parent must accept it!")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }

    private var detailedExampleSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("Detailed Example")
                    .font(.headline)

                Text("Favorite")
                    .padding(10)
                    .background(Color.teal)
                    .border(Color.red, width: 2)

                Text("""
                Code:
                Text("Favorite")
                    .padding(10)
                    .background(Color.teal)

                Window size: 320×480

                Steps:
                1. System proposes 320×480 to background
                2. Background proposes 320×480 to padding
                3. Padding subtracts 10pt edges → proposes 300×460 to text
                4. Text reports 51×17
                5. Padding adds 10pt edges → reports 71×37
                6. Background proposes 71×37 to Color
                7. Color accepts → reports 71×37
                8. Background reports 71×37

                Result: Final view is 71×37 centered in 320×480
                """)
                .font(.system(.caption, design: .monospaced))
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }
}

#Preview {
    LayoutAlgorithmView()
}

