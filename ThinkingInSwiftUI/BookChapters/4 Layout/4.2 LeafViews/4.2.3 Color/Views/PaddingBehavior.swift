//
//  PaddingBehavior.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Color - Padding Behavior
//

import SwiftUI

struct PaddingBehaviorView: View {
    var body: some View {
        HStack(spacing: 0) {
            noPaddingExample
            Divider()
            withPaddingExample
        }
    }

    // MARK: - Sections

    private var noPaddingExample: some View {
        VStack(spacing: 0) {
            Text("TOP")
                .font(.title3)
                .bold()
                .background(Color.yellow)

            Spacer()

            VStack {
                Text("No .padding()")
                    .font(.headline)
                Text("At safe area edge")
                    .font(.caption)
            }

            Spacer()

            Text("BOTTOM")
                .font(.title3)
                .bold()
                .background(Color.yellow)
        }
        .frame(maxWidth: .infinity)
        .background(Color.red.opacity(0.5))
    }

    private var withPaddingExample: some View {
        VStack(spacing: 0) {
            Text("TOP")
                .font(.title3)
                .bold()
                .background(Color.yellow)

            Spacer()

            VStack {
                Text("With .padding()")
                    .font(.headline)
                Text("Safe area + 16pt")
                    .font(.caption)
            }

            Spacer()

            Text("BOTTOM")
                .font(.title3)
                .bold()
                .background(Color.yellow)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.blue.opacity(0.5))
    }
}

#Preview {
    PaddingBehaviorView()
}
