//
//  4.3.3 FlexibleFrames.swift
//  ThinkingInSwiftUI
//
//  Chapter 4.3.3: Flexible Frames
//

import SwiftUI

struct FlexibleFrames: View {
    var body: some View {
        TabView {
            FlexibleFramesBasics()
                .tabItem {
                    Label("Parameters", systemImage: "slider.horizontal.3")
                }

            FlexibleFramesLayoutProcess()
                .tabItem {
                    Label("Layout Process", systemImage: "arrow.left.arrow.right")
                }

            FlexibleFramesConflicts()
                .tabItem {
                    Label("Conflicts", systemImage: "exclamationmark.triangle")
                }
        }
    }
}

#Preview {
    FlexibleFrames()
}
