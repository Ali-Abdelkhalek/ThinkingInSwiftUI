//
//  4.4.5 List.swift
//  ThinkingInSwiftUI
//
//  Understanding List
//
//  TODO: This section needs refactoring - currently has 8 views (exceeds 5 tab limit)
//  Need to consolidate and create better tutorial flow
//

import SwiftUI

struct ListExplained: View {
    var body: some View {
        TabView {
            // Basics - 4 views
            BasicListExample()
                .tabItem { Label("Basic", systemImage: "1.circle") }

            LazyLoadingExample()
                .tabItem { Label("Lazy Loading", systemImage: "2.circle") }

            ListVsScrollViewComparison()
                .tabItem { Label("vs ScrollView", systemImage: "3.circle") }

            ListWidthProposalExample()
                .tabItem { Label("Width", systemImage: "4.circle") }

            // Advanced - 4 views (exceeds 5 tab limit!)
            ListHeightProposalExample()
                .tabItem { Label("Height", systemImage: "5.circle") }

            HeightEstimationExample()
                .tabItem { Label("Estimation", systemImage: "6.circle") }

            DynamicHeightItemsExample()
                .tabItem { Label("Dynamic", systemImage: "7.circle") }

            ListLayoutSummary()
                .tabItem { Label("Summary", systemImage: "8.circle") }
        }
    }
}

#Preview {
    ListExplained()
}
