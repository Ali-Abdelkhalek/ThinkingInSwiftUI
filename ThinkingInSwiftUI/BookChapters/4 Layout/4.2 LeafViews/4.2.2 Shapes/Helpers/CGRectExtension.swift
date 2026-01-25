//
//  CGRectExtension.swift
//  ThinkingInSwiftUI
//
//  Helper extension for Shape examples
//

import SwiftUI

extension CGRect {
    subscript(_ point: UnitPoint) -> CGPoint {
        CGPoint(x: minX + width * point.x, y: minY + height * point.y)
    }
}
