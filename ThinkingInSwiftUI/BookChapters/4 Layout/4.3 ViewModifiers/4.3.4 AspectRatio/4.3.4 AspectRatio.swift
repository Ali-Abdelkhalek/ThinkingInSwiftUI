//
//  4.3.4 AspectRatio.swift
//  ThinkingInSwiftUI
//
//  Main interface for AspectRatio modifier examples and explanations
//

import SwiftUI

struct AspectRatio: View {
    var body: some View {
        TabView {
            AspectRatioExplained()
                .tabItem {
                    Label("Explanation", systemImage: "book.fill")
                }

            AspectRatioSandbox()
                .tabItem {
                    Label("Sandbox", systemImage: "slider.horizontal.3")
                }
        }
    }
}

#Preview {
    AspectRatio()
}
