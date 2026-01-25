//
//  ListBasics.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Container Views - List Basics
//  Understanding List layout behavior and lazy loading
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
    }
}
