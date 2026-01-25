//
//  FixedSizeKeyConceptSection.swift
//  ThinkingInSwiftUI
//
//  Key concepts of the fixedSize() modifier
//

import SwiftUI

struct FixedSizeKeyConceptSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("The Core Behavior:")
                .font(.headline)

            conceptBoxWithIcon(
                icon: "∞",
                title: "Proposes nil × nil",
                description: "fixedSize() ignores what it's proposed and proposes nil to its child",
                color: .blue,
                details: [
                    "Receives proposal from parent (e.g., 100×50)",
                    "Ignores that proposal completely",
                    "Proposes nil×nil to child",
                    "Child becomes its ideal size",
                    "Reports child's ideal size to parent"
                ]
            )

            conceptBoxWithIcon(
                icon: "📏",
                title: "Makes Views Their Ideal Size",
                description: "Child sizes itself without constraints",
                color: .green,
                details: [
                    "Text becomes full width (no wrapping/truncation)",
                    "Images use intrinsic size",
                    "Views size to content",
                    "Can overflow parent's bounds!"
                ]
            )

            conceptBoxWithIcon(
                icon: "↔️",
                title: "Selective Application",
                description: "Can apply to one dimension only",
                color: .orange,
                details: [
                    "fixedSize() - both width and height",
                    "fixedSize(horizontal: true, vertical: false)",
                    "fixedSize(horizontal: false, vertical: true)",
                    "Mix constraints with ideal sizing"
                ]
            )
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
}

#Preview {
    ScrollView {
        FixedSizeKeyConceptSection()
            .padding()
    }
}
