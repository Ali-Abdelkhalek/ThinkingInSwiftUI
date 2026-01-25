//
//  StackAlignmentExample.swift
//  ThinkingInSwiftUI
//
//  Built-in Alignments - Stack Alignment Examples
//

import SwiftUI

/// Demonstrates stack-specific alignment behavior.
///
/// KEY CONCEPTS:
/// - HStack has VerticalAlignment (aligns items vertically within the stack)
/// - VStack has HorizontalAlignment (aligns items horizontally within the stack)
/// - Text views have special baseline alignment guides
/// - Non-text views: baseline guides default to .bottom
///
struct StackAlignmentExample: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Stack Alignment")
                    .font(.title)
                    .bold()

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("HStack - Vertical Alignment")
                            .font(.headline)

                        Text("HStack only has vertical alignment (aligns items vertically within the stack)")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        VStack(alignment: .leading, spacing: 10) {
                            Text(".top:")
                                .font(.caption)
                            HStack(alignment: .top, spacing: 10) {
                                Text("Short")
                                    .padding(4)
                                    .background(Color.blue.opacity(0.2))
                                Text("Much\nTaller\nText")
                                    .padding(4)
                                    .background(Color.green.opacity(0.2))
                                Text("Short")
                                    .padding(4)
                                    .background(Color.orange.opacity(0.2))
                            }

                            Text(".center:")
                                .font(.caption)
                            HStack(alignment: .center, spacing: 10) {
                                Text("Short")
                                    .padding(4)
                                    .background(Color.blue.opacity(0.2))
                                Text("Much\nTaller\nText")
                                    .padding(4)
                                    .background(Color.green.opacity(0.2))
                                Text("Short")
                                    .padding(4)
                                    .background(Color.orange.opacity(0.2))
                            }

                            Text(".bottom:")
                                .font(.caption)
                            HStack(alignment: .bottom, spacing: 10) {
                                Text("Short")
                                    .padding(4)
                                    .background(Color.blue.opacity(0.2))
                                Text("Much\nTaller\nText")
                                    .padding(4)
                                    .background(Color.green.opacity(0.2))
                                Text("Short")
                                    .padding(4)
                                    .background(Color.orange.opacity(0.2))
                            }

                            Text(".firstTextBaseline:")
                                .font(.caption)
                            HStack(alignment: .firstTextBaseline, spacing: 10) {
                                Text("Short")
                                    .font(.caption)
                                    .padding(4)
                                    .background(Color.blue.opacity(0.2))
                                Text("Much\nTaller\nText")
                                    .font(.title)
                                    .padding(4)
                                    .background(Color.green.opacity(0.2))
                                Text("Short")
                                    .font(.caption)
                                    .padding(4)
                                    .background(Color.orange.opacity(0.2))
                            }

                            Text("↑ Aligns first baseline of text - important for text!")
                                .font(.caption2)
                                .foregroundColor(.orange)
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("VStack - Horizontal Alignment")
                            .font(.headline)

                        Text("VStack only has horizontal alignment (aligns items horizontally within the stack)")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        HStack(spacing: 20) {
                            VStack(spacing: 5) {
                                Text(".leading")
                                    .font(.caption2)
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Short")
                                        .padding(4)
                                        .background(Color.blue.opacity(0.2))
                                    Text("Much Longer Text")
                                        .padding(4)
                                        .background(Color.green.opacity(0.2))
                                    Text("Short")
                                        .padding(4)
                                        .background(Color.orange.opacity(0.2))
                                }
                                .border(Color.gray)
                            }

                            VStack(spacing: 5) {
                                Text(".center")
                                    .font(.caption2)
                                VStack(alignment: .center, spacing: 5) {
                                    Text("Short")
                                        .padding(4)
                                        .background(Color.blue.opacity(0.2))
                                    Text("Much Longer Text")
                                        .padding(4)
                                        .background(Color.green.opacity(0.2))
                                    Text("Short")
                                        .padding(4)
                                        .background(Color.orange.opacity(0.2))
                                }
                                .border(Color.gray)
                            }

                            VStack(spacing: 5) {
                                Text(".trailing")
                                    .font(.caption2)
                                VStack(alignment: .trailing, spacing: 5) {
                                    Text("Short")
                                        .padding(4)
                                        .background(Color.blue.opacity(0.2))
                                    Text("Much Longer Text")
                                        .padding(4)
                                        .background(Color.green.opacity(0.2))
                                    Text("Short")
                                        .padding(4)
                                        .background(Color.orange.opacity(0.2))
                                }
                                .border(Color.gray)
                            }
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Text Baseline Alignment")
                            .font(.headline)

                        Text("Text views have special alignment guides for baselines:")
                            .font(.caption)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("This is Text\nOver\nThree Lines")
                                .font(.title2)
                                .padding()
                                .background(
                                    GeometryReader { geo in
                                        VStack(spacing: 0) {
                                            Color.red.frame(height: 1)
                                                .overlay(Text(".top").font(.caption2).offset(x: -30), alignment: .leading)
                                            Spacer()
                                            Color.blue.frame(height: 1)
                                                .overlay(Text(".firstTextBaseline").font(.caption2).offset(x: -100), alignment: .leading)
                                            Spacer()
                                            Color.green.frame(height: 1)
                                                .overlay(Text(".center").font(.caption2).offset(x: -40), alignment: .leading)
                                            Spacer()
                                            Color.purple.frame(height: 1)
                                                .overlay(Text(".lastTextBaseline").font(.caption2).offset(x: -100), alignment: .leading)
                                            Spacer()
                                            Color.orange.frame(height: 1)
                                                .overlay(Text(".bottom").font(.caption2).offset(x: -50), alignment: .leading)
                                        }
                                    }
                                )
                                .border(Color.gray)
                        }

                        Text("⚠️ For views without text, baseline guides default to .bottom")
                            .font(.caption)
                            .foregroundColor(.orange)
                    }
                })
            }
            .padding()
        }
    }
}

#Preview {
    StackAlignmentExample()
}
