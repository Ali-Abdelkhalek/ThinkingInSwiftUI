//
//  ClippedPracticalUseCasesSection.swift
//  ThinkingInSwiftUI
//
//  Practical use cases for .clipped()
//

import SwiftUI

struct ClippedPracticalUseCasesSection: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Use Case 1: Image with .fill mode",
                description: "Prevent image overflow when using aspectRatio .fill",
                code: ".aspectRatio(contentMode: .fill).clipped()"
            ) {
                VStack(spacing: 8) {
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .aspectRatio(16/9, contentMode: .fill)
                        .frame(width: 200, height: 100)
                        .clipped()
                        .border(Color.red, width: 2)

                    Text("Without .clipped(), gradient would overflow")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Use Case 2: Custom Shape Overflow",
                description: "Clip shapes that extend beyond their container",
                code: ".overlay(shape).clipped()"
            ) {
                VStack(spacing: 8) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 100, height: 100)
                        .overlay(
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 150, height: 150)
                        )
                        .clipped()
                        .border(Color.red, width: 2)

                    Text("Circle is clipped to rectangle bounds")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Use Case 3: Text Truncation Alternative",
                description: "Clip text instead of showing ellipsis",
                code: ".frame(width: 100).clipped()"
            ) {
                VStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Default (ellipsis):")
                            .font(.caption)

                        Text("Long text here that overflows")
                            .frame(width: 150)
                            .background(Color.blue.opacity(0.1))
                            .border(Color.blue, width: 1)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("With .clipped():")
                            .font(.caption)

                        Text("Long text here that overflows")
                            .lineLimit(1)
                            .fixedSize()
                            .frame(width: 150, alignment: .leading)
                            .clipped()
                            .background(Color.green.opacity(0.1))
                            .border(Color.green, width: 1)
                    }

                    Text("Top: shows '...', Bottom: hard clip")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        ClippedPracticalUseCasesSection()
            .padding()
    }
}
