//
//  4.2.1 Text.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Text
//  Wrapper view combining all text topics
//

import SwiftUI

struct TextLeafView: View {
    var body: some View {
        TabView {
            TextSizingBasicsView()
                .tabItem { Label("Basics", systemImage: "1.circle") }

            LineLimitView()
                .tabItem { Label("lineLimit", systemImage: "2.circle") }

            TruncationAndScalingView()
                .tabItem { Label("Truncation", systemImage: "3.circle") }

            FixedSizeWithTextView()
                .tabItem { Label("fixedSize", systemImage: "4.circle") }

            TextRealWorldPatternsView()
                .tabItem { Label("Patterns", systemImage: "5.circle") }
        }
    }
}

#Preview {
    TextLeafView()
}
