//
//  LayoutVsRenderingInteractiveDemoSection.swift
//  ThinkingInSwiftUI
//
//  Interactive demonstration of clipping
//

import SwiftUI

struct LayoutVsRenderingInteractiveDemoSection: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Interactive Demonstration")
                .font(.headline)

            ClippingToggleDemo()
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
}

// MARK: - Interactive Toggle Demo

struct ClippingToggleDemo: View {
    @State private var useClipping = false

    var body: some View {
        VStack(spacing: 16) {
            Toggle("Use .clipped()", isOn: $useClipping)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)

            VStack(spacing: 12) {
                Text("Layout Space (always the same):")
                    .font(.caption)
                    .fontWeight(.semibold)

                Rectangle()
                    .fill(Color.blue.opacity(0.2))
                    .frame(width: 120, height: 60)
                    .overlay(
                        Text("120pt × 60pt")
                            .font(.caption)
                    )
                    .border(Color.blue, width: 2)

                Text("Visual Rendering:")
                    .font(.caption)
                    .fontWeight(.semibold)

                Group {
                    if useClipping {
                        // WITH clipping - circle gets cropped
                        ZStack {
                            Circle()
                                .fill(Color.red.opacity(0.3))
                                .frame(width: 180, height: 180)

                            Rectangle()
                                .stroke(Color.blue, lineWidth: 2)
                                .frame(width: 120, height: 60)
                        }
                        .frame(width: 120, height: 60)
                        .clipped()
                    } else {
                        // WITHOUT clipping - circle overflows
                        ZStack {
                            Circle()
                                .fill(Color.red.opacity(0.3))
                                .frame(width: 180, height: 180)

                            Rectangle()
                                .stroke(Color.blue, lineWidth: 2)
                                .frame(width: 120, height: 60)
                        }
                        .frame(width: 120, height: 60)
                    }
                }

                HStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Layout:")
                            .font(.caption)
                            .fontWeight(.semibold)
                        Text("120pt × 60pt")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Rendering:")
                            .font(.caption)
                            .fontWeight(.semibold)
                        Text(useClipping ? "180pt circle (masked)" : "180pt circle (overflows!)")
                            .font(.caption)
                            .foregroundColor(useClipping ? .green : .orange)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            }

            VStack(spacing: 8) {
                Text("Notice: Layout space is ALWAYS 120×60!")
                    .font(.caption)
                    .foregroundColor(.green)
                    .multilineTextAlignment(.center)

                Text("The circle is ALWAYS rendered at 180×180.\n.clipped() just creates a mask - it doesn't change the rendering size!")
                    .font(.caption)
                    .foregroundColor(.orange)
                    .multilineTextAlignment(.center)

                Text("The pattern: ZStack { Circle(180×180) + Border }.frame(120×60).clipped()")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

#Preview {
    ScrollView {
        LayoutVsRenderingInteractiveDemoSection()
            .padding()
    }
}
