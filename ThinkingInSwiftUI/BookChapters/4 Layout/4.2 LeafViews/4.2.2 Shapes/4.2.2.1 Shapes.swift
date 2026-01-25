//
//  Shapes.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Shapes
//  Understanding how Shapes determine their size
//

import SwiftUI

struct ShapesLeafView: View {
    var body: some View {
        TabView {
            BuiltInShapesView()
                .tabItem { Label("Built-in", systemImage: "1.circle") }

            CircleSpecialBehaviorView()
                .tabItem { Label("Circle", systemImage: "2.circle") }

            BookmarkExampleView()
                .tabItem { Label("Bookmark", systemImage: "3.circle") }

            SizeThatFitsDeepDiveView()
                .tabItem { Label("sizeThatFits", systemImage: "4.circle") }

            IdealSizeScrollViewView()
                .tabItem { Label("ScrollView", systemImage: "5.circle") }
        }
    }
}

#Preview {
    ShapesLeafView()
}
