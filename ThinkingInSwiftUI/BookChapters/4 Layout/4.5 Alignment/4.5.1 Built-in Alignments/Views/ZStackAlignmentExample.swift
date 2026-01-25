//
//  ZStackAlignmentExample.swift
//  ThinkingInSwiftUI
//
//  Built-in Alignments - ZStack Alignment Examples
//

import SwiftUI

/// Demonstrates ZStack's two-step alignment algorithm.
///
/// ZSTACK ALGORITHM:
/// Step 1: Determine ZStack's size
///   1. Ask each subview for size + alignment guides
///   2. Compute subview origins relative to first subview
///   3. Compute union of all subview frames
///   4. Union's size = ZStack's size
///
/// Step 2: Place the subviews
///   1. Compute ZStack's alignment guides based on its size
///   2. Place each subview by subtracting its alignment guides from ZStack's
///
struct ZStackAlignmentExample: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("ZStack Alignment")
                    .font(.title)
                    .bold()

                Text("ZStack aligns multiple subviews relative to each other")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("ZStack Algorithm (2 Steps)")
                            .font(.headline)

                        Text("Step 1: Determine ZStack's own size")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.blue)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("1. Ask each subview for size + alignment guides")
                                .font(.caption2)
                            Text("2. Compute subview origins relative to first subview")
                                .font(.caption2)
                            Text("3. Compute union of all subview frames")
                                .font(.caption2)
                            Text("4. Union's size = ZStack's size")
                                .font(.caption2)
                        }

                        Text("Step 2: Place the subviews")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.green)
                            .padding(.top, 8)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("1. Compute ZStack's alignment guides based on its size")
                                .font(.caption2)
                            Text("2. Place each subview by subtracting its alignment guides from ZStack's")
                                .font(.caption2)
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: Center Alignment")
                            .font(.headline)

                        ZStack(alignment: .center) {
                            Rectangle()
                                .fill(Color.teal)
                                .frame(width: 50, height: 50)
                            Text("Hello, World!")
                                .background(Color.yellow.opacity(0.3))
                        }
                        .border(Color.red, width: 2)

                        Text("Rectangle: 50×50, center at (25, 25)")
                            .font(.caption2)
                            .foregroundColor(.blue)
                        Text("Text: ~100×20, center at (~50, 10)")
                            .font(.caption2)
                            .foregroundColor(.green)
                        Text("ZStack aligns both centers")
                            .font(.caption2)
                            .foregroundColor(.orange)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("All ZStack Alignments")
                            .font(.headline)

                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                            ZStackAlignmentDemo(alignment: .topLeading, label: "topLeading")
                            ZStackAlignmentDemo(alignment: .top, label: "top")
                            ZStackAlignmentDemo(alignment: .topTrailing, label: "topTrailing")
                            ZStackAlignmentDemo(alignment: .leading, label: "leading")
                            ZStackAlignmentDemo(alignment: .center, label: "center")
                            ZStackAlignmentDemo(alignment: .trailing, label: "trailing")
                            ZStackAlignmentDemo(alignment: .bottomLeading, label: "bottomLeading")
                            ZStackAlignmentDemo(alignment: .bottom, label: "bottom")
                            ZStackAlignmentDemo(alignment: .bottomTrailing, label: "bottomTrailing")
                        }
                    }
                })
            }
            .padding()
        }
    }
}

#Preview {
    ZStackAlignmentExample()
}
