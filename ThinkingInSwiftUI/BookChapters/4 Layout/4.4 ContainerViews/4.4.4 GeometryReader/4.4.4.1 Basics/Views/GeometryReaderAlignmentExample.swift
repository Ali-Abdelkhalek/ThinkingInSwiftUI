//
//  GeometryReaderAlignmentExample.swift
//  ThinkingInSwiftUI
//
//  GeometryReader Basics - Top-Leading vs Center Alignment
//

import SwiftUI

/// GeometryReader places its subviews at top-leading (0, 0) by default, unlike other
/// container views which use center alignment.
///
/// This means GeometryReader affects BOTH:
/// 1. SIZE: Always accepts the proposed size
/// 2. POSITION: Places content at top-leading corner
struct GeometryReaderAlignmentExample: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Compare Positioning Behavior")
                .font(.headline)

            // VStack uses center alignment by default
            VStack {
                Circle()
                    .fill(Color.green)
                    .frame(width: 50, height: 50)
                Text("Centered")
                    .font(.caption)
            }
            .frame(height: 150)
            .border(Color.blue, width: 2)
            Text("↑ VStack centers content")
                .font(.caption2)

            // GeometryReader uses top-leading alignment by default
            GeometryReader { _ in
                VStack {
                    Circle()
                        .fill(Color.orange)
                        .frame(width: 50, height: 50)
                    Text("At (0, 0)")
                        .font(.caption)
                }
            }
            .frame(height: 150)
            .border(Color.red, width: 2)
            Text("↑ GeometryReader places at top-leading")
                .font(.caption2)
        }
        .padding()
    }
}

#Preview {
    GeometryReaderAlignmentExample()
}
