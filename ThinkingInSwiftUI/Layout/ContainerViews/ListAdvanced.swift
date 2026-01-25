//
//  ListAdvanced.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Container Views - List Advanced
//  Height estimation, dynamic content, and layout summary
//

import SwiftUI

// MARK: - Height Proposal Behavior (nil = unlimited)

struct ListHeightProposalExample: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("List proposes nil (unlimited) for height")
                .font(.headline)

            List {
                // Different height content - each determines its own height
                VStack(alignment: .leading, spacing: 8) {
                    Text("Small Item")
                        .font(.caption)
                }
                .padding(8)
                .background(Color.blue.opacity(0.2))

                VStack(alignment: .leading, spacing: 8) {
                    Text("Medium Item")
                        .font(.body)
                    Text("With subtitle")
                        .font(.caption)
                }
                .padding()
                .background(Color.green.opacity(0.2))

                VStack(alignment: .leading, spacing: 8) {
                    Text("Large Item")
                        .font(.title)
                    Text("With more content")
                    Text("And even more")
                    Text("Taking up space")
                }
                .padding()
                .background(Color.orange.opacity(0.2))
            }
            .frame(height: 400)
        }
        .padding()
    }
}

// MARK: - Height Estimation Example

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

// MARK: - Dynamic Content Heights

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

// MARK: - List Layout Behavior Summary

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

// MARK: - Supporting Types

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

// MARK: - Preview

#Preview {
    TabView {
        ListHeightProposalExample()
            .tabItem { Label("Height", systemImage: "1.circle") }

        HeightEstimationExample()
            .tabItem { Label("Estimation", systemImage: "2.circle") }

        DynamicHeightItemsExample()
            .tabItem { Label("Dynamic", systemImage: "3.circle") }

        ListLayoutSummary()
            .tabItem { Label("Summary", systemImage: "4.circle") }
    }
}
