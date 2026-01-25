//
//  OverlayKeyConceptSection.swift
//  ThinkingInSwiftUI
//
//  Key concepts of overlay and background modifiers
//

import SwiftUI

struct OverlayKeyConceptSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("The Elegant Design:")
                .font(.headline)

            VStack(alignment: .leading, spacing: 12) {
                conceptBox(
                    title: "Layout Behavior",
                    description: "overlay and background work EXACTLY the same for layout",
                    details: [
                        "Size primary view first",
                        "Propose primary's size to secondary view",
                        "ALWAYS report primary's size (ignore secondary!)"
                    ],
                    color: .blue
                )

                conceptBox(
                    title: "Drawing Order",
                    description: "Only difference: what draws on top",
                    details: [
                        "background: Secondary BEHIND primary",
                        "overlay: Secondary ON TOP of primary",
                        "Both use same sizing logic"
                    ],
                    color: .orange
                )

                conceptBox(
                    title: "Key Insight",
                    description: "Secondary view NEVER affects layout!",
                    details: [
                        "Reported size = primary's size only",
                        "Secondary can be any size",
                        "Siblings positioned based on primary only"
                    ],
                    color: .green
                )
            }
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
}

#Preview {
    ScrollView {
        OverlayKeyConceptSection()
            .padding()
    }
}
