//
//  4.3.9 RenderingModifiers.swift
//  ThinkingInSwiftUI
//
//  Understanding Rendering Modifiers - Modifiers that affect rendering but NOT layout
//

import SwiftUI

struct RenderingModifiers: View {
    var body: some View {
        TabView {
            RenderingModifiersBasicsSection()
                .tabItem { Label("Basics", systemImage: "1.circle") }

            RenderingModifiersOffsetSection()
                .tabItem { Label("Offset", systemImage: "2.circle") }

            RenderingModifiersRotationAndScaleSection()
                .tabItem { Label("Rotation & Scale", systemImage: "3.circle") }

            RenderingModifiersVisualEffectsSection()
                .tabItem { Label("Visual Effects", systemImage: "4.circle") }

            RenderingModifiersPracticalSection()
                .tabItem { Label("Implications", systemImage: "5.circle") }
        }
    }
}

#Preview {
    RenderingModifiers()
}
