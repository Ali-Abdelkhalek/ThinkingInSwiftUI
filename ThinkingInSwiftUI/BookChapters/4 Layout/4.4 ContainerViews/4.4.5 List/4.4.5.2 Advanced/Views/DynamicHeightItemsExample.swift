//
//  DynamicHeightItemsExample.swift
//  ThinkingInSwiftUI
//
//  List Advanced - Dynamic Content Heights
//

import SwiftUI
import Foundation

struct DynamicHeightItemsExample: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("List handles dynamic row heights")
                .font(.headline)

            List {
                ForEach(sampleItems) { item in
                    ItemRow(item: item)
                }
            }
        }
    }
}

// MARK: - Supporting Types

fileprivate struct ItemRow: View {
    let item: SampleItem
    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(item.title)
                    .font(.headline)
                Spacer()
                Button(isExpanded ? "Collapse" : "Expand") {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
                .font(.caption)
            }

            if isExpanded {
                Text(item.details)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

fileprivate struct SampleItem: Identifiable {
    let id = UUID()
    let title: String
    let details: String
}

fileprivate let sampleItems = [
    SampleItem(title: "Short Item", details: "Just a brief description."),
    SampleItem(title: "Medium Item", details: "This item has a moderate amount of content that spans multiple lines to demonstrate how List handles varying row heights."),
    SampleItem(title: "Another Short", details: "Brief."),
    SampleItem(title: "Long Item", details: "This is a much longer item with extensive details that really demonstrates how the List container handles dynamic content heights. The list estimates the total height based on the items that have already been rendered, similar to UITableView's automatic height calculation. This allows for efficient scrolling even with thousands of items."),
    SampleItem(title: "Final Item", details: "Last one with medium text.")
]

#Preview {
    DynamicHeightItemsExample()
}
