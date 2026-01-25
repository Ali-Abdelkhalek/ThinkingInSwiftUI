//
//  LayoutBasics.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Understanding the Layout Algorithm
//  Wrapper view combining all layout basics topics
//

import SwiftUI

struct LayoutBasicsView: View {
    var body: some View {
        TabView {
            LayoutAlgorithmView()
                .tabItem { Label("Algorithm", systemImage: "1.circle") }

            ProposedViewSizeView()
                .tabItem { Label("ProposedViewSize", systemImage: "2.circle") }

            DebuggingLayoutView()
                .tabItem { Label("Debugging", systemImage: "3.circle") }

            SizeThatFitsExampleView()
                .tabItem { Label("sizeThatFits", systemImage: "4.circle") }
        }
    }
}

#Preview {
    LayoutBasicsView()
}
