//
//  LayoutVsRenderingSiblingPositioningSection.swift
//  ThinkingInSwiftUI
//
//  Demonstrates sibling positioning proof
//

import SwiftUI

struct LayoutVsRenderingSiblingPositioningSection: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Proof: Layout is Unchanged",
                description: "Sibling views positioned identically with or without .clipped()",
                code: ""
            ) {
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("WITHOUT .clipped():")
                            .font(.caption)
                            .fontWeight(.semibold)

                        HStack(spacing: 0) {
                            Text("Overflow Text Content Here")
                                .font(.caption)
                                .frame(width: 80)
                                .background(Color.red.opacity(0.3))
                                .border(Color.red, width: 2)

                            Rectangle()
                                .fill(Color.blue)
                                .frame(width: 60, height: 40)
                                .overlay(Text("Sibling").font(.caption).foregroundColor(.white))
                        }

                        Text("Blue sibling starts at 80pt mark →")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("WITH .clipped():")
                            .font(.caption)
                            .fontWeight(.semibold)

                        HStack(spacing: 0) {
                            Text("Overflow Text Content Here")
                                .font(.caption)
                                .frame(width: 80)
                                .background(Color.red.opacity(0.3))
                                .border(Color.red, width: 2)
                                .clipped()

                            Rectangle()
                                .fill(Color.blue)
                                .frame(width: 60, height: 40)
                                .overlay(Text("Sibling").font(.caption).foregroundColor(.white))
                        }

                        Text("Blue sibling STILL starts at 80pt mark →")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    Text("✅ Sibling is in the EXACT same position!\nLayout space is unchanged, only rendering is clipped.")
                        .font(.caption)
                        .foregroundColor(.green)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(8)
                }
            }

            exampleCard(
                title: "Why This Matters",
                description: "Understanding the separation is crucial",
                code: ""
            ) {
                VStack(alignment: .leading, spacing: 8) {
                    importanceItem("Layout determines SPACING and POSITIONING")
                    importanceItem("Rendering determines VISUAL APPEARANCE")
                    importanceItem(".clipped() is a RENDERING-ONLY modifier")
                    importanceItem("Other views don't \"see\" the clipping")
                    importanceItem("Only affects what gets drawn, not space")
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        LayoutVsRenderingSiblingPositioningSection()
            .padding()
    }
}
