//
//  ClippedWhatItDoesNotSection.swift
//  ThinkingInSwiftUI
//
//  Demonstrates what .clipped() does NOT do
//

import SwiftUI

struct ClippedWhatItDoesNotSection: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Does NOT Remove Empty Space",
                description: "Empty space in the frame remains unchanged",
                code: ".frame(width: 200, height: 200).clipped()"
            ) {
                VStack(spacing: 12) {
                    HStack(spacing: 20) {
                        VStack(spacing: 8) {
                            Text("Without .clipped()")
                                .font(.caption)

                            ZStack {
                                Rectangle()
                                    .stroke(Color.blue, lineWidth: 2)
                                    .frame(width: 150, height: 150)

                                Text("Small\nText")
                                    .background(Color.red.opacity(0.3))
                                    .frame(width: 150, height: 150)
                            }
                        }

                        VStack(spacing: 8) {
                            Text("With .clipped()")
                                .font(.caption)

                            ZStack {
                                Rectangle()
                                    .stroke(Color.blue, lineWidth: 2)
                                    .frame(width: 150, height: 150)

                                Text("Small\nText")
                                    .background(Color.red.opacity(0.3))
                                    .frame(width: 150, height: 150)
                                    .clipped()
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Identical! Both have the same empty space")
                        Text("clipped() does nothing when there's no overflow")
                        Text("Frame is still 150×150 in both cases")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Does NOT Change Layout",
                description: "Other views are positioned based on frame size, not clipped content",
                code: ""
            ) {
                VStack(spacing: 12) {
                    HStack(spacing: 20) {
                        VStack(spacing: 4) {
                            Text("No clipped")
                                .font(.caption)

                            HStack(spacing: 0) {
                                Text("Overflow Text")
                                    .frame(width: 50)
                                    .background(Color.red.opacity(0.3))
                                    .border(Color.red, width: 1)

                                Text("Next")
                                    .background(Color.green.opacity(0.3))
                                    .border(Color.green, width: 1)
                            }
                        }

                        VStack(spacing: 4) {
                            Text("With clipped")
                                .font(.caption)

                            HStack(spacing: 0) {
                                Text("Overflow Text")
                                    .frame(width: 50)
                                    .background(Color.red.opacity(0.3))
                                    .border(Color.red, width: 1)
                                    .clipped()

                                Text("Next")
                                    .background(Color.green.opacity(0.3))
                                    .border(Color.green, width: 1)
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Green view is in the SAME position in both!")
                        Text("Layout sees the frame (50pt), not the visual overflow")
                        Text("clipped() only affects what you see, not layout")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Does NOT Shrink Frame to Content",
                description: "If you want to remove empty space, use fixedSize() instead",
                code: ""
            ) {
                VStack(spacing: 12) {
                    HStack(spacing: 20) {
                        VStack(spacing: 8) {
                            Text("With .clipped()")
                                .font(.caption)

                            Text("Hi")
                                .background(Color.red.opacity(0.3))
                                .frame(width: 150)
                                .background(Color.blue.opacity(0.1))
                                .border(Color.blue, width: 2)
                                .clipped()

                            Text("Frame: 150pt\n(empty space remains)")
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }

                        VStack(spacing: 8) {
                            Text("With .fixedSize()")
                                .font(.caption)

                            Text("Hi")
                                .background(Color.red.opacity(0.3))
                                .frame(width: 150)
                                .fixedSize()
                                .background(Color.blue.opacity(0.1))
                                .border(Color.blue, width: 2)

                            Text("Frame: ~16pt\n(shrunk to content)")
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                    }

                    Text("To remove empty space, use .fixedSize(), NOT .clipped()")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.orange)
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        ClippedWhatItDoesNotSection()
            .padding()
    }
}
