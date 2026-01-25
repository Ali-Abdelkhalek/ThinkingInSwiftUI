//
//  4.2.5 Divider.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Divider
//  Wrapper view for Divider sizing behavior demos
//

import SwiftUI

struct DividerLeafView: View {
    var body: some View {
        TabView {
            DividerInVStackView()
                .tabItem { Label("VStack", systemImage: "1.circle") }

            DividerInHStackView()
                .tabItem { Label("HStack", systemImage: "2.circle") }

            DividerSizingView()
                .tabItem { Label("Sizing", systemImage: "3.circle") }

            DividerComparisonView()
                .tabItem { Label("Compare", systemImage: "4.circle") }
        }
    }
}

#Preview {
    DividerLeafView()
}
