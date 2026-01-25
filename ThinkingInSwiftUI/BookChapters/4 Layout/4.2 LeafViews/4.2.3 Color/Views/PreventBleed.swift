//
//  PreventBleed.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Color - How to Prevent Bleed
//

import SwiftUI

struct PreventBleedView: View {
    var body: some View {
        VStack(spacing: 30) {
            titleSection
            optionsSection
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.green,
            ignoresSafeAreaEdges: []  // ← No bleed!
        )
    }

    // MARK: - Sections

    private var titleSection: some View {
        Text("Prevent Color Bleed")
            .font(.title)
            .bold()
            .padding(.top)
    }

    private var optionsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            option1Section
            option2Section
            option3Section
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }

    private var option1Section: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Option 1: Use Rectangle")
                .font(.headline)
            Text(".background(Rectangle().fill(Color.red))")
                .font(.caption)
                .fontDesign(.monospaced)
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
        }
    }

    private var option2Section: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Option 2: ignoresSafeAreaEdges")
                .font(.headline)
            Text(".background(Color.red, ignoresSafeAreaEdges: [])")
                .font(.caption)
                .fontDesign(.monospaced)
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
        }
    }

    private var option3Section: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Option 3: Don't touch edges")
                .font(.headline)
            Text("Keep views away from safe area boundaries with padding/spacing")
                .font(.caption)
        }
    }
}

#Preview {
    PreventBleedView()
}
