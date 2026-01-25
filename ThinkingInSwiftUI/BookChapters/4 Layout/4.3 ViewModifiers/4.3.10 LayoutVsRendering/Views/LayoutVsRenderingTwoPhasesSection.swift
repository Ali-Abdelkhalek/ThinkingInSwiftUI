//
//  LayoutVsRenderingTwoPhasesSection.swift
//  ThinkingInSwiftUI
//
//  Explains the two-phase system
//

import SwiftUI

struct LayoutVsRenderingTwoPhasesSection: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Phase 1: Layout (Space Allocation)",
                description: "SwiftUI determines sizes and positions",
                code: ""
            ) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Example: .frame(width: 100)")
                        .fontWeight(.semibold)

                    VStack(alignment: .leading, spacing: 6) {
                        layoutPhaseStep("1", "Parent proposes size to view")
                        layoutPhaseStep("2", "View calculates its size (100pt wide)")
                        layoutPhaseStep("3", "View reports size back to parent")
                        layoutPhaseStep("4", "Parent allocates 100pt of space")
                        layoutPhaseStep("5", "Sibling views positioned accordingly")
                    }
                    .font(.caption)

                    Rectangle()
                        .fill(Color.blue.opacity(0.2))
                        .frame(width: 100, height: 50)
                        .overlay(
                            Text("100pt of allocated space")
                                .font(.caption)
                        )

                    Text("✅ This space is RESERVED in the layout, regardless of content")
                        .font(.caption)
                        .foregroundColor(.green)
                }
            }

            exampleCard(
                title: "Phase 2: Rendering (Drawing)",
                description: "SwiftUI draws the visual content",
                code: ""
            ) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Content can overflow beyond layout bounds!")
                        .fontWeight(.semibold)

                    VStack(alignment: .leading, spacing: 6) {
                        renderPhaseStep("1", "SwiftUI draws content in the allocated space")
                        renderPhaseStep("2", "Content CAN extend beyond the bounds")
                        renderPhaseStep("3", "By default, no clipping mask applied")
                        renderPhaseStep("4", "Overflow is visually drawn on screen")
                        renderPhaseStep("5", "Layout space stays 100pt regardless!")
                    }
                    .font(.caption)

                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color.blue.opacity(0.2))
                            .frame(width: 100, height: 50)

                        Text("Very long content that extends beyond 100pt boundary")
                            .font(.caption)
                            .background(Color.red.opacity(0.3))
                    }

                    Text("⚠️ Visual overflow, but layout is still 100pt!")
                        .font(.caption)
                        .foregroundColor(.orange)
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        LayoutVsRenderingTwoPhasesSection()
            .padding()
    }
}
