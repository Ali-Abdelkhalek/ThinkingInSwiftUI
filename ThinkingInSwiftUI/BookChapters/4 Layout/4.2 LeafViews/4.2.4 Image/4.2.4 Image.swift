//
//  4.2.4 Image.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Image
//  Wrapper view for Image sizing behavior demos
//

import SwiftUI

struct ImageLeafView: View {
    var body: some View {
        TabView {
            DefaultImageView()
                .tabItem { Label("Default", systemImage: "1.circle") }

            ResizableImageView()
                .tabItem { Label("Resizable", systemImage: "2.circle") }

            ImageAspectRatioView()
                .tabItem { Label("Aspect", systemImage: "3.circle") }

            ResizingModesView()
                .tabItem { Label("Modes", systemImage: "4.circle") }
        }
    }
}

#Preview {
    ImageLeafView()
}
