//
//  ProblemExample.swift
//  ThinkingInSwiftUI
//
//  GeometryReader Basics - The Problem: GeometryReader Influences Layout
//

import SwiftUI

/// Because GeometryReader always accepts the proposed size, wrapping a view with it
/// will affect the layout. For example, if we try to measure the width of a Text view
/// by wrapping it in a GeometryReader, the text will no longer determine its own size.
struct ProblemExample: View {
    var body: some View {
        VStack(spacing: 20) {
            // Text without GeometryReader - takes its natural size
            Text("Hello, SwiftUI!")
                .padding()
                .background(Color.green)
                .border(Color.blue, width: 2)

            // Text with GeometryReader - GeometryReader takes all available space
            GeometryReader { proxy in
                Text("Hello, SwiftUI!")
                    .padding()
                    .background(Color.green)
                    .border(Color.blue, width: 2)
            }
            .border(Color.red, width: 2)
        }
        .padding()
    }
}

#Preview {
    ProblemExample()
}
