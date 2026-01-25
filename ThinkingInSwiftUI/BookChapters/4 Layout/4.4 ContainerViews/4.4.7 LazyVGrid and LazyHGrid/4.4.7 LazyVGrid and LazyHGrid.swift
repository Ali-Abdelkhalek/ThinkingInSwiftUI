//
//  4.4.7 LazyVGrid and LazyHGrid.swift
//  ThinkingInSwiftUI
//
//  Understanding LazyVGrid and LazyHGrid
//

import SwiftUI

struct LazyGridsExplained: View {
    var body: some View {
        TabView {
            LazyVGridExamples()
                .tabItem { Label("LazyVGrid", systemImage: "1.circle") }

            LazyHGridExamples()
                .tabItem { Label("LazyHGrid", systemImage: "2.circle") }

            LazyGridLoadingDemo()
                .tabItem { Label("Lazy Loading", systemImage: "3.circle") }

            GridComparisonView()
                .tabItem { Label("Comparison", systemImage: "4.circle") }

            ReuseDemo()
                .tabItem { Label("Reuse Demo", systemImage: "5.circle") }
        }
    }
}

#Preview {
    LazyGridsExplained()
}
