//
//  4.3.7 Clipped.swift
//  ThinkingInSwiftUI
//
//  Understanding what .clipped() does and doesn't do
//  It clips visual overflow but does NOT change frame size or remove empty space
//

import SwiftUI

struct ClippedExplained: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                sectionHeader("Understanding .clipped()")

                ClippedKeyConceptSection()

                sectionHeader("1. What clipped() Does")

                ClippedWhatItDoesSection()

                sectionHeader("2. What clipped() Does NOT Do")

                ClippedWhatItDoesNotSection()

                sectionHeader("3. Overflow Scenarios")

                ClippedOverflowExamplesSection()

                sectionHeader("4. Empty Space Scenarios")

                ClippedEmptySpaceExamplesSection()

                sectionHeader("5. Common Misconceptions")

                ClippedMisconceptionsSection()

                sectionHeader("6. Practical Use Cases")

                ClippedPracticalUseCasesSection()
            }
            .padding()
        }
    }
}

#Preview {
    ClippedExplained()
}
