//
//  SimpleBookDemo.swift
//  ThinkingInSwiftUI
//
//  Working demo with actual Layout chapter content
//

import SwiftUI

// MARK: - Demo Book with Real Content

fileprivate let layoutTopics: [BookTopic] = [
    // MARK: - 4.1 Layout Basics

    BookTopic(
        order: 1,
        chapterNumber: 4,
        topicNumber: "4.1",
        title: "Layout Basics",
        sections: [
            BookSection(
                order: 1,
                topicNumber: "4.1",
                sectionNumber: "4.1",
                title: "Layout Basics",
                estimatedMinutes: 20
            ) {
                LayoutBasicsView()
            }
        ]
    ),

    // MARK: - 4.2 Leaf Views

    BookTopic(
        order: 2,
        chapterNumber: 4,
        topicNumber: "4.2",
        title: "Leaf Views",
        sections: [
            BookSection(
                order: 2,
                topicNumber: "4.2",
                sectionNumber: "4.2.1",
                title: "Text",
                estimatedMinutes: 10
            ) {
                TextLeafView()
            },
            BookSection(
                order: 3,
                topicNumber: "4.2",
                sectionNumber: "4.2.2.1",
                title: "Shapes",
                estimatedMinutes: 12
            ) {
                ShapesLeafView()
            },
            BookSection(
                order: 4,
                topicNumber: "4.2",
                sectionNumber: "4.2.2.2",
                title: "More Shapes",
                estimatedMinutes: 10
            ) {
                MoreShapesView()
            },
            BookSection(
                order: 5,
                topicNumber: "4.2",
                sectionNumber: "4.2.3",
                title: "Color",
                estimatedMinutes: 8
            ) {
                ColorLeafView()
            },
            BookSection(
                order: 6,
                topicNumber: "4.2",
                sectionNumber: "4.2.4",
                title: "Image",
                estimatedMinutes: 12
            ) {
                ImageLeafView()
            },
            BookSection(
                order: 7,
                topicNumber: "4.2",
                sectionNumber: "4.2.5",
                title: "Divider",
                estimatedMinutes: 5
            ) {
                DividerLeafView()
            },
            BookSection(
                order: 8,
                topicNumber: "4.2",
                sectionNumber: "4.2.6",
                title: "Spacer",
                estimatedMinutes: 8
            ) {
                SpacerLeafView()
            }
        ]
    ),

    // MARK: - 4.3 View Modifiers

    BookTopic(
        order: 3,
        chapterNumber: 4,
        topicNumber: "4.3",
        title: "View Modifiers",
        sections: [
            BookSection(
                order: 9,
                topicNumber: "4.3",
                sectionNumber: "4.3.1",
                title: "Padding",
                estimatedMinutes: 10
            ) {
                PaddingView()
            },
            BookSection(
                order: 10,
                topicNumber: "4.3",
                sectionNumber: "4.3.2",
                title: "Fixed Frames",
                estimatedMinutes: 12
            ) {
                FixedFramesView()
            },
            BookSection(
                order: 11,
                topicNumber: "4.3",
                sectionNumber: "4.3.3",
                title: "Flexible Frames",
                estimatedMinutes: 15
            ) {
                FlexibleFrames()
            },
            BookSection(
                order: 12,
                topicNumber: "4.3",
                sectionNumber: "4.3.4",
                title: "AspectRatio",
                estimatedMinutes: 12
            ) {
                AspectRatio()
            },
            BookSection(
                order: 13,
                topicNumber: "4.3",
                sectionNumber: "4.3.5",
                title: "Overlay and Background",
                estimatedMinutes: 10
            ) {
                OverlayAndBackgroundExplained()
            },
            BookSection(
                order: 14,
                topicNumber: "4.3",
                sectionNumber: "4.3.6",
                title: "FixedSize",
                estimatedMinutes: 12
            ) {
                FixedSizeExplained()
            },
            BookSection(
                order: 15,
                topicNumber: "4.3",
                sectionNumber: "4.3.7",
                title: "Clipped",
                estimatedMinutes: 8
            ) {
                ClippedExplained()
            },
            BookSection(
                order: 16,
                topicNumber: "4.3",
                sectionNumber: "4.3.8",
                title: "Custom View Modifiers",
                estimatedMinutes: 10
            ) {
                CustomViewModifiersDemo()
            },
            BookSection(
                order: 17,
                topicNumber: "4.3",
                sectionNumber: "4.3.9",
                title: "Rendering Modifiers",
                estimatedMinutes: 8
            ) {
                RenderingModifiers()
            },
            BookSection(
                order: 18,
                topicNumber: "4.3",
                sectionNumber: "4.3.10",
                title: "Layout vs Rendering",
                estimatedMinutes: 12
            ) {
                LayoutVsRendering()
            }
        ]
    ),

    // MARK: - 4.4 Container Views

    BookTopic(
        order: 4,
        chapterNumber: 4,
        topicNumber: "4.4",
        title: "Container Views",
        sections: [
            BookSection(
                order: 19,
                topicNumber: "4.4",
                sectionNumber: "4.4.1",
                title: "HStack and VStack",
                estimatedMinutes: 8
            ) {
                HStackVStackExample()
            },
            BookSection(
                order: 20,
                topicNumber: "4.4",
                sectionNumber: "4.4.2",
                title: "ZStack",
                estimatedMinutes: 6
            ) {
                ZStackExplained()
            },
            BookSection(
                order: 21,
                topicNumber: "4.4",
                sectionNumber: "4.4.3",
                title: "ScrollView",
                estimatedMinutes: 10
            ) {
                ScrollViewExample()
            },
            BookSection(
                order: 22,
                topicNumber: "4.4",
                sectionNumber: "4.4.4.1",
                title: "GeometryReader Basics",
                estimatedMinutes: 12
            ) {
                GeometryReaderBasics()
            },
            BookSection(
                order: 23,
                topicNumber: "4.4",
                sectionNumber: "4.4.4.2",
                title: "GeometryReader Advanced",
                estimatedMinutes: 12
            ) {
                GeometryReaderAdvanced()
            },
            BookSection(
                order: 24,
                topicNumber: "4.4",
                sectionNumber: "4.4.5.1",
                title: "List Basics",
                estimatedMinutes: 10
            ) {
                ListBasics()
            },
            BookSection(
                order: 25,
                topicNumber: "4.4",
                sectionNumber: "4.4.5.2",
                title: "List Advanced",
                estimatedMinutes: 12
            ) {
                ListAdvanced()
            },
            BookSection(
                order: 26,
                topicNumber: "4.4",
                sectionNumber: "4.4.6",
                title: "Grid",
                estimatedMinutes: 15
            ) {
                GridExplained()
            },
            BookSection(
                order: 27,
                topicNumber: "4.4",
                sectionNumber: "4.4.7",
                title: "LazyVGrid and LazyHGrid",
                estimatedMinutes: 12
            ) {
                LazyGridsExplained()
            },
            BookSection(
                order: 28,
                topicNumber: "4.4",
                sectionNumber: "4.4.8",
                title: "ViewThatFits",
                estimatedMinutes: 10
            ) {
                ViewThatFitsExample()
            }
        ]
    ),

    // MARK: - 4.5 Alignment

    BookTopic(
        order: 5,
        chapterNumber: 4,
        topicNumber: "4.5",
        title: "Alignment",
        sections: [
            BookSection(
                order: 29,
                topicNumber: "4.5",
                sectionNumber: "4.5.1",
                title: "Built-in Alignments",
                estimatedMinutes: 15
            ) {
                BuiltInAlignments()
            },
            BookSection(
                order: 30,
                topicNumber: "4.5",
                sectionNumber: "4.5.2",
                title: "Advanced Alignments",
                estimatedMinutes: 20
            ) {
                AdvancedAlignments()
            }
        ]
    )
]

fileprivate let layoutChapter = BookChapter(
    number: 4,
    title: "Layout",
    icon: "square.grid.2x2",
    topics: layoutTopics
)

let simpleBook = BookContent(chapters: [layoutChapter])

// MARK: - Preview

#Preview {
    SimpleBookReader(book: simpleBook)
}
