//
//  BookmarkExample.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Shapes - Custom Bookmark Shape
//

import SwiftUI

struct BookmarkExampleView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Custom Shapes: Bookmark")
                    .font(.title)
                    .bold()

                creatingCustomShapesSection
                liveExampleSection
                pathImplementationSection
                sizeThatFitsImplementationSection
                behaviorAtProposalsSection
            }
            .padding()
        }
    }

    // MARK: - Sections

    private var creatingCustomShapesSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("Creating Custom Shapes")
                    .font(.headline)

                Text("""
                You can create custom shapes by conforming to the Shape protocol:

                protocol Shape {
                    func path(in rect: CGRect) -> Path
                    func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize
                }

                • path(in:) - Draw the shape within given rectangle
                • sizeThatFits(_:) - Determine size based on proposal (optional)

                Default sizeThatFits accepts any proposal (like Rectangle).
                """)
                .font(.caption)
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }

    private var liveExampleSection: some View {
        GroupBox("Live Example: Bookmark Shape") {
            VStack(spacing: 15) {
                Bookmark()
                    .fill(Color.blue.opacity(0.3))
                    .stroke(Color.blue, lineWidth: 3)
                    .frame(width: 150, height: 200)

                Text("Custom bookmark shape with 2:3 aspect ratio")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
    }

    private var pathImplementationSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("Implementation: path(in:)")
                    .font(.headline)

                Text("""
                struct Bookmark: Shape {
                    func path(in rect: CGRect) -> Path {
                        Path { p in
                            p.addLines([
                                rect[.topLeading],
                                rect[.bottomLeading],
                                rect[.init(x: 0.5, y: 0.8)],  // V-notch
                                rect[.bottomTrailing],
                                rect[.topTrailing],
                                rect[.topLeading]
                            ])
                            p.closeSubpath()
                        }
                    }
                }

                Helper extension for UnitPoint subscripting:
                extension CGRect {
                    subscript(_ point: UnitPoint) -> CGPoint {
                        CGPoint(
                            x: minX + width * point.x,
                            y: minY + height * point.y
                        )
                    }
                }
                """)
                .font(.system(.caption, design: .monospaced))
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }

    private var sizeThatFitsImplementationSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("Implementation: sizeThatFits(_:)")
                    .font(.headline)

                Text("""
                func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize {
                    var result = proposal.replacingUnspecifiedDimensions()
                    let ratio: CGFloat = 2/3
                    let newWidth = ratio * result.height

                    if newWidth <= result.width {
                        result.width = newWidth
                    } else {
                        result.height = result.width / ratio
                    }

                    return result
                }

                This maintains a 2:3 aspect ratio (width:height).

                Logic:
                1. Start with proposed size (convert nil → 10)
                2. Calculate ideal width from height (2/3 ratio)
                3. If ideal width fits, use it (height stays)
                4. Otherwise, calculate height from width
                5. Return constrained size
                """)
                .font(.system(.caption, design: .monospaced))
                .padding(8)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }

    private var behaviorAtProposalsSection: some View {
        GroupBox("Behavior at Different Proposals") {
            VStack(spacing: 15) {
                VStack {
                    Text("Proposed: 300×200")
                        .font(.caption)
                    Bookmark()
                        .fill(Color.teal.opacity(0.3))
                        .stroke(Color.teal, lineWidth: 2)
                        .frame(width: 300, height: 200)
                        .border(Color.red, width: 1)
                    Text("Reports: 133×200 (constrained by width)")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }

                VStack {
                    Text("Proposed: 100×300")
                        .font(.caption)
                    Bookmark()
                        .fill(Color.purple.opacity(0.3))
                        .stroke(Color.purple, lineWidth: 2)
                        .frame(width: 100, height: 300)
                        .border(Color.red, width: 1)
                    Text("Reports: 100×150 (constrained by height)")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
    }
}

#Preview {
    BookmarkExampleView()
}
