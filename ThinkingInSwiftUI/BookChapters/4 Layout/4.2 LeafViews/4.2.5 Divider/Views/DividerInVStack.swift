//
//  DividerInVStack.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Divider - VStack Behavior
//

import SwiftUI

struct DividerInVStackView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Divider in VStack")
                .font(.title)
                .bold()
                .padding()

            Text("Behavior:")
                .font(.headline)
            Text("• Accepts any proposed WIDTH")
            Text("• Reports fixed HEIGHT (1-2pt)")
            Text("• Creates HORIZONTAL line")
                .padding(.bottom)

            Divider()
                .background(Color.red.opacity(0.3))

            VStack(spacing: 20) {
                Text("Section 1")
                    .font(.title2)
                    .foregroundColor(.blue)

                Divider()
                    .background(Color.red.opacity(0.3))

                Text("Section 2")
                    .font(.title2)
                    .foregroundColor(.green)

                Divider()
                    .background(Color.red.opacity(0.3))

                Text("Section 3")
                    .font(.title2)
                    .foregroundColor(.orange)
            }
            .padding()

            Spacer()

            Text("Red background shows divider area")
                .font(.caption)
                .foregroundColor(.gray)
                .padding()
        }
    }
}

#Preview {
    DividerInVStackView()
}
