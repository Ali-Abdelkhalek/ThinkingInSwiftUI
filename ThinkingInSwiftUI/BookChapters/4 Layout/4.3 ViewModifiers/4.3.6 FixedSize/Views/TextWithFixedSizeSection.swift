//
//  TextWithFixedSizeSection.swift
//  ThinkingInSwiftUI
//
//  Shows how text behaves with fixedSize()
//

import SwiftUI

struct TextWithFixedSizeSection: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Text at Ideal Size (Can Overflow!)",
                description: "fixedSize() makes text its full ideal width",
                code: "Text(\"This is a longer text\").fixedSize().frame(width: 50)"
            ) {
                VStack(spacing: 16) {
                    VStack(spacing: 8) {
                        Text("Frame: 25pt, Text with fixedSize()")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("This is a longer text")
                            .fixedSize()
                            .frame(width: 25)
                            .background(Color.blue.opacity(0.2))
                            .border(Color.blue, width: 2)

                        Text("Text overflows! Becomes ideal size (~150pt)")
                            .font(.caption)
                            .foregroundColor(.orange)
                    }

                    VStack(spacing: 8) {
                        Text("Frame: 50pt, Text with fixedSize()")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("This is a longer text")
                            .fixedSize()
                            .frame(width: 50)
                            .background(Color.green.opacity(0.2))
                            .border(Color.green, width: 2)

                        Text("Still overflows! Same ideal size")
                            .font(.caption)
                            .foregroundColor(.orange)
                    }

                    VStack(spacing: 8) {
                        Text("Frame: 100pt, Text with fixedSize()")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("This is a longer text")
                            .fixedSize()
                            .frame(width: 100)
                            .background(Color.purple.opacity(0.2))
                            .border(Color.purple, width: 2)

                        Text("Still overflows! Always ideal size")
                            .font(.caption)
                            .foregroundColor(.orange)
                    }

                    Text("With fixedSize(), text ALWAYS becomes its ideal size, regardless of frame!")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(8)
                }
            }

            exampleCard(
                title: "Views Aren't Clipped by Default",
                description: "Overflow is visible unless you use .clipped()",
                code: ""
            ) {
                VStack(spacing: 16) {
                    VStack(spacing: 8) {
                        Text("Without .clipped():")
                            .font(.caption)
                            .fontWeight(.semibold)

                        Text("This is a longer text")
                            .fixedSize()
                            .frame(width: 50)
                            .background(Color.red.opacity(0.2))
                            .border(Color.red, width: 2)

                        Text("Text extends beyond border")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    VStack(spacing: 8) {
                        Text("With .clipped():")
                            .font(.caption)
                            .fontWeight(.semibold)

                        Text("This is a longer text")
                            .fixedSize()
                            .frame(width: 50)
                            .background(Color.green.opacity(0.2))
                            .border(Color.green, width: 2)
                            .clipped()

                        Text("Text cropped at border")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        TextWithFixedSizeSection()
            .padding()
    }
}
