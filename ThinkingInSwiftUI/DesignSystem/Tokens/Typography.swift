//
//  Typography.swift
//  ThinkingInSwiftUI
//
//  Design System - Typography Tokens
//

import SwiftUI

extension Font {
    // MARK: - Headings

    static let bookTitle = Font.largeTitle.weight(.bold)
    static let chapterTitle = Font.title.weight(.bold)
    static let sectionTitle = Font.title2.weight(.semibold)
    static let subsectionTitle = Font.headline

    // MARK: - Body Text

    static let bookBody = Font.body
    static let bookBodyEmphasis = Font.body.weight(.medium)
    static let bookCaption = Font.caption
    static let bookCaption2 = Font.caption2

    // MARK: - Code

    static let codeFont = Font.system(.body, design: .monospaced)
    static let codeSmall = Font.system(.caption, design: .monospaced)

    // MARK: - Step Indicators

    static let stepNumber = Font.caption.weight(.bold)
    static let stepTitle = Font.caption.weight(.bold)
    static let stepDescription = Font.caption2
}

// MARK: - Text Styles

extension Text {
    func bookTitleStyle() -> some View {
        self.font(.bookTitle)
    }

    func chapterTitleStyle() -> some View {
        self.font(.chapterTitle)
    }

    func sectionTitleStyle() -> some View {
        self.font(.sectionTitle)
    }

    func stepTitleStyle() -> some View {
        self.font(.stepTitle)
    }

    func stepDescriptionStyle() -> some View {
        self.font(.stepDescription)
            .foregroundColor(.secondary)
    }
}
