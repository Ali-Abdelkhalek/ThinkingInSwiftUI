//
//  4.3.6 FixedSize.swift
//  ThinkingInSwiftUI
//
//  Understanding the fixedSize() modifier
//  How it proposes nil to get ideal size and common use cases
//

import SwiftUI

struct FixedSizeExplained: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                sectionHeader("fixedSize() Modifier")

                FixedSizeKeyConceptSection()

                sectionHeader("1. What fixedSize() Does")

                FixedSizeWhatItDoesSection()

                sectionHeader("2. Text Without fixedSize()")

                TextWithoutFixedSizeSection()

                sectionHeader("3. Text With fixedSize()")

                TextWithFixedSizeSection()

                sectionHeader("4. Horizontal vs Vertical")

                FixedSizeHorizontalVsVerticalSection()

                sectionHeader("5. The Badge Problem")

                FixedSizeBadgeProblemSection()

                sectionHeader("6. Overflow and Clipping")

                FixedSizeOverflowAndClippingSection()

                sectionHeader("7. Practical Examples")

                FixedSizePracticalExamplesSection()
            }
            .padding()
        }
    }
}

// MARK: - Badge Modifiers

extension View {
    // Broken version - badge truncates
    func badgeBroken<Badge: View>(@ViewBuilder contents: () -> Badge) -> some View {
        self.overlay(alignment: .topTrailing) {
            contents()
                .padding(3)
                .background(RoundedRectangle(cornerRadius: 5).fill(.teal))
        }
    }

    // Fixed version - badge at ideal size
    func badge<Badge: View>(@ViewBuilder contents: () -> Badge) -> some View {
        self.overlay(alignment: .topTrailing) {
            contents()
                .padding(3)
                .background(RoundedRectangle(cornerRadius: 5).fill(.teal))
                .fixedSize()  // The fix!
        }
    }
}

#Preview {
    FixedSizeExplained()
}
