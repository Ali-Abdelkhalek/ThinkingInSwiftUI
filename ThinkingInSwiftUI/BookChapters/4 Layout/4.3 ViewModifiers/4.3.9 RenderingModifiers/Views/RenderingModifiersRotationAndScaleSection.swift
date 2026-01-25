//
//  RenderingModifiersRotationAndScaleSection.swift
//  ThinkingInSwiftUI
//
//  Demonstrates rotation and scale rendering modifiers
//

import SwiftUI

struct RenderingModifiersRotationAndScaleSection: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text(".rotationEffect & .scaleEffect")
                    .font(.title)
                    .bold()

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Rotation Effect")
                            .font(.headline)

                        HStack(spacing: 20) {
                            Text("A")
                                .frame(width: 60, height: 60)
                                .background(Color.blue.opacity(0.3))
                                .border(Color.red, width: 2)

                            Text("Rotated")
                                .frame(width: 60, height: 60)
                                .background(Color.green.opacity(0.3))
                                .border(Color.red, width: 2)
                                .rotationEffect(.degrees(45))

                            Text("C")
                                .frame(width: 60, height: 60)
                                .background(Color.orange.opacity(0.3))
                                .border(Color.red, width: 2)
                        }

                        Text("Red border shows LAYOUT frame (still 60×60 square)")
                            .font(.caption2)
                            .foregroundColor(.red)
                        Text("Green renders rotated, but layout frame unchanged")
                            .font(.caption2)
                            .foregroundColor(.green)
                        Text("Notice: Rotation can cause overlap with neighbors")
                            .font(.caption2)
                            .foregroundColor(.orange)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Scale Effect")
                            .font(.headline)

                        HStack(spacing: 20) {
                            Text("A")
                                .frame(width: 60, height: 60)
                                .background(Color.blue.opacity(0.3))
                                .border(Color.red, width: 2)

                            Text("Scaled 1.5x")
                                .frame(width: 60, height: 60)
                                .background(Color.green.opacity(0.3))
                                .border(Color.red, width: 2)
                                .scaleEffect(1.5)

                            Text("C")
                                .frame(width: 60, height: 60)
                                .background(Color.orange.opacity(0.3))
                                .border(Color.red, width: 2)
                        }

                        Text("Layout frame: 60×60 (red border)")
                            .font(.caption2)
                            .foregroundColor(.red)
                        Text("Rendered size: 90×90 (1.5× scale)")
                            .font(.caption2)
                            .foregroundColor(.green)
                        Text("Siblings positioned as if it's still 60×60")
                            .font(.caption2)
                            .foregroundColor(.orange)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Combined Effects")
                            .font(.headline)

                        HStack(spacing: 20) {
                            Text("Normal")
                                .frame(width: 60, height: 60)
                                .background(Color.blue.opacity(0.3))
                                .border(Color.red, width: 2)

                            Text("Multi")
                                .frame(width: 60, height: 60)
                                .background(Color.green.opacity(0.3))
                                .border(Color.red, width: 2)
                                .scaleEffect(1.3)
                                .rotationEffect(.degrees(20))
                                .offset(x: 10, y: -10)

                            Text("Normal")
                                .frame(width: 60, height: 60)
                                .background(Color.orange.opacity(0.3))
                                .border(Color.red, width: 2)
                        }

                        Text("Middle: scaled 1.3×, rotated 20°, offset (10, -10)")
                            .font(.caption2)
                            .foregroundColor(.green)
                        Text("All visual only - neighbors don't react")
                            .font(.caption2)
                            .foregroundColor(.orange)
                    }
                })
            }
            .padding()
        }
    }
}

#Preview {
    RenderingModifiersRotationAndScaleSection()
}
