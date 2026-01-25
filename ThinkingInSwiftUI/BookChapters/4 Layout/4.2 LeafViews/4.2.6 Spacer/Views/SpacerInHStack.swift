//
//  SpacerInHStack.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Spacer - HStack Behavior
//

import SwiftUI

struct SpacerInHStackView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Spacer in HStack")
                .font(.title)
                .bold()

            Text("Behavior:")
                .font(.headline)
            Text("• Flexible WIDTH (min to infinity)")
            Text("• Reports HEIGHT of zero")
            Text("• Pushes content apart horizontally")

            // Example 1: Single spacer
            VStack(alignment: .leading, spacing: 10) {
                Text("Right-aligned:")
                    .font(.headline)

                HStack(spacing: 0) {
                    Spacer()
                        .background(Color.red.opacity(0.2))

                    Text("Right")
                        .padding()
                        .background(Color.blue.opacity(0.3))
                }
                .frame(height: 60)
                .border(Color.gray, width: 2)
            }
            .padding()

            // Example 2: Spacers on both sides
            VStack(alignment: .leading, spacing: 10) {
                Text("Centered:")
                    .font(.headline)

                HStack(spacing: 0) {
                    Spacer()
                        .background(Color.red.opacity(0.2))

                    Text("Center")
                        .padding()
                        .background(Color.yellow.opacity(0.3))

                    Spacer()
                        .background(Color.red.opacity(0.2))
                }
                .frame(height: 60)
                .border(Color.gray, width: 2)
            }
            .padding()

            // Example 3: Multiple items
            VStack(alignment: .leading, spacing: 10) {
                Text("Spread out:")
                    .font(.headline)

                HStack(spacing: 0) {
                    Text("L")
                        .padding()
                        .background(Color.blue.opacity(0.3))

                    Spacer()
                        .background(Color.red.opacity(0.2))

                    Text("M")
                        .padding()
                        .background(Color.yellow.opacity(0.3))

                    Spacer()
                        .background(Color.red.opacity(0.2))

                    Text("R")
                        .padding()
                        .background(Color.green.opacity(0.3))
                }
                .frame(height: 60)
                .border(Color.gray, width: 2)
            }
            .padding()

            Spacer()
        }
    }
}

#Preview {
    SpacerInHStackView()
}
