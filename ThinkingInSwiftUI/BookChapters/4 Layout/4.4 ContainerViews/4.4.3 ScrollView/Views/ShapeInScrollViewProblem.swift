//
//  ShapeInScrollViewProblem.swift
//  ThinkingInSwiftUI
//
//  ScrollView - Shape Behavior Problem
//
//  When we put a shape into a scroll view, the result might be surprising: the built-in
//  shapes in SwiftUI all have an ideal size of 10×10. This is due to the default argument
//  of .replacingUnspecifiedDimensions(by:) on ProposedViewSize, which is 10×10.
//
//  Since the scroll view proposed nil along the scroll axis, the shape will take on its
//  ideal size of 10 points on that axis.
//

import SwiftUI

struct ShapeInScrollViewProblem: View {
    var body: some View {
        ScrollView {
            Rectangle()
                .fill(Color.blue)
            Circle()
                .fill(Color.green)
        }
        .border(Color.red)
    }
}

#Preview {
    ShapeInScrollViewProblem()
}
