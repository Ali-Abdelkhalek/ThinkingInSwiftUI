//
//  RenderingModifiersOffsetSection.swift
//  ThinkingInSwiftUI
//
//  Demonstrates .offset() rendering modifier
//

import SwiftUI

struct RenderingModifiersOffsetSection: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text(".offset(x:y:)")
                    .font(.title)
                    .bold()

                Text("Translates rendering position without affecting layout")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Basic Offset")
                            .font(.headline)

                        HStack(spacing: 0) {
                            Text("A")
                                .frame(width: 60, height: 60)
                                .background(Color.blue.opacity(0.3))
                                .border(Color.red, width: 2)

                            Text("B")
                                .frame(width: 60, height: 60)
                                .background(Color.green.opacity(0.3))
                                .border(Color.red, width: 2)
                                .offset(x: 20, y: 20)  // Rendering offset

                            Text("C")
                                .frame(width: 60, height: 60)
                                .background(Color.orange.opacity(0.3))
                                .border(Color.red, width: 2)
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Red borders show LAYOUT positions")
                                .font(.caption2)
                                .foregroundColor(.red)
                            Text("B is offset (20, 20) for RENDERING")
                                .font(.caption2)
                                .foregroundColor(.blue)
                            Text("Notice: C doesn't move - it doesn't know about B's offset!")
                                .font(.caption2)
                                .foregroundColor(.orange)
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Offset Can Cause Overlap")
                            .font(.headline)

                        HStack(spacing: 20) {
                            Text("Behind")
                                .frame(width: 80, height: 80)
                                .background(Color.blue.opacity(0.3))
                                .border(Color.red, width: 2)

                            Text("Offsetted")
                                .frame(width: 80, height: 80)
                                .background(Color.green.opacity(0.3))
                                .border(Color.red, width: 2)
                                .offset(x: -60, y: 0)  // Overlaps previous view
                        }

                        Text("↑ Green is offset left (-60), overlapping blue")
                            .font(.caption2)
                            .foregroundColor(.green)
                        Text("Layout still thinks they're 20pt apart!")
                            .font(.caption2)
                            .foregroundColor(.orange)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Offset vs Frame Position")
                            .font(.headline)

                        VStack(spacing: 40) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Using .offset (rendering only):")
                                    .font(.caption)
                                    .foregroundColor(.blue)

                                HStack(spacing: 0) {
                                    Text("A")
                                        .frame(width: 60, height: 60)
                                        .background(Color.gray.opacity(0.2))
                                    Text("B")
                                        .frame(width: 60, height: 60)
                                        .background(Color.blue.opacity(0.3))
                                        .offset(x: 30)
                                    Text("C")
                                        .frame(width: 60, height: 60)
                                        .background(Color.gray.opacity(0.2))
                                }
                                .border(Color.red)

                                Text("B renders 30pt right, but C stays at original position")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }

                            VStack(alignment: .leading, spacing: 8) {
                                Text("Using .padding (affects layout):")
                                    .font(.caption)
                                    .foregroundColor(.green)

                                HStack(spacing: 0) {
                                    Text("A")
                                        .frame(width: 60, height: 60)
                                        .background(Color.gray.opacity(0.2))
                                    Text("B")
                                        .frame(width: 60, height: 60)
                                        .background(Color.green.opacity(0.3))
                                        .padding(.leading, 30)
                                    Text("C")
                                        .frame(width: 60, height: 60)
                                        .background(Color.gray.opacity(0.2))
                                }
                                .border(Color.red)

                                Text("B's padding affects layout, pushing C to the right")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                })
            }
            .padding()
        }
    }
}

#Preview {
    RenderingModifiersOffsetSection()
}
