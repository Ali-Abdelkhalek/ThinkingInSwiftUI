import SwiftUI

/// # Advanced Alignments
///
/// Beyond built-in alignments: modifying and creating custom alignment guides
/// to achieve precise positioning that isn't possible with built-in alignments alone.
///
/// KEY CONCEPTS:
/// 1. Modified alignments override built-in guide positions using .alignmentGuide()
/// 2. Custom alignments create entirely new alignment types with AlignmentID protocol
/// 3. Custom alignments propagate through containers (built-in modified guides don't)
/// 4. Use cases: badges, decimal point alignment, chat messages, form labels
///
/// COVERED TOPICS:
/// - Modified alignment guides (.alignmentGuide modifier)
/// - Custom alignment identifiers (AlignmentID protocol)
///
struct AdvancedAlignments: View {
    var body: some View {
        TabView {
            ModifiedAlignmentExample()
                .tabItem { Label("Modified Guides", systemImage: "1.circle") }

            CustomAlignmentExample()
                .tabItem { Label("Custom Alignments", systemImage: "2.circle") }
        }
    }
}

#Preview {
    AdvancedAlignments()
}
