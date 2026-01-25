//
//  IdealSizeScrollView.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Shapes - Ideal Size & ScrollView
//

import SwiftUI

struct IdealSizeScrollViewView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Ideal Size & ScrollView")
                    .font(.title)
                    .bold()

                defaultSizeSection
                problemSection
                solutionSection
                whyItHappensSection
                customIdealSizeSection
                summarySection
            }
            .padding()
        }
    }

    // MARK: - Sections

    private var defaultSizeSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("The Default 10×10 Size")
                    .font(.headline)

                Text("""
                When a shape receives nil for a dimension:

                proposal.replacingUnspecifiedDimensions()
                → CGSize(width: 10, height: 10)

                This is why shapes in ScrollView default to 10pt on the scroll axis!
                """)
                .font(.caption)
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }

    private var problemSection: some View {
        GroupBox("Problem: Tiny Shapes in ScrollView") {
            VStack(spacing: 15) {
                Text("Without explicit size:")
                    .font(.caption)
                    .foregroundColor(.secondary)

                ScrollView {
                    Rectangle()
                        .fill(Color.red.opacity(0.5))
                        .border(Color.black, width: 2)
                }
                .frame(height: 100)
                .border(Color.blue, width: 2)

                Text("Rectangle is only 10pt tall! (nil height → 10)")
                    .font(.caption2)
                    .foregroundColor(.red)
            }
            .padding()
        }
    }

    private var solutionSection: some View {
        GroupBox("Solution: Explicit Size") {
            VStack(spacing: 15) {
                Text("With .frame(height:):")
                    .font(.caption)
                    .foregroundColor(.secondary)

                ScrollView {
                    Rectangle()
                        .fill(Color.green.opacity(0.5))
                        .frame(height: 200)
                        .border(Color.black, width: 2)
                }
                .frame(height: 100)
                .border(Color.blue, width: 2)

                Text("Rectangle is now 200pt tall (explicit size)")
                    .font(.caption2)
                    .foregroundColor(.green)
            }
            .padding()
        }
    }

    private var whyItHappensSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("Why This Happens")
                    .font(.headline)

                Text("""
                ScrollView proposes nil on its scroll axis:

                Vertical ScrollView:
                • Proposes: width×nil
                • Shape receives: width×nil
                • replacingUnspecifiedDimensions() → width×10
                • Result: 10pt tall shape

                Horizontal ScrollView:
                • Proposes: nil×height
                • Shape receives: nil×height
                • replacingUnspecifiedDimensions() → 10×height
                • Result: 10pt wide shape

                This is universal for all views that don't override sizeThatFits!
                """)
                .font(.caption)
                .padding(8)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }

    private var customIdealSizeSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("Custom Ideal Size")
                    .font(.headline)

                Text("""
                You can define a custom ideal size:

                struct MyShape: Shape {
                    func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize {
                        if proposal.width == nil && proposal.height == nil {
                            // When proposed nil×nil, return ideal size
                            return CGSize(width: 200, height: 300)
                        }
                        return proposal.replacingUnspecifiedDimensions(
                            width: 200,
                            height: 300
                        )
                    }

                    func path(in rect: CGRect) -> Path {
                        // ... drawing code ...
                    }
                }

                Now in ScrollView, MyShape defaults to 300pt tall instead of 10pt!
                """)
                .font(.system(.caption, design: .monospaced))
                .padding(8)
                .background(Color.green.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }

    private var summarySection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("Summary")
                    .font(.headline)

                VStack(alignment: .leading, spacing: 6) {
                    Text("• Shapes default to 10×10 when proposed nil")
                    Text("• ScrollView proposes nil on scroll axis")
                    Text("• Always specify .frame(height:) for shapes in vertical ScrollView")
                    Text("• Always specify .frame(width:) for shapes in horizontal ScrollView")
                    Text("• Or implement custom sizeThatFits for ideal size")
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
    IdealSizeScrollViewView()
}
