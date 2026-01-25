//
//  HeightEstimationExample.swift
//  ThinkingInSwiftUI
//
//  List Advanced - Height Estimation Example
//

import SwiftUI

struct HeightEstimationExample: View {
    @State private var itemCount = 5

    var body: some View {
        VStack(spacing: 20) {
            Text("List estimates total height from visible items")
                .font(.headline)

            Text("Items: \(itemCount)")
                .font(.caption)

            Stepper("Item Count", value: $itemCount, in: 1...1000)
                .padding(.horizontal)

            List(0..<itemCount, id: \.self) { i in
                HStack {
                    Text("Item \(i)")
                    Spacer()
                    // Varying heights to show estimation
                    if i % 3 == 0 {
                        Text("Tall")
                            .padding()
                            .background(Color.blue.opacity(0.2))
                    }
                }
            }

            Text("Scroll bar size changes as List estimates content")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    HeightEstimationExample()
}
