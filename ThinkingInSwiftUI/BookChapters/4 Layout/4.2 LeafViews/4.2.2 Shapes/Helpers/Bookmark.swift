//
//  Bookmark.swift
//  ThinkingInSwiftUI
//
//  Helper shape for Shapes examples
//

import SwiftUI

struct Bookmark: Shape {
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.addLines([
                rect[.topLeading],
                rect[.bottomLeading],
                rect[.init(x: 0.5, y: 0.8)],
                rect[.bottomTrailing],
                rect[.topTrailing],
                rect[.topLeading]
            ])
            p.closeSubpath()
        }
    }

    func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize {
        var result = proposal.replacingUnspecifiedDimensions()
        let ratio: CGFloat = 2/3
        let newWidth = ratio * result.height
        if newWidth <= result.width {
            result.width = newWidth
        } else {
            result.height = result.width / ratio
        }
        return result
    }
}
