//
//  ClippedOverflowExamplesSection.swift
//  ThinkingInSwiftUI
//
//  Examples of overflow scenarios
//

import SwiftUI

struct ClippedOverflowExamplesSection: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Image Overflow",
                description: "Image larger than frame",
                code: ".frame(width: 100, height: 100).clipped()"
            ) {
                VStack(spacing: 12) {
                    HStack(spacing: 20) {
                        VStack(spacing: 8) {
                            Text("Without")
                                .font(.caption)

                            Circle()
                                .fill(Color.blue)
                                .frame(width: 150, height: 150)
                                .frame(width: 100, height: 100)
                                .border(Color.red, width: 2)
                        }

                        VStack(spacing: 8) {
                            Text("With .clipped()")
                                .font(.caption)

                            Circle()
                                .fill(Color.blue)
                                .frame(width: 150, height: 150)
                                .frame(width: 100, height: 100)
                                .clipped()
                                .border(Color.red, width: 2)
                        }
                    }

                    Text("Left: Circle overflows visually. Right: Circle cropped at red border.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Shape Overflow",
                description: "Common with aspectRatio and .fill mode",
                code: ".aspectRatio(contentMode: .fill).clipped()"
            ) {
                VStack(spacing: 12) {
                    HStack(spacing: 20) {
                        VStack(spacing: 8) {
                            Text("Without")
                                .font(.caption)

                            Rectangle()
                                .fill(Color.green)
                                .aspectRatio(2, contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .border(Color.red, width: 2)
                        }

                        VStack(spacing: 8) {
                            Text("With .clipped()")
                                .font(.caption)

                            Rectangle()
                                .fill(Color.green)
                                .aspectRatio(2, contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipped()
                                .border(Color.red, width: 2)
                        }
                    }

                    Text("With .fill mode, content often overflows - use .clipped() to crop")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        ClippedOverflowExamplesSection()
            .padding()
    }
}
