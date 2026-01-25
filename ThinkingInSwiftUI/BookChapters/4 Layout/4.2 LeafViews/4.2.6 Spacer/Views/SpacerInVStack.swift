//
//  SpacerInVStack.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Spacer - VStack Behavior
//

import SwiftUI

struct SpacerInVStackView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Spacer in VStack")
                .font(.title)
                .bold()
                .padding()

            Text("Behavior:")
                .font(.headline)
            Text("• Flexible HEIGHT (min to infinity)")
            Text("• Reports WIDTH of zero")
            Text("• Pushes content apart vertically")
                .padding(.bottom)

            // Example 1: Single spacer
            VStack(spacing: 0) {
                Text("Top")
                    .padding()
                    .background(Color.blue.opacity(0.3))

                Spacer()
                    .background(Color.red.opacity(0.2))

                Text("Bottom")
                    .padding()
                    .background(Color.green.opacity(0.3))
            }
            .frame(height: 200)
            .border(Color.gray, width: 2)
            .padding()

            Text("Red area = Spacer (fills available height)")
                .font(.caption)
                .foregroundColor(.gray)

            Spacer()

            // Example 2: Multiple spacers
            VStack(spacing: 0) {
                Text("Top")
                    .padding()
                    .background(Color.blue.opacity(0.3))

                Spacer()
                    .background(Color.red.opacity(0.2))

                Text("Middle")
                    .padding()
                    .background(Color.yellow.opacity(0.3))

                Spacer()
                    .background(Color.red.opacity(0.2))

                Text("Bottom")
                    .padding()
                    .background(Color.green.opacity(0.3))
            }
            .frame(height: 200)
            .border(Color.gray, width: 2)
            .padding()

            Text("Multiple spacers share space equally")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.bottom)
        }
    }
}

#Preview {
    SpacerInVStackView()
}
