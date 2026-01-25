//
//  ModifiedAlignmentExample.swift
//  ThinkingInSwiftUI
//
//  Advanced Alignments - Modified Alignment Guides
//

import SwiftUI

/// Demonstrates how to override built-in alignment guides to achieve
/// custom positioning that isn't possible with built-in alignments alone.
///
/// THE TRICK:
/// - Parent asks child: "Where is your .top guide?"
/// - Child (with override): "My .top is at height/2" (actually center!)
/// - Parent uses this "fake" guide to position the child
/// - Result: Child's CENTER aligns to parent's TOP
///
/// USE CASES:
/// - Badge overlays (center badge on corner)
/// - Custom positioning within frames
/// - Aligning different guides (center to top, bottom to center, etc.)
///
struct ModifiedAlignmentExample: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Modified Alignment Guides")
                    .font(.title)
                    .bold()

                Text("Override built-in alignment guides with .alignmentGuide")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Why Modify Alignment Guides?")
                            .font(.headline)

                        Text("Built-in alignments only let you align the SAME guide on both views:")
                            .font(.caption)

                        VStack(alignment: .leading, spacing: 6) {
                            Text("✓ Align top of A to top of B")
                                .font(.caption2)
                                .foregroundColor(.green)
                            Text("✓ Align center of A to center of B")
                                .font(.caption2)
                                .foregroundColor(.green)
                            Text("✗ Align center of A to top of B")
                                .font(.caption2)
                                .foregroundColor(.red)
                            Text("✗ Align bottom of A to center of B")
                                .font(.caption2)
                                .foregroundColor(.red)
                        }

                        Text("Solution: Override alignment guides to align different guides!")
                            .font(.caption)
                            .foregroundColor(.orange)
                            .padding(.top, 4)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The 'Trick': Overriding What Alignment Means")
                            .font(.headline)

                        Text("How the override works:")
                            .font(.caption)
                            .bold()

                        VStack(alignment: .leading, spacing: 6) {
                            Text("1. Parent says: 'Use .topTrailing alignment'")
                                .font(.caption2)
                            Text("2. Parent asks child: 'Where is your .top guide?'")
                                .font(.caption2)
                            Text("3. Child (with override): 'My .top is at height/2' (lying - it's actually center!)")
                                .font(.caption2)
                                .foregroundColor(.orange)
                            Text("4. Parent asks: 'Where is your .trailing guide?'")
                                .font(.caption2)
                            Text("5. Child (with override): 'My .trailing is at width/2' (lying - it's actually center!)")
                                .font(.caption2)
                                .foregroundColor(.orange)
                            Text("6. Parent positions child using these 'fake' guides")
                                .font(.caption2)
                            Text("7. Result: Child's CENTER aligns to parent's TOP TRAILING")
                                .font(.caption2)
                                .foregroundColor(.green)
                                .bold()
                        }

                        Text("💡 We 'trick' SwiftUI by redefining what .top and .trailing mean for this view!")
                            .font(.caption)
                            .foregroundColor(.orange)
                            .padding(.top, 8)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: Badge Overlay")
                            .font(.headline)

                        Text("Goal: Overlay badge CENTER on view's TOP TRAILING corner")
                            .font(.caption)

                        Text("Hello")
                            .padding()
                            .background(Color.teal)
                            .customBadge {
                                Circle()
                                    .fill(Color.orange)
                                    .frame(width: 20, height: 20)
                            }

                        Text("How it works:")
                            .font(.caption)
                            .padding(.top, 8)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("1. Overlay uses .topTrailing alignment")
                                .font(.caption2)
                            Text("2. Badge overrides .top to be at its vertical center")
                                .font(.caption2)
                            Text("3. Badge overrides .trailing to be at its horizontal center")
                                .font(.caption2)
                            Text("4. Result: Badge center aligns to view's top trailing")
                                .font(.caption2)
                                .foregroundColor(.green)
                        }

                        Text("Code:")
                            .font(.caption)
                            .padding(.top, 8)

                        Text("""
                        .overlay(alignment: .topTrailing) {
                            badge()
                                .alignmentGuide(.top) { $0.height/2 }
                                .alignmentGuide(.trailing) { $0.width/2 }
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("ViewDimensions Parameter")
                            .font(.headline)

                        Text("The closure receives ViewDimensions with:")
                            .font(.caption)

                        VStack(alignment: .leading, spacing: 6) {
                            Text("• .width - view's width")
                                .font(.caption2)
                            Text("• .height - view's height")
                                .font(.caption2)
                            Text("• [alignment] - access other alignment guides")
                                .font(.caption2)
                        }

                        Text("Example: Use existing alignment guide")
                            .font(.caption)
                            .padding(.top, 8)

                        Text("""
                        .alignmentGuide(.firstTextBaseline) { d in
                            d[VerticalAlignment.center]
                        }
                        // Same as: d.height / 2
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                })
            }
            .padding()
        }
    }
}

// Custom badge modifier extension
extension View {
    func customBadge<B: View>(@ViewBuilder _ badge: () -> B) -> some View {
        overlay(alignment: .topTrailing) {
            badge()
                .alignmentGuide(.top) { $0.height / 2 }
                .alignmentGuide(.trailing) { $0.width / 2 }
        }
    }
}

#Preview {
    ModifiedAlignmentExample()
}
