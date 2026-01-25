//
//  SimpleBookDemo.swift
//  ThinkingInSwiftUI
//
//  Working demo with actual Layout chapter content
//

import SwiftUI

// MARK: - Demo Book with Real Content

fileprivate let layoutSections: [BookSection] = [
    BookSection(
        order: 1,
        chapterNumber: 4,
        title: "List Basics",
        estimatedMinutes: 10
    ) {
        TabView {
            BasicListExample()
                .tabItem { Label("Basic", systemImage: "1.circle") }

            LazyLoadingExample()
                .tabItem { Label("Lazy Loading", systemImage: "2.circle") }

            ListVsScrollViewComparison()
                .tabItem { Label("vs ScrollView", systemImage: "3.circle") }

            ListWidthProposalExample()
                .tabItem { Label("Width", systemImage: "4.circle") }
        }
    },
    BookSection(
        order: 2,
        chapterNumber: 4,
        title: "List Advanced",
        estimatedMinutes: 12
    ) {
        TabView {
            ListHeightProposalExample()
                .tabItem { Label("Height", systemImage: "1.circle") }

            HeightEstimationExample()
                .tabItem { Label("Estimation", systemImage: "2.circle") }

            DynamicHeightItemsExample()
                .tabItem { Label("Dynamic", systemImage: "3.circle") }

            ListLayoutSummary()
                .tabItem { Label("Summary", systemImage: "4.circle") }
        }
    }
]

fileprivate let layoutChapter = BookChapter(
    number: 4,
    title: "Layout - Container Views",
    icon: "square.grid.2x2",
    sections: layoutSections
)

let simpleBook = BookContent(chapters: [layoutChapter])

// MARK: - Preview

#Preview {
    SimpleBookReader(book: simpleBook)
}
