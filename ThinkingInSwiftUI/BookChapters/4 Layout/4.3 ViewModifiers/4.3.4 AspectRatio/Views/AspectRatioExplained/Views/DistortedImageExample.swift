//
//  DistortedImageExample.swift
//  ThinkingInSwiftUI
//
//  Shows the problem of distorted images without aspectRatio
//

import SwiftUI

struct DistortedImageExample: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "WITHOUT aspectRatio - Image Gets Distorted",
                description: "Resizable image accepts proposal directly",
                code: "Color.blue.resizable()"
            ) {
                VStack(spacing: 12) {
                    // Simulating an image with Color
                    Color.blue
                        .overlay(
                            Text("Original: 100×30\nProposed: 200×200\nResult: 200×200")
                                .font(.caption)
                                .foregroundColor(.white)
                        )
                        .frame(width: 200, height: 200)
                        .border(Color.red, width: 2)

                    Text("Container proposes 200×200 → Image accepts 200×200 → DISTORTED!")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }

            exampleCard(
                title: "Layout Steps (Without aspectRatio)",
                description: "Direct proposal to resizable image",
                code: ""
            ) {
                VStack(alignment: .leading, spacing: 6) {
                    layoutStep("1", "Container proposes 200×200 to resizable image")
                    layoutStep("2", "Resizable image accepts 200×200")
                    layoutStep("3", "Image is stretched/squashed to fit → DISTORTED")
                }
                .font(.system(.caption, design: .monospaced))
            }
        }
    }
}

#Preview {
    ScrollView {
        DistortedImageExample()
            .padding()
    }
}
