//
//  ClippedEmptySpaceExamplesSection.swift
//  ThinkingInSwiftUI
//
//  Examples showing empty space scenarios
//

import SwiftUI

struct ClippedEmptySpaceExamplesSection: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Empty Space Remains",
                description: "clipped() does NOT remove padding or empty areas",
                code: ".padding(50).clipped()"
            ) {
                VStack(spacing: 12) {
                    HStack(spacing: 20) {
                        VStack(spacing: 8) {
                            Text("Without")
                                .font(.caption)

                            Text("Text")
                                .background(Color.red.opacity(0.3))
                                .padding(50)
                                .background(Color.blue.opacity(0.1))
                                .border(Color.blue, width: 2)
                        }

                        VStack(spacing: 8) {
                            Text("With .clipped()")
                                .font(.caption)

                            Text("Text")
                                .background(Color.red.opacity(0.3))
                                .padding(50)
                                .background(Color.blue.opacity(0.1))
                                .border(Color.blue, width: 2)
                                .clipped()
                        }
                    }

                    Text("Identical! Padding/empty space is NOT removed by .clipped()")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "To Remove Empty Space: Use Different Approach",
                description: "fixedSize(), removing padding, or adjusting frame",
                code: ""
            ) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Problem: Too much empty space")
                        .fontWeight(.semibold)

                    Text("Text")
                        .background(Color.red.opacity(0.3))
                        .frame(width: 200)
                        .background(Color.blue.opacity(0.1))
                        .border(Color.blue, width: 2)

                    Text("❌ Wrong: .clipped() won't help")
                        .foregroundColor(.red)

                    Text("✅ Right solutions:")
                        .foregroundColor(.green)

                    VStack(alignment: .leading, spacing: 8) {
                        solutionItem("1", ".fixedSize() - shrink to content")
                        solutionItem("2", "Remove or reduce .frame() width")
                        solutionItem("3", "Remove unnecessary padding")
                        solutionItem("4", "Use appropriate alignment")
                    }
                    .font(.caption)
                }
            }
        }
    }

    private func solutionItem(_ number: String, _ text: String) -> some View {
        HStack(alignment: .top, spacing: 6) {
            Text("\(number).")
                .fontWeight(.semibold)
            Text(text)
        }
    }
}

#Preview {
    ScrollView {
        ClippedEmptySpaceExamplesSection()
            .padding()
    }
}
