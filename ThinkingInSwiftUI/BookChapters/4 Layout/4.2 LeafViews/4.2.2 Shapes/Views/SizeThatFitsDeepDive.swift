//
//  SizeThatFitsDeepDive.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Shapes - sizeThatFits Deep Dive
//

import SwiftUI

struct SizeThatFitsDeepDiveView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("sizeThatFits Deep Dive")
                    .font(.title)
                    .bold()

                whatIsSizeThatFitsSection
                defaultImplementationSection
                customExamplesSection
                whenToUseSection
            }
            .padding()
        }
    }

    // MARK: - Sections

    private var whatIsSizeThatFitsSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("What is sizeThatFits?")
                    .font(.headline)

                Text("""
                sizeThatFits(_:) is how a Shape determines its size in response to a size proposal.

                func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize

                Input: ProposedViewSize (width?, height?)
                Output: CGSize (concrete width, height)

                This is the Shape protocol's equivalent to the layout algorithm's "child determines size" step.
                """)
                .font(.caption)
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }

    private var defaultImplementationSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("Default Implementation")
                    .font(.headline)

                Text("""
                If you don't implement sizeThatFits, Shape provides a default:

                func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize {
                    proposal.replacingUnspecifiedDimensions()
                }

                This means:
                • nil width → 10pt
                • nil height → 10pt
                • Otherwise, use proposed value

                Most shapes (Rectangle, Ellipse, etc.) use this default.
                They accept ANY proposed size.
                """)
                .font(.caption)
                .padding(8)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }

    private var customExamplesSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("Custom sizeThatFits Examples")
                    .font(.headline)

                Text("""
                Example 1: Fixed Aspect Ratio

                func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize {
                    let size = proposal.replacingUnspecifiedDimensions()
                    let side = min(size.width, size.height)
                    return CGSize(width: side, height: side)
                }

                Behaves like Circle - always square!

                Example 2: Minimum Size

                func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize {
                    let size = proposal.replacingUnspecifiedDimensions()
                    return CGSize(
                        width: max(size.width, 50),
                        height: max(size.height, 50)
                    )
                }

                Never smaller than 50×50.

                Example 3: Preferred Size

                func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize {
                    if proposal.width == nil && proposal.height == nil {
                        return CGSize(width: 100, height: 100)  // Ideal
                    }
                    return proposal.replacingUnspecifiedDimensions()
                }

                When proposed nil×nil, returns preferred 100×100.
                """)
                .font(.system(.caption, design: .monospaced))
                .padding(8)
                .background(Color.green.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }

    private var whenToUseSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("When to Use Custom sizeThatFits")
                    .font(.headline)

                VStack(alignment: .leading, spacing: 8) {
                    Text("✅ Maintain aspect ratio (like Bookmark)")
                    Text("✅ Enforce minimum/maximum sizes")
                    Text("✅ Preferred/ideal size when proposed nil")
                    Text("✅ Complex sizing logic (e.g., text-based shapes)")
                    Text("❌ When you want to accept any size (use default)")
                }
                .font(.caption)
                .padding(8)
                .background(Color.orange.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }
}

#Preview {
    SizeThatFitsDeepDiveView()
}
