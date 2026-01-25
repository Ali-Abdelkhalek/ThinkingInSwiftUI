//
//  BookTabView.swift
//  ThinkingInSwiftUI
//
//  Design System - Consistent TabView wrapper for all book examples
//

import SwiftUI

struct BookTabView<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        TabView {
            content
        }
    }
}

// MARK: - Preview

#Preview("Book Tab View") {
    BookTabView {
        Text("Tab 1 Content")
            .tabItem { Label("First", systemImage: "1.circle") }

        Text("Tab 2 Content")
            .tabItem { Label("Second", systemImage: "2.circle") }

        Text("Tab 3 Content")
            .tabItem { Label("Third", systemImage: "3.circle") }
    }
}
