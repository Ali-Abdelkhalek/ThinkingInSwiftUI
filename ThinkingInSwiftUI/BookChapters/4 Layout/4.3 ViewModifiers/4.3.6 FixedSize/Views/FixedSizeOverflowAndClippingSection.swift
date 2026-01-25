//
//  FixedSizeOverflowAndClippingSection.swift
//  ThinkingInSwiftUI
//
//  Shows overflow behavior and how to use clipping
//

import SwiftUI

struct FixedSizeOverflowAndClippingSection: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "When fixedSize() Causes Overflow",
                description: "Child can be larger than frame",
                code: ""
            ) {
                VStack(spacing: 16) {
                    HStack(spacing: 20) {
                        VStack(spacing: 8) {
                            Text("No clipping")
                                .font(.caption)

                            Text("Long text here")
                                .fixedSize()
                                .frame(width: 50, height: 30)
                                .background(Color.red.opacity(0.2))
                                .border(Color.red, width: 2)

                            Text("Overflows")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }

                        VStack(spacing: 8) {
                            Text("With .clipped()")
                                .font(.caption)

                            Text("Long text here")
                                .fixedSize()
                                .frame(width: 50, height: 30)
                                .background(Color.green.opacity(0.2))
                                .border(Color.green, width: 2)
                                .clipped()

                            Text("Cropped")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }

                    Text("Use .clipped() to prevent visual overflow when needed")
                        .font(.caption)
                        .foregroundColor(.orange)
                        .multilineTextAlignment(.center)
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        FixedSizeOverflowAndClippingSection()
            .padding()
    }
}
