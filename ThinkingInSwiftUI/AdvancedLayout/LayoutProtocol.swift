//
//  LayoutProtocol.swift
//  ThinkingInSwiftUI
//
//  Chapter 7: Advanced Layout - The Layout Protocol
//  Building custom layouts with the modern API (iOS 16+)
//

import SwiftUI

// MARK: - Tab 1: Understanding Layout Protocol

@available(iOS 16, macOS 13, *)
struct UnderstandingLayoutProtocolView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("The Layout Protocol")
                    .font(.title)
                    .bold()

                Text("iOS 16+ / macOS 13+")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("What is the Layout Protocol?")
                            .font(.headline)

                        Text("""
                        The Layout protocol lets you build CUSTOM LAYOUT CONTAINERS - views that arrange their subviews using your own algorithm.

                        Use cases:
                        • Masonry/Pinterest-style layouts
                        • Flow layouts (text-like wrapping)
                        • Circular/radial layouts
                        • Custom grids with special rules
                        • Wrapping/extending built-in layouts

                        Unlike basic layout primitives (HStack, VStack, ZStack), you get access to:
                        • Proposed sizes from parent
                        • Ability to measure subviews
                        • Full control over placement
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Two-Step Process")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 12) {
                            StepView(
                                step: "1",
                                title: "sizeThatFits",
                                description: "Determine container size by measuring subviews"
                            )

                            StepView(
                                step: "2",
                                title: "placeSubviews",
                                description: "Position each subview within the container"
                            )
                        }

                        Text("""
                        Step 1: sizeThatFits(proposal:subviews:cache:)
                        • Parent proposes a size to your layout
                        • You measure subviews by proposing sizes to THEM
                        • You return your container's size

                        Step 2: placeSubviews(in:proposal:subviews:cache:)
                        • You have the bounds (container size from step 1)
                        • You place each subview at a specific position
                        • You can propose different sizes when placing
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: FlowLayout")
                            .font(.headline)

                        Text("""
                        HStack puts all views on ONE line.
                        FlowLayout WRAPS to next line when views don't fit.

                        Like how text wraps when a word doesn't fit!

                        Algorithm:
                        1. Ask each subview for its ideal size (propose nil×nil)
                        2. Place views left-to-right on current line
                        3. When next view doesn't fit, start new line
                        4. Repeat until all views placed
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Why Use Layout Protocol?")
                            .font(.headline)

                        Text("""
                        Before iOS 16:
                        • Had to use GeometryReader + Preferences + ZStack
                        • Complex, verbose, error-prone
                        • Performance concerns

                        With Layout Protocol:
                        • Clean, declarative API
                        • Better performance (potentially)
                        • Type-safe
                        • Integrates with SwiftUI's layout system

                        But: Only works on iOS 16+/macOS 13+
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Tab 2: Building FlowLayout

@available(iOS 16, macOS 13, *)
struct BuildingFlowLayoutView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Building FlowLayout")
                    .font(.title)
                    .bold()

                GroupBox("Live Demo") {
                    VStack(spacing: 15) {
                        FlowLayout(spacing: 8) {
                            ForEach(0..<12, id: \.self) { idx in
                                Text("Item \(idx)")
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.random)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        }
                        .border(Color.blue)
                        .frame(width: 250)
                        .border(Color.black)

                        Text("Resize the window to see wrapping!")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Layout Algorithm")
                            .font(.headline)

                        Text("""
                        func layout(sizes: [CGSize], spacing: CGSize, containerWidth: CGFloat) -> [CGRect] {
                            var result: [CGRect] = []
                            var currentPosition: CGPoint = .zero

                            func startNewline() {
                                if currentPosition.x == 0 { return }
                                currentPosition.x = 0
                                currentPosition.y = result.union().maxY + spacing.height
                            }

                            for size in sizes {
                                if currentPosition.x + size.width > containerWidth {
                                    startNewline()
                                }
                                result.append(CGRect(origin: currentPosition, size: size))
                                currentPosition.x += size.width + spacing.width
                            }

                            return result
                        }

                        This is pure logic - works independently of SwiftUI!
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Implementing the Protocol")
                            .font(.headline)

                        Text("""
                        struct FlowLayout: Layout {
                            var spacing: CGFloat = 10

                            func sizeThatFits(
                                proposal: ProposedViewSize,
                                subviews: Subviews,
                                cache: inout ()
                            ) -> CGSize {
                                let containerWidth = proposal.replacingUnspecifiedDimensions().width
                                let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
                                let frames = layout(sizes: sizes, spacing: spacing, containerWidth: containerWidth)
                                return frames.union().size
                            }

                            func placeSubviews(
                                in bounds: CGRect,
                                proposal: ProposedViewSize,
                                subviews: Subviews,
                                cache: inout ()
                            ) {
                                let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
                                let frames = layout(sizes: sizes, spacing: spacing, containerWidth: bounds.width)

                                for (frame, subview) in zip(frames, subviews) {
                                    let offset = CGPoint(
                                        x: frame.origin.x + bounds.minX,
                                        y: frame.origin.y + bounds.minY
                                    )
                                    subview.place(at: offset, proposal: .unspecified)
                                }
                            }
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Key Points")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("• .unspecified means 'what's your ideal size?'")
                                .font(.caption)
                            Text("• union() combines all rects into bounding rect")
                                .font(.caption)
                            Text("• Container width ≠ widest line (like Text wrapping)")
                                .font(.caption)
                            Text("• Same algorithm used in both methods")
                                .font(.caption)
                        }
                        .padding(8)
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(5)
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Tab 3: Advanced Features

@available(iOS 16, macOS 13, *)
struct AdvancedLayoutFeaturesView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Advanced Features")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Cache")
                            .font(.headline)

                        Text("""
                        Share computation between sizeThatFits and placeSubviews:

                        struct FlowLayout: Layout {
                            struct Cache {
                                var frames: [CGRect] = []
                            }

                            func makeCache(subviews: Subviews) -> Cache {
                                Cache()
                            }

                            func sizeThatFits(..., cache: inout Cache) -> CGSize {
                                cache.frames = layout(...)  // Store
                                return cache.frames.union().size
                            }

                            func placeSubviews(..., cache: inout Cache) {
                                // Reuse cache.frames instead of recalculating!
                            }
                        }

                        ⚠️ Only use cache if you have a performance problem!
                        Premature optimization adds complexity.
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Alignment Guides")
                            .font(.headline)

                        Text("""
                        Expose custom alignment guides:

                        func explicitAlignment(
                            of guide: HorizontalAlignment,
                            in bounds: CGRect,
                            proposal: ProposedViewSize,
                            subviews: Subviews,
                            cache: inout Cache
                        ) -> CGFloat? {
                            // Return custom alignment value
                            // Can query subviews for THEIR alignment guides
                        }

                        Example: FlowLayout could expose firstFlowBaseline and lastFlowBaseline alignments.
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("LayoutSubview APIs")
                            .font(.headline)

                        Text("""
                        Each subview proxy provides:

                        .sizeThatFits(proposal) -> CGSize
                        • Measure by proposing different sizes
                        • Can call MULTIPLE times to probe flexibility

                        .dimensions(in: proposal) -> ViewDimensions
                        • Get width, height, AND alignment guides
                        • Useful for aligning on baselines

                        .spacing
                        • Subview's preferred spacing
                        • Use if no explicit spacing specified

                        .priority
                        • Layout priority (useful for stacks)

                        subscript[LayoutValueKey] -> Value
                        • Read custom layout values from subviews
                        • Like environment, but for layout data
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Probing for Flexibility")
                            .font(.headline)

                        Text("""
                        Like HStack/VStack, you can probe subviews:

                        // Ask: What if I give you 100 points?
                        let size1 = subview.sizeThatFits(ProposedViewSize(width: 100, height: nil))

                        // Ask: What if I give you 200 points?
                        let size2 = subview.sizeThatFits(ProposedViewSize(width: 200, height: nil))

                        if size1 == size2 {
                            // View is inflexible (fixed size)
                        } else {
                            // View is flexible (can grow)
                        }

                        This is how stacks determine which views to prioritize!
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("AnyLayout - Dynamic Switching")
                            .font(.headline)

                        Text("""
                        Switch between layouts dynamically:

                        @State private var useFlow = true

                        var layout: AnyLayout {
                            useFlow ? AnyLayout(FlowLayout()) : AnyLayout(VStackLayout())
                        }

                        layout {
                            ForEach(items) { item in
                                ItemView(item)
                            }
                        }

                        When switched inside withAnimation, subviews animate to new positions!
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(5)
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Tab 4: MasonryLayout Example

@available(iOS 16, macOS 13, *)
struct MasonryLayoutView: View {
    @State private var numberOfColumns = 3
    @State private var spacing: CGFloat = 8

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("MasonryLayout")
                    .font(.title)
                    .bold()

                Text("Pinterest-style masonry layout with balanced columns")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("What is a Masonry Layout?")
                            .font(.headline)

                        Text("""
                        A masonry layout (like Pinterest) arranges items of varying heights into columns, placing each new item in the shortest column.

                        Key characteristics:
                        • Fixed number of columns
                        • Variable item heights
                        • Minimizes vertical gaps
                        • Balances column heights

                        Algorithm:
                        1. Calculate column width
                        2. Track current height of each column
                        3. Place each item in the shortest column
                        4. Update that column's height
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox("Live Demo") {
                    VStack(spacing: 15) {
                        // Controls
                        VStack(spacing: 10) {
                            HStack {
                                Text("Columns: \(numberOfColumns)")
                                    .font(.caption)
                                Spacer()
                                Stepper("", value: $numberOfColumns, in: 2...5)
                            }

                            HStack {
                                Text("Spacing: \(Int(spacing))")
                                    .font(.caption)
                                Spacer()
                                Slider(value: $spacing, in: 4...20, step: 2)
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.05))
                        .cornerRadius(8)
                        ScrollView {
                            // Masonry Layout Demo
                            MasonryLayout(columns: numberOfColumns, spacing: spacing) {
                                ForEach(0..<20) { index in
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.random)
                                        .overlay {
                                            Text("\(index)")
                                                .font(.title2)
                                                .bold()
                                                .foregroundColor(.white)
                                        }
                                        .frame(height: CGFloat.random(in: 80...200))
                                }
                            }
                            .border(Color.purple, width: 2)
                        }
                        .frame(height: 400)
                    }
                    .padding()
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Implementation")
                            .font(.headline)

                        Text("""
                        struct MasonryLayout: Layout {
                            var columns: Int
                            var spacing: CGFloat

                            func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
                                let width = proposal.replacingUnspecifiedDimensions().width
                                let columnWidth = (width - spacing * CGFloat(columns - 1)) / CGFloat(columns)

                                // Calculate heights by placing items
                                var columnHeights = Array(repeating: 0.0, count: columns)

                                for subview in subviews {
                                    let height = subview.sizeThatFits(.init(width: columnWidth, height: nil)).height
                                    let shortestColumn = columnHeights.enumerated().min(by: { $0.element < $1.element })!.offset
                                    columnHeights[shortestColumn] += height + spacing
                                }

                                let maxHeight = columnHeights.max() ?? 0
                                return CGSize(width: width, height: maxHeight - spacing)
                            }

                            func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
                                let columnWidth = (bounds.width - spacing * CGFloat(columns - 1)) / CGFloat(columns)
                                var columnHeights = Array(repeating: bounds.minY, count: columns)

                                for subview in subviews {
                                    let height = subview.sizeThatFits(.init(width: columnWidth, height: nil)).height
                                    let shortestColumn = columnHeights.enumerated().min(by: { $0.element < $1.element })!.offset

                                    let x = bounds.minX + CGFloat(shortestColumn) * (columnWidth + spacing)
                                    let y = columnHeights[shortestColumn]

                                    subview.place(at: CGPoint(x: x, y: y), proposal: .init(width: columnWidth, height: height))

                                    columnHeights[shortestColumn] += height + spacing
                                }
                            }
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Key Implementation Details")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 12) {
                            StepView(
                                step: "1",
                                title: "Calculate Column Width",
                                description: "(totalWidth - spacing × (cols-1)) ÷ columns"
                            )

                            StepView(
                                step: "2",
                                title: "Track Column Heights",
                                description: "Array of current Y position for each column"
                            )

                            StepView(
                                step: "3",
                                title: "Find Shortest Column",
                                description: "Place next item in column with minimum height"
                            )

                            StepView(
                                step: "4",
                                title: "Update Height",
                                description: "Add item height + spacing to column's height"
                            )
                        }

                        Text("""
                        Why this works:
                        • Greedy algorithm - always choose shortest column
                        • Balances columns naturally
                        • Simple and efficient O(n × cols)
                        • Deterministic layout (same input = same output)

                        Trade-offs:
                        ✅ Minimizes vertical gaps
                        ✅ Balances column heights
                        ✅ Simple to implement
                        ⚠️ Not always optimal (greedy != perfect)
                        ⚠️ Items can appear out of order vertically
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Real-World Usage")
                            .font(.headline)

                        Text("""
                        Perfect for:
                        • Photo galleries (varying aspect ratios)
                        • Pinterest-style content feeds
                        • Product listings with varying details
                        • Card-based layouts with dynamic content

                        ScrollView {
                            MasonryLayout(columns: 2, spacing: 8) {
                                ForEach(photos) { photo in
                                    AsyncImage(url: photo.url) { image in
                                        image.resizable().aspectRatio(contentMode: .fit)
                                    }
                                }
                            }
                            .padding()
                        }

                        Performance tips:
                        • Use @ViewBuilder for subviews
                        • Consider caching column calculations
                        • Lazy loading for large datasets (LazyVStack won't work, use pagination)
                        • Provide fixed item heights if possible for better performance
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(5)
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - MasonryLayout Implementation

@available(iOS 16, macOS 13, *)
struct MasonryLayout: Layout {
    var columns: Int
    var spacing: CGFloat

    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        let width = proposal.replacingUnspecifiedDimensions().width
        let columnWidth = (width - spacing * CGFloat(columns - 1)) / CGFloat(columns)

        // Calculate total height by simulating placement
        var columnHeights = Array(repeating: 0.0, count: columns)

        for subview in subviews {
            let size = subview.sizeThatFits(.init(width: columnWidth, height: nil))
            let shortestColumn = columnHeights.enumerated().min(by: { $0.element < $1.element })!.offset
            columnHeights[shortestColumn] += size.height + spacing
        }

        let maxHeight = columnHeights.max() ?? 0
        return CGSize(width: width, height: max(0, maxHeight - spacing))
    }

    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        let columnWidth = (bounds.width - spacing * CGFloat(columns - 1)) / CGFloat(columns)
        var columnHeights = Array(repeating: bounds.minY, count: columns)

        for subview in subviews {
            let size = subview.sizeThatFits(.init(width: columnWidth, height: nil))
            let shortestColumn = columnHeights.enumerated().min(by: { $0.element < $1.element })!.offset

            let x = bounds.minX + CGFloat(shortestColumn) * (columnWidth + spacing)
            let y = columnHeights[shortestColumn]

            subview.place(
                at: CGPoint(x: x, y: y),
                proposal: .init(width: columnWidth, height: size.height)
            )

            columnHeights[shortestColumn] += size.height + spacing
        }
    }
}

// MARK: - Tab 5: Limitations

@available(iOS 16, macOS 13, *)
struct LayoutLimitationsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Limitations")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Platform Availability")
                            .font(.headline)
                            .foregroundColor(.red)

                        Text("""
                        The Layout protocol requires:
                        • iOS 16+ / macOS 13+ (2022 releases)

                        If supporting older platforms:
                        • Use GeometryReader + Preferences + ZStack
                        • More complex but works back to iOS 13

                        We'll cover preference-based layouts next!
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Can't Modify Subviews")
                            .font(.headline)

                        Text("""
                        You get LayoutSubview PROXIES, not actual Views.

                        ❌ Can't do:
                        • Apply modifiers (.background, .padding, etc.)
                        • Read preferences from subviews
                        • Access View protocol methods
                        • Filter/skip subviews
                        • Add extra views (separators, decorations)

                        ✅ Can do:
                        • Measure subviews
                        • Place subviews
                        • Read custom LayoutValueKey
                        • Query alignment guides

                        Example: Can't build ViewThatFits easily
                        (would need to filter subviews)
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("All Subviews Are Placed")
                            .font(.headline)

                        Text("""
                        You MUST place all subviews - can't skip any.

                        This means:
                        • Can't conditionally hide subviews in layout
                        • Can't implement "show first N that fit"
                        • Can't build ViewThatFits-style logic

                        Workaround:
                        • Place unwanted views offscreen
                        • Use .hidden() modifier before passing to layout
                        • Design layout to handle all subviews
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Can't Add Views")
                            .font(.headline)

                        Text("""
                        You can only work with subviews passed in.

                        ❌ Can't add:
                        • Separators between items
                        • Background decorations
                        • Grid lines
                        • Headers/footers

                        ✅ Workaround:
                        Include these in the view builder:

                        FlowLayout {
                            ForEach(items) { item in
                                ItemView(item)
                                Divider()  // Include separator explicitly
                            }
                        }

                        But you can't insert them automatically.
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("When Layout Protocol Isn't Enough")
                            .font(.headline)

                        Text("""
                        Consider preference-based approach when you need:
                        • Support for iOS 13-15
                        • Filtering subviews
                        • Adding decorative views
                        • Reading view preferences
                        • More complex view manipulation

                        The preference approach is more verbose but more flexible in some ways!
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - FlowLayout Implementation

@available(iOS 16, macOS 13, *)
struct FlowLayout: Layout {
    var spacing: CGFloat

    init(spacing: CGFloat = 10) {
        self.spacing = spacing
    }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let containerWidth = proposal.replacingUnspecifiedDimensions().width
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let frames = layout(sizes: sizes, spacing: spacing, containerWidth: containerWidth)
        return frames.union().size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let frames = layout(sizes: sizes, spacing: spacing, containerWidth: bounds.width)

        for (frame, subview) in zip(frames, subviews) {
            let offset = CGPoint(x: frame.origin.x + bounds.minX, y: frame.origin.y + bounds.minY)
            subview.place(at: offset, proposal: .unspecified)
        }
    }

    private func layout(sizes: [CGSize], spacing: CGFloat, containerWidth: CGFloat) -> [CGRect] {
        var result: [CGRect] = []
        var currentPosition: CGPoint = .zero

        func startNewline() {
            guard currentPosition.x != 0 else { return }
            currentPosition.x = 0
            currentPosition.y = result.union().maxY + spacing
        }

        for size in sizes {
            if currentPosition.x + size.width > containerWidth {
                startNewline()
            }
            result.append(CGRect(origin: currentPosition, size: size))
            currentPosition.x += size.width + spacing
        }

        return result
    }
}

// MARK: - Helper Extensions

fileprivate extension [CGRect] {
    func union() -> CGRect {
        guard !isEmpty else { return .zero }
        return reduce(first!) { $0.union($1) }
    }
}

fileprivate extension Color {
    static var random: Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

// MARK: - Helper Views

fileprivate struct StepView: View {
    let step: String
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text(step)
                .font(.caption)
                .bold()
                .foregroundColor(.white)
                .frame(width: 24, height: 24)
                .background(Circle().fill(Color.blue))

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .bold()
                Text(description)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    if #available(iOS 16, macOS 13, *) {
        TabView {
            UnderstandingLayoutProtocolView()
                .tabItem { Label("Understanding", systemImage: "rectangle.3.group") }

            BuildingFlowLayoutView()
                .tabItem { Label("FlowLayout", systemImage: "rectangle.split.3x1") }
            
            MasonryLayoutView()
                .tabItem { Label("Masonry", systemImage: "square.grid.3x3.square") }

            AdvancedLayoutFeaturesView()
                .tabItem { Label("Advanced", systemImage: "gearshape.2") }

            LayoutLimitationsView()
                .tabItem { Label("Limitations", systemImage: "exclamationmark.triangle") }
        }
    } else {
        Text("Layout Protocol requires iOS 16+ / macOS 13+")
            .font(.title3)
            .foregroundColor(.secondary)
    }
}
