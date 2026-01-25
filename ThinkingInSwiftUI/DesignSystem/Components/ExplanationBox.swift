//
//  ExplanationBox.swift
//  ThinkingInSwiftUI
//
//  Design System - Explanation Box Component
//  Used to display explanatory text with consistent styling
//

import SwiftUI

struct ExplanationBox: View {
    let title: String?
    let description: String
    let icon: String?

    init(title: String? = nil, description: String, icon: String? = nil) {
        self.title = title
        self.description = description
        self.icon = icon
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let title = title {
                HStack(spacing: 8) {
                    if let icon = icon {
                        Image(systemName: icon)
                            .foregroundColor(.blue)
                    }
                    Text(title)
                        .font(.headline)
                }
            }

            Text(description)
                .font(.body)
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
}

// MARK: - Preview

#Preview("Explanation Box") {
    VStack(spacing: 20) {
        ExplanationBox(
            title: "Layout Algorithm",
            description: "SwiftUI's layout algorithm follows three steps: parent proposes, child chooses, parent positions.",
            icon: "info.circle"
        )

        ExplanationBox(
            description: "This is a simple explanation without a title or icon."
        )

        ExplanationBox(
            title: "Important Note",
            description: "This box has a title but no icon, demonstrating the flexible API."
        )
    }
    .padding()
}
