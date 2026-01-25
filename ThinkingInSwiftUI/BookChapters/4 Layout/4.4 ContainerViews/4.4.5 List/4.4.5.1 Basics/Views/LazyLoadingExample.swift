//
//  LazyLoadingExample.swift
//  ThinkingInSwiftUI
//
//  List Basics - Lazy Loading Demonstration
//

import SwiftUI

struct LazyLoadingExample: View {
    @State private var appearedItems: Set<Int> = []

    var body: some View {
        VStack(spacing: 10) {
            Text("Lazy Loading: Items load as you scroll")
                .font(.headline)

            Text("Appeared: \(appearedItems.count) / 10,000 items")
                .font(.caption)
                .foregroundColor(.secondary)

            List(0..<10000, id: \.self) { i in
                HStack {
                    Text("Item \(i)")
                    Spacer()
                    if appearedItems.contains(i) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    }
                }
                .onAppear {
                    appearedItems.insert(i)
                }
                .onDisappear {
                    appearedItems.remove(i)
                }
            }
        }
    }
}

#Preview {
    LazyLoadingExample()
}
