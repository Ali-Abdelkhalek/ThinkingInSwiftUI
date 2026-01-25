//
//  ChildrenAtEdges.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Color - Children at Edges
//

import SwiftUI

struct ChildrenAtEdgesView: View {
    var body: some View {
        VStack(spacing: 0) {
            topText
            Spacer()
            explanationSection
            Spacer()
            bottomText
        }
        .background(Color.red.opacity(0.3))
    }

    // MARK: - Sections

    private var topText: some View {
        Text("TOP TEXT")
            .font(.title)
            .bold()
            .background(Color.yellow)
    }

    private var explanationSection: some View {
        VStack(spacing: 10) {
            Text("Key Discovery!")
                .font(.title2)
                .bold()

            Text("The yellow backgrounds BLEED")
                .foregroundColor(.orange)

            Text("Why?")
                .font(.headline)

            Text("Because TOP/BOTTOM texts are positioned at safe area edges")
                .multilineTextAlignment(.center)

            Text("When a view touches the safe area boundary, its Color background bleeds")
                .font(.caption)
                .multilineTextAlignment(.center)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
        }
        .padding()
    }

    private var bottomText: some View {
        Text("BOTTOM TEXT")
            .font(.title)
            .bold()
            .background(Color.yellow)
    }
}

#Preview {
    ChildrenAtEdgesView()
}
