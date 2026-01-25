//
//  DividerInHStack.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Divider - HStack Behavior
//

import SwiftUI

struct DividerInHStackView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Divider in HStack")
                .font(.title)
                .bold()

            Text("Behavior:")
                .font(.headline)
            Text("• Accepts any proposed HEIGHT")
            Text("• Reports fixed WIDTH (1-2pt)")
            Text("• Creates VERTICAL line")

            HStack(spacing: 0) {
                VStack {
                    Text("Left")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
                .frame(maxWidth: .infinity)

                Divider()
                    .background(Color.red.opacity(0.3))

                VStack {
                    Text("Center")
                        .font(.title2)
                        .foregroundColor(.green)
                }
                .frame(maxWidth: .infinity)

                Divider()
                    .background(Color.red.opacity(0.3))

                VStack {
                    Text("Right")
                        .font(.title2)
                        .foregroundColor(.orange)
                }
                .frame(maxWidth: .infinity)
            }
            .frame(height: 200)
            .border(Color.gray, width: 1)

            Text("Red background shows divider area")
                .font(.caption)
                .foregroundColor(.gray)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    DividerInHStackView()
}
