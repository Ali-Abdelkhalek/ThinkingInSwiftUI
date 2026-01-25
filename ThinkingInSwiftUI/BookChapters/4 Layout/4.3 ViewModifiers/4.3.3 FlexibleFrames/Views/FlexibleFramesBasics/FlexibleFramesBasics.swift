import SwiftUI

struct FlexibleFramesBasics: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                sectionHeader("Flexible Frame API")
                FlexibleFramesIntro()

                sectionHeader("Special CGFloat Constants")
                FlexibleFramesSpecialConstants()

                sectionHeader("Width-Only Flexible Frames")
                FlexibleFramesWidthExamples()

                sectionHeader("Height-Only Flexible Frames")
                FlexibleFramesHeightExamples()

                sectionHeader("Ideal Size Examples")
                FlexibleFramesIdealExamples()

                sectionHeader("Combined Width + Height")
                FlexibleFramesCombinedExamples()

                sectionHeader("Alignment Parameter")
                FlexibleFramesAlignmentExamples()

                sectionHeader("Common Patterns")
                FlexibleFramesCommonPatterns()

                sectionHeader("Interactive Constants Comparison")
                FlexibleFramesConstantsComparison()
            }
            .padding()
        }
    }
}

#Preview {
    FlexibleFramesBasics()
}
