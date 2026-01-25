//
//  WhenDoesBleedHappen.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Color - When Bleed Happens
//

import SwiftUI

struct WhenDoesBleedHappenView: View {
    var body: some View {
        VStack(spacing: 20) {
            titleSection
            centeredBoxExample
            explanationSection
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.cyan.opacity(0.2))
    }

    // MARK: - Sections

    private var titleSection: some View {
        VStack(spacing: 10) {
            Text("When Does Color Bleed?")
                .font(.title)
                .bold()
                .padding(.top)

            Text("Rule: Color bleeds when it touches non-safe area boundaries")
                .multilineTextAlignment(.center)
                .padding()
                .background(Color.yellow.opacity(0.3))
                .cornerRadius(10)
        }
    }

    private var centeredBoxExample: some View {
        VStack {
            Spacer()

            VStack {
                Text("Centered Box")
                    .font(.headline)
                Text("Does NOT touch edges")
                Text("→ NO BLEED")
                    .foregroundColor(.green)
            }
            .padding(40)
            .background(Color.green.opacity(0.3))
            .cornerRadius(10)

            Spacer()
        }
    }

    private var explanationSection: some View {
        Text("Green doesn't touch screen edges\nso it doesn't bleed")
            .font(.caption)
            .multilineTextAlignment(.center)
    }
}

#Preview {
    WhenDoesBleedHappenView()
}
