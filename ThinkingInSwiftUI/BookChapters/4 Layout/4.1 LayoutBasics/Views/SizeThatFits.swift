//
//  SizeThatFits.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - sizeThatFits
//

import SwiftUI

struct SizeThatFitsExampleView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 30) {
                Text("sizeThatFits Example")
                    .font(.title)
                    .bold()

                understandingContainerLayoutsSection
                loggingShapeSection
                exampleHStackProposalsSection
                verifyingStackAlgorithmSection
            }
            .padding()
        }
    }

    // MARK: - Sections

    private var understandingContainerLayoutsSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("Understanding Container Layouts")
                    .font(.headline)

                Text("""
                Want to understand what a container (HStack, VStack, etc.) proposes to its children?

                Use a custom shape with sizeThatFits that logs proposals!
                """)
                .font(.caption)
                .padding(8)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }

    private var loggingShapeSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("Logging Shape")
                    .font(.headline)

                Text("""
                struct LoggingShape: Shape {
                    let name: String

                    func path(in rect: CGRect) -> Path {
                        Path { path in
                            path.addRect(rect)
                        }
                    }

                    func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize {
                        let size = proposal.replacingUnspecifiedDimensions()
                        print("\\(name) proposed: \\(proposal.width ?? 0) × \\(proposal.height ?? 0)")
                        print("\\(name) reports: \\(size.width) × \\(size.height)")
                        return size
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

    private var exampleHStackProposalsSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("Example: HStack Proposals")
                    .font(.headline)

                Text("""
                HStack {
                    LoggingShape(name: "A")
                        .fill(Color.red)
                    LoggingShape(name: "B")
                        .fill(Color.blue)
                    LoggingShape(name: "C")
                        .fill(Color.green)
                }
                .frame(width: 300, height: 100)

                Console output:
                A proposed: 100.0 × 100.0
                A reports: 100.0 × 100.0
                B proposed: 100.0 × 100.0
                B reports: 100.0 × 100.0
                C proposed: 100.0 × 100.0
                C reports: 100.0 × 100.0

                HStack divides 300pt width ÷ 3 subviews = 100pt each!
                """)
                .font(.caption)
                .padding(8)
                .background(Color.green.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }

    private var verifyingStackAlgorithmSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("Verifying Stack Algorithm")
                    .font(.headline)

                Text("""
                This technique is perfect for verifying:

                • HStack/VStack layout algorithm (see HStackVStack.swift)
                • How stacks probe flexibility (0 and ∞ proposals)
                • layoutPriority() effects
                • Spacing calculations

                Note: sizeThatFits is part of the Shape protocol, not View protocol.
                """)
                .font(.caption)
                .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    SizeThatFitsExampleView()
}
