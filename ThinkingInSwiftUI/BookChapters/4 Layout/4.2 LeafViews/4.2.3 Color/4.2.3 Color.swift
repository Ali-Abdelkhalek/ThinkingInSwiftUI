//
//  4.2.3 Color.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Color
//  Wrapper view for Color bleed and safe area demos
//

import SwiftUI

struct ColorLeafView: View {
    var body: some View {
        TabView {
            ColorVsRectangleView()
                .tabItem { Label("Basics", systemImage: "1.circle") }

            WhenDoesBleedHappenView()
                .tabItem { Label("When", systemImage: "2.circle") }

            ChildrenAtEdgesView()
                .tabItem { Label("Children", systemImage: "3.circle") }

            PaddingBehaviorView()
                .tabItem { Label("Padding", systemImage: "4.circle") }

            PreventBleedView()
                .tabItem { Label("Prevent", systemImage: "5.circle") }
        }
    }
}

#Preview {
    ColorLeafView()
}
