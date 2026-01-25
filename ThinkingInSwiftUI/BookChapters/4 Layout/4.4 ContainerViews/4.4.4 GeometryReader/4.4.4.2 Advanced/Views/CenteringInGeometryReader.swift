//
//  CenteringInGeometryReader.swift
//  ThinkingInSwiftUI
//
//  GeometryReader Advanced - Centering Content
//

import SwiftUI

/// Since GeometryReader uses top-leading alignment, if we want to center content,
/// we need to do it explicitly.
///
/// KEY INSIGHT: .frame(alignment:) doesn't work alone because it only controls
/// how the view is positioned within its OWN size. To center in GeometryReader,
/// you must FILL the space first using width and height from proxy.size.
struct CenteringInGeometryReader: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Centering in GeometryReader")
                .font(.headline)

            // 1. Default top-leading placement
            GeometryReader { _ in
                Text("Top-Leading (Default)")
                    .padding()
                    .background(Color.blue.opacity(0.3))
            }
            .frame(height: 100)
            .border(Color.red, width: 2)
            Text("↑ No frame modifier")
                .font(.caption2)

            // 2. WRONG: Using only .frame(alignment:) doesn't work
            GeometryReader { _ in
                Text("Still Top-Leading!")
                    .padding()
                    .background(Color.orange.opacity(0.3))
                    .frame(alignment: .center)
            }
            .frame(height: 100)
            .border(Color.red, width: 2)
            Text("↑ .frame(alignment: .center) doesn't fill space")
                .font(.caption2)

            // 3. CORRECT: Fill the space with width/height, then center
            GeometryReader { proxy in
                Text("Actually Centered!")
                    .padding()
                    .background(Color.green.opacity(0.3))
                    .frame(width: proxy.size.width, height: proxy.size.height)
            }
            .frame(height: 100)
            .border(Color.red, width: 2)
            Text("↑ .frame(width:height:) fills GeometryReader space")
                .font(.caption2)
        }
        .padding()
    }
}

#Preview {
    CenteringInGeometryReader()
}
