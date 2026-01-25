//
//  ProposedViewSize.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Proposed View Size
//

import SwiftUI

struct ProposedViewSizeView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 30) {
                Text("ProposedViewSize")
                    .font(.title)
                    .bold()

                Text("iOS 16+ / macOS 13+")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                whatIsProposedViewSizeSection
                whatDoesNilMeanSection
                exampleNilProposalSection
                replacingUnspecifiedDimensionsSection
            }
            .padding()
        }
    }

    // MARK: - Sections

    private var whatIsProposedViewSizeSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("What is ProposedViewSize?")
                    .font(.headline)

                Text("""
                ProposedViewSize is used in the Layout protocol (Advanced Layout chapter).
                It represents the size a parent proposes to its child.

                struct ProposedViewSize {
                    var width: CGFloat?
                    var height: CGFloat?
                }

                Key difference from CGSize: Both components are OPTIONAL!
                """)
                .font(.caption)
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }

    private var whatDoesNilMeanSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("What does nil mean?")
                    .font(.headline)

                Text("""
                Proposing nil for a dimension means:
                "The view can become its IDEAL SIZE in that dimension"

                The ideal size is different for each view:
                • Text: Size needed to render without wrapping
                • Image: Intrinsic image dimensions
                • Shape: Default 10×10 (from replacingUnspecifiedDimensions)
                • Color: Would fill infinitely, but needs constraints
                """)
                .font(.caption)
                .padding(8)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }

    private var exampleNilProposalSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("Example: nil Proposal")
                    .font(.headline)

                Text("""
                Text("Hello, World!")
                    .fixedSize()

                fixedSize() proposes nil×nil to the text.

                Result: Text becomes its ideal size (no wrapping)

                At different proposals:
                • Proposed 25×50 → Reports 44×10 (ideal, draws out of bounds!)
                • Proposed 50×50 → Reports 44×10 (ideal)
                • Proposed 100×50 → Reports 44×10 (ideal)
                """)
                .font(.system(.caption, design: .monospaced))
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)

                HStack(spacing: 20) {
                    VStack {
                        Text("With fixedSize")
                            .font(.caption)
                            .bold()

                        Text("Hello, World!")
                            .fixedSize()
                            .frame(width: 25, height: 50)
                            .border(Color.red, width: 2)

                        Text("Overflows!")
                            .font(.caption2)
                            .foregroundColor(.red)
                    }

                    VStack {
                        Text("Without fixedSize")
                            .font(.caption)
                            .bold()

                        Text("Hello, World!")
                            .frame(width: 25, height: 50)
                            .border(Color.blue, width: 2)

                        Text("Wraps")
                            .font(.caption2)
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }

    private var replacingUnspecifiedDimensionsSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("replacingUnspecifiedDimensions")
                    .font(.headline)

                Text("""
                When a view receives a proposal with nil components, it needs to convert to concrete values.

                proposal.replacingUnspecifiedDimensions()

                Default replacement: 10×10

                This is why shapes in ScrollView default to 10pt on the scroll axis!

                ScrollView {
                    Rectangle()  // Becomes 10pt tall (nil height → 10)
                }

                Fix with explicit size:
                ScrollView {
                    Rectangle()
                        .frame(height: 200)
                }
                """)
                .font(.caption)
                .padding(8)
                .background(Color.orange.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }
}

#Preview {
    ProposedViewSizeView()
}

