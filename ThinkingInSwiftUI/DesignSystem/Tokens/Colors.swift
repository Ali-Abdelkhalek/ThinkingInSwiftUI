//
//  Colors.swift
//  ThinkingInSwiftUI
//
//  Design System - Color Tokens
//

import SwiftUI

extension Color {
    // MARK: - Primary Colors

    static let bookPrimary = Color.blue
    static let bookSecondary = Color.purple

    // MARK: - Semantic Colors

    static let bookSuccess = Color.green
    static let bookWarning = Color.orange
    static let bookError = Color.red
    static let bookInfo = Color.blue

    // MARK: - Background Colors

    static let demoBackground = Color.blue.opacity(0.1)
    static let explanationBackground = Color.gray.opacity(0.1)
    static let codeBackground = Color.gray.opacity(0.15)
    static let targetCodeHighlight = Color.yellow.opacity(0.2)

    // MARK: - Border Colors

    static let demoBorder = Color.blue
    static let debugBorder = Color.red
    static let infoCard = Color.gray.opacity(0.2)
}
