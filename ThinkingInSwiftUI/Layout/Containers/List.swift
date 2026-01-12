//
//  List.swift
//  ThinkingInSwiftUI
//
//  Created by Ali Abdelkhalek on 07/04/2025.
//

import SwiftUI

// MARK: - List Layout Behavior
//
// List is SwiftUI's equivalent to UITableView or NSTableView.
//
// Layout characteristics:
// 1. The List view itself takes on the proposed size (like ScrollView)
// 2. It proposes its own width to subviews
// 3. It proposes nil for the height to subviews (unlimited vertical space)
//
// Lazy Layout:
// - List items are laid out lazily (only when they come into view)
// - Similar to UITableView with non-fixed row heights
// - List estimates the entire content height based on items already laid out
//
// Note: At the time of the book's writing, List was still very limited and
// allowed little configuration compared to what it is today.

// MARK: - Basic Example: List Layout Behavior

struct BasicListExample: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("List accepts the proposed size")
                .font(.headline)

            List(0..<20, id: \.self) { i in
                Text("Item \(i)")
            }
            .border(Color.red, width: 2)
        }
        .padding()
    }
}

// MARK: - Lazy Loading Demonstration

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

// MARK: - List vs ScrollView Layout Comparison

struct ListVsScrollViewComparison: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("List vs ScrollView")
                .font(.title2)
                .bold()

            HStack(spacing: 20) {
                // List
                VStack {
                    Text("List")
                        .font(.headline)
                    List(0..<5, id: \.self) { i in
                        Text("Item \(i)")
                    }
                    .border(Color.blue, width: 2)
                    Text("Lazy loading")
                        .font(.caption)
                }

                // ScrollView
                VStack {
                    Text("ScrollView")
                        .font(.headline)
                    ScrollView {
                        VStack {
                            ForEach(0..<5, id: \.self) { i in
                                Text("Item \(i)")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                            }
                        }
                    }
                    .border(Color.red, width: 2)
                    Text("Eager loading")
                        .font(.caption)
                }
            }
        }
        .padding()
    }
}

// MARK: - Width Proposal Behavior

struct ListWidthProposalExample: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("List proposes its width to children")
                .font(.headline)

            List {
                // Text accepts the proposed width
                Text("Short")
                    .background(Color.blue.opacity(0.2))

                // This also gets the full width
                Text("This is a much longer text that demonstrates width")
                    .background(Color.green.opacity(0.2))

                // Even shapes get the proposed width (but need explicit height)
                Rectangle()
                    .fill(Color.orange.opacity(0.3))
                    .frame(height: 50)
            }
            .frame(height: 300)
        }
        .padding()
    }
}

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

struct ItemRow: View {
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

struct BehaviorRow: View {
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

struct SampleItem: Identifiable {
    let id = UUID()
    let title: String
    let details: String
}

let sampleItems = [
    SampleItem(title: "Short Item", details: "Just a brief description."),
    SampleItem(title: "Medium Item", details: "This item has a moderate amount of content that spans multiple lines to demonstrate how List handles varying row heights."),
    SampleItem(title: "Another Short", details: "Brief."),
    SampleItem(title: "Long Item", details: "This is a much longer item with extensive details that really demonstrates how the List container handles dynamic content heights. The list estimates the total height based on the items that have already been rendered, similar to UITableView's automatic height calculation. This allows for efficient scrolling even with thousands of items."),
    SampleItem(title: "Final Item", details: "Last one with medium text.")
]

// MARK: - Preview

#Preview {
    TabView {
        BasicListExample()
            .tabItem { Label("Basic", systemImage: "1.circle") }

        LazyLoadingExample()
            .tabItem { Label("Lazy Loading", systemImage: "2.circle") }

        ListVsScrollViewComparison()
            .tabItem { Label("vs ScrollView", systemImage: "3.circle") }

        ListWidthProposalExample()
            .tabItem { Label("Width", systemImage: "4.circle") }

        ListHeightProposalExample()
            .tabItem { Label("Height", systemImage: "5.circle") }

        HeightEstimationExample()
            .tabItem { Label("Estimation", systemImage: "6.circle") }

        DynamicHeightItemsExample()
            .tabItem { Label("Dynamic", systemImage: "7.circle") }

        ListLayoutSummary()
            .tabItem { Label("Summary", systemImage: "8.circle") }
    }
}
