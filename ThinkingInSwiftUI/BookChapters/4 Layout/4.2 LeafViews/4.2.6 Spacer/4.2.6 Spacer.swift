//
//  4.2.6 Spacer.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Spacer
//  Wrapper view for Spacer sizing behavior demos
//

import SwiftUI

struct SpacerLeafView: View {
    var body: some View {
        TabView {
            SpacerInVStackView()
                .tabItem { Label("VStack", systemImage: "1.circle") }

            SpacerInHStackView()
                .tabItem { Label("HStack", systemImage: "2.circle") }

            SpacerProblemView()
                .tabItem { Label("Problem", systemImage: "3.circle") }

            BetterSolutionView()
                .tabItem { Label("Solution", systemImage: "4.circle") }

            SpacerDetailsView()
                .tabItem { Label("Details", systemImage: "5.circle") }
        }
    }
}

#Preview {
    SpacerLeafView()
}
