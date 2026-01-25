//
//  FrameAlignmentExample.swift
//  ThinkingInSwiftUI
//
//  Built-in Alignments - Frame Alignment Examples
//

import SwiftUI

/// Demonstrates how frame alignment works through the alignment algorithm.
///
/// ALGORITHM:
/// 1. Frame asks child: 'What's your horizontal/vertical guide position?'
/// 2. Child responds with position in its local coordinates
/// 3. Frame computes its own guide position
/// 4. Frame places child by taking the difference
///
struct FrameAlignmentExample: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Frame Alignment")
                    .font(.title)
                    .bold()

                Text("Understanding the alignment algorithm step by step")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: .center alignment")
                            .font(.headline)

                        Text("Hello")
                            .background(Color.blue.opacity(0.2))
                            .frame(width: 100, height: 100, alignment: .center)
                            .border(Color.red, width: 2)

                        Text("Algorithm:")
                            .font(.caption)
                            .bold()

                        VStack(alignment: .leading, spacing: 4) {
                            Text("1. Frame asks text: 'What's your horizontal center?'")
                                .font(.caption2)
                            Text("   Text responds: '25' (text is 50pt wide)")
                                .font(.caption2)
                                .foregroundColor(.secondary)

                            Text("2. Frame asks text: 'What's your vertical center?'")
                                .font(.caption2)
                            Text("   Text responds: '10' (text is 20pt tall)")
                                .font(.caption2)
                                .foregroundColor(.secondary)

                            Text("3. Frame computes its own center: (50, 50)")
                                .font(.caption2)

                            Text("4. Frame places text at: (50-25, 50-10) = (25, 40)")
                                .font(.caption2)
                                .foregroundColor(.blue)
                        }

                        Text("Result: Text is centered within 100×100 frame")
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: .bottomTrailing alignment")
                            .font(.headline)

                        Text("Hello")
                            .background(Color.green.opacity(0.2))
                            .frame(width: 100, height: 100, alignment: .bottomTrailing)
                            .border(Color.red, width: 2)

                        Text("Algorithm:")
                            .font(.caption)
                            .bold()

                        VStack(alignment: .leading, spacing: 4) {
                            Text("1. Frame asks text: 'What's your trailing guide?'")
                                .font(.caption2)
                            Text("   Text responds: '50' (trailing edge position)")
                                .font(.caption2)
                                .foregroundColor(.secondary)

                            Text("2. Frame asks text: 'What's your bottom guide?'")
                                .font(.caption2)
                            Text("   Text responds: '20' (bottom edge position)")
                                .font(.caption2)
                                .foregroundColor(.secondary)

                            Text("3. Frame computes its own bottom trailing: (100, 100)")
                                .font(.caption2)

                            Text("4. Frame places text at: (100-50, 100-20) = (50, 80)")
                                .font(.caption2)
                                .foregroundColor(.blue)
                        }

                        Text("Result: Text is at bottom trailing corner")
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("All Alignment Options")
                            .font(.headline)

                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                            FrameAlignmentDemo(alignment: .topLeading, label: "topLeading")
                            FrameAlignmentDemo(alignment: .top, label: "top")
                            FrameAlignmentDemo(alignment: .topTrailing, label: "topTrailing")
                            FrameAlignmentDemo(alignment: .leading, label: "leading")
                            FrameAlignmentDemo(alignment: .center, label: "center")
                            FrameAlignmentDemo(alignment: .trailing, label: "trailing")
                            FrameAlignmentDemo(alignment: .bottomLeading, label: "bottomLeading")
                            FrameAlignmentDemo(alignment: .bottom, label: "bottom")
                            FrameAlignmentDemo(alignment: .bottomTrailing, label: "bottomTrailing")
                        }
                    }
                })
            }
            .padding()
        }
    }
}

#Preview {
    FrameAlignmentExample()
}
