//
//  DividerComparison.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Divider - Side-by-side Comparison
//

import SwiftUI

struct DividerComparisonView: View {
    var body: some View {
        HStack(spacing: 0) {
            vStackExample
            Divider()
                .background(Color.green)
            hStackExample
        }
    }

    // MARK: - Sections

    private var vStackExample: some View {
        VStack(spacing: 0) {
            Text("In VStack")
                .font(.headline)
                .padding()

            Text("Item 1")
                .padding()

            Divider()
                .background(Color.red)

            Text("Item 2")
                .padding()

            Divider()
                .background(Color.red)

            Text("Item 3")
                .padding()

            Spacer()

            Text("Horizontal lines\n(flexible width)")
                .font(.caption)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color.blue.opacity(0.1))
    }

    private var hStackExample: some View {
        VStack(spacing: 0) {
            Text("In HStack")
                .font(.headline)
                .padding()

            HStack(spacing: 0) {
                Text("A")
                    .frame(maxWidth: .infinity)
                    .padding()

                Divider()
                    .background(Color.red)

                Text("B")
                    .frame(maxWidth: .infinity)
                    .padding()

                Divider()
                    .background(Color.red)

                Text("C")
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .frame(height: 150)

            Spacer()

            Text("Vertical lines\n(flexible height)")
                .font(.caption)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color.orange.opacity(0.1))
    }
}

#Preview {
    DividerComparisonView()
}
