//
//  ClippedWhatItDoesSection.swift
//  ThinkingInSwiftUI
//
//  Demonstrates what .clipped() does
//

import SwiftUI

struct ClippedWhatItDoesSection: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Visual Overflow - Without clipped()",
                description: "Content extends beyond frame bounds visually",
                code: ".frame(width: 100).background(Color.red)"
            ) {
                VStack(spacing: 12) {
                    // Container to show the bounds
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .stroke(Color.blue, lineWidth: 2)
                            .frame(width: 100, height: 50)

                        Text("This is very long text that overflows")
                            .background(Color.red.opacity(0.3))
                            .frame(width: 100, height: 50)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Blue border = frame bounds (100pt)")
                        Text("Red background = actual text (extends beyond)")
                        Text("❌ Text visually overflows the frame")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Visual Overflow - With clipped()",
                description: "Content is cropped at frame bounds",
                code: ".frame(width: 100).background(Color.red).clipped()"
            ) {
                VStack(spacing: 12) {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .stroke(Color.blue, lineWidth: 2)
                            .frame(width: 100, height: 50)

                        Text("This is very long text that overflows")
                            .background(Color.red.opacity(0.3))
                            .frame(width: 100, height: 50)
                            .clipped()
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Blue border = frame bounds (100pt)")
                        Text("Red background = text (cropped at 100pt)")
                        Text("✅ Text is clipped at frame boundary")
                        Text("⚠️ Frame is STILL 100pt - only rendering changed!")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Important: Frame Size Unchanged",
                description: "clipped() only affects rendering, not layout",
                code: ""
            ) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 20) {
                        VStack(spacing: 8) {
                            Text("Without")
                                .font(.caption)

                            GeometryReader { geo in
                                Text("Overflow")
                                    .frame(width: 200)
                                    .background(Color.red.opacity(0.3))
                                    .frame(width: 100, height: 50)
                                    .background(
                                        Text("Frame: \(Int(geo.size.width))×\(Int(geo.size.height))")
                                            .font(.caption)
                                            .offset(y: 30)
                                    )
                            }
                            .frame(height: 80)
                        }

                        VStack(spacing: 8) {
                            Text("With .clipped()")
                                .font(.caption)

                            GeometryReader { geo in
                                Text("Overflow")
                                    .frame(width: 200)
                                    .background(Color.red.opacity(0.3))
                                    .frame(width: 100, height: 50)
                                    .clipped()
                                    .background(
                                        Text("Frame: \(Int(geo.size.width))×\(Int(geo.size.height))")
                                            .font(.caption)
                                            .offset(y: 30)
                                    )
                            }
                            .frame(height: 80)
                        }
                    }

                    Text("Both frames are the same size! Only the visual rendering is different.")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.orange)
                        .padding(.top, 8)
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        ClippedWhatItDoesSection()
            .padding()
    }
}
