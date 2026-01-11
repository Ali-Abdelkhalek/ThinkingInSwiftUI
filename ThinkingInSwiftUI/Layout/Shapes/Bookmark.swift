//
//  BookmarkShape.swift
//  ThinkingInSwiftUI
//
//  Created by Ali Abdelkhalek on 09/02/2025.
//

import SwiftUI

struct Bookmark: Shape {
    func path(in rect: CGRect) -> Path {
        Path { p in
            //p.move(to: rect[.topLeading])
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

extension CGRect {
    subscript(_ point: UnitPoint) -> CGPoint {
        CGPoint(x: minX + width*point.x, y: minY + height*point.y)
    }
}

#Preview {
    Bookmark()
        .fill(Color.white)
        .stroke(Color.black, lineWidth: 3)
        .padding()
        .frame(width: 100, height: 100)
}
