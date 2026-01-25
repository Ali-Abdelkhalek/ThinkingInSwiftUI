//
//  BackgroundOverlaySolution.swift
//  ThinkingInSwiftUI
//
//  GeometryReader Advanced - Using in Background/Overlay
//

import SwiftUI

/// When we put a GeometryReader inside a background or overlay modifier, it won't
/// influence the size of the primary view. The size of the primary view will be
/// proposed to the GeometryReader, allowing us to measure it.
struct BackgroundOverlaySolution: View {
    @State private var textSize: CGSize = .zero

    var body: some View {
        VStack(spacing: 30) {
            Text("Measured Text")
                .font(.title)
                .padding()
                .background(Color.green.opacity(0.3))
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .onAppear {
                                textSize = proxy.size
                            }
                    }
                )

            Text("Width: \(Int(textSize.width))")
            Text("Height: \(Int(textSize.height))")
        }
        .padding()
    }
}

#Preview {
    BackgroundOverlaySolution()
}
