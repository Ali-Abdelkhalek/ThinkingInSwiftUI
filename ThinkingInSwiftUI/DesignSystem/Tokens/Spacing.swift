//
//  Spacing.swift
//  ThinkingInSwiftUI
//
//  Design System - Spacing Tokens
//

import SwiftUI

extension CGFloat {
    // MARK: - Standard Spacing Scale

    static let spaceXS: CGFloat = 4
    static let spaceSM: CGFloat = 8
    static let spaceMD: CGFloat = 12
    static let spaceLG: CGFloat = 16
    static let spaceXL: CGFloat = 24
    static let space2XL: CGFloat = 32
    static let space3XL: CGFloat = 48

    // MARK: - Semantic Spacing

    static let contentPadding: CGFloat = 16
    static let sectionGap: CGFloat = 20
    static let cardPadding: CGFloat = 16
    static let stepSpacing: CGFloat = 12
    static let controlSpacing: CGFloat = 16
}

extension EdgeInsets {
    // MARK: - Standard Insets

    static let contentInsets = EdgeInsets(
        top: .contentPadding,
        leading: .contentPadding,
        bottom: .contentPadding,
        trailing: .contentPadding
    )

    static let cardInsets = EdgeInsets(
        top: .cardPadding,
        leading: .cardPadding,
        bottom: .cardPadding,
        trailing: .cardPadding
    )
}
