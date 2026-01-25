//
//  ListLayoutSummary.swift
//  ThinkingInSwiftUI
//
//  List Advanced - List Layout Behavior Summary
//

import SwiftUI

struct ListLayoutSummary: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("List Layout Behavior")
                    .font(.title)
                    .bold()

                VStack(alignment: .leading, spacing: 12) {
                    BehaviorRow(
                        icon: "arrow.up.and.down",
                        title: "Size Proposal",
                        description: "List accepts the proposed size (like ScrollView)"
                    )

                    BehaviorRow(
                        icon: "arrow.left.and.right",
                        title: "Width to Children",
                        description: "Proposes its own width to subviews"
                    )

                    BehaviorRow(
                        icon: "arrow.up.to.line",
                        title: "Height to Children",
                        description: "Proposes nil (unlimited) for height"
                    )

                    BehaviorRow(
                        icon: "hourglass",
                        title: "Lazy Loading",
                        description: "Items are laid out only when visible"
                    )

                    BehaviorRow(
                        icon: "ruler",
                        title: "Height Estimation",
                        description: "Estimates total height from visible items"
                    )
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)

                Divider()

                Text("Example List")
                    .font(.headline)

                List(0..<10, id: \.self) { i in
                    Text("Item \(i)")
                }
                .frame(height: 300)
            }
            .padding()
        }
    }
}

// MARK: - Supporting Types

fileprivate struct BehaviorRow: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 30)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    ListLayoutSummary()
}
