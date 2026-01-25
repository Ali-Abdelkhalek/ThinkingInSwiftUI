//
//  StepView.swift
//  ThinkingInSwiftUI
//
//  Design System - Step Indicator Component
//  Used throughout the app to show numbered steps in explanations
//

import SwiftUI

struct StepView: View {
    let step: String
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text(step)
                .font(.caption.weight(.bold))
                .foregroundColor(.white)
                .frame(width: 24, height: 24)
                .background(Circle().fill(Color.blue))

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption.weight(.bold))
                Text(description)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
    }
}

// MARK: - Preview

#Preview("Step View") {
    VStack(spacing: 20) {
        StepView(
            step: "1",
            title: "Parent Proposes",
            description: "The parent view proposes a size to its child."
        )

        StepView(
            step: "2",
            title: "Child Chooses",
            description: "The child picks its own size within the proposal."
        )

        StepView(
            step: "3",
            title: "Parent Positions",
            description: "The parent places the child in its coordinate space."
        )
    }
    .padding()
}
