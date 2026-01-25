//
//  AspectRatioExplained.swift
//  ThinkingInSwiftUI
//
//  Understanding the aspectRatio modifier and why resizable images
//  don't just stretch to fill the entire proposed size
//

import SwiftUI

struct AspectRatioExplained: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                sectionHeader("Understanding aspectRatio Modifier")

                KeyInsightSection()

                sectionHeader("Visual Comparison: Why .resizable() is Critical")

                VisualComparisonSection()

                sectionHeader("1. The Problem: Distorted Images")

                DistortedImageExample()

                sectionHeader("2. The Solution: aspectRatio Modifier")

                AspectRatioSolution()

                sectionHeader("3. Layout Process Breakdown")

                LayoutProcessBreakdown()

                sectionHeader("4. contentMode: .fit vs .fill")

                FitVsFillComparison()

                sectionHeader("5. With Specific Aspect Ratio")

                SpecificAspectRatio()

                sectionHeader("6. Interactive Demo")

                InteractiveDemo()
            }
            .padding()
        }
    }
}

#Preview {
    AspectRatioExplained()
}
