//
//  4.3.5 OverlayAndBackground.swift
//  ThinkingInSwiftUI
//
//  Understanding overlay and background modifiers
//  How they size themselves and their elegant two-step layout process
//

import SwiftUI

struct OverlayAndBackgroundExplained: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                sectionHeader("Overlay & Background Modifiers")

                OverlayKeyConceptSection()

                sectionHeader("1. The Two-Step Sizing Process")

                OverlayTwoStepProcessSection()

                sectionHeader("2. Basic Examples")

                OverlayBasicExamplesSection()

                sectionHeader("3. With Padding")

                OverlayPaddingExamplesSection()

                sectionHeader("4. Siblings Don't Move!")

                OverlaySiblingsSection()

                sectionHeader("5. Multiple Views (Implicit ZStack)")

                OverlayMultipleViewsSection()

                sectionHeader("6. Practical Examples")

                OverlayPracticalExamplesSection()
            }
            .padding()
        }
    }
}

// MARK: - Highlight Modifier

extension View {
    func highlight(enabled: Bool = true) -> some View {
        background {
            if enabled {
                Color.orange
                    .padding(-3)
            }
        }
    }
}

#Preview {
    OverlayAndBackgroundExplained()
}
