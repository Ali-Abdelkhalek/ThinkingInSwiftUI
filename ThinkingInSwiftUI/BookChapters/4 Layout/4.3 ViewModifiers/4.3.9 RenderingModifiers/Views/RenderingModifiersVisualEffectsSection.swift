//
//  RenderingModifiersVisualEffectsSection.swift
//  ThinkingInSwiftUI
//
//  Demonstrates visual effects rendering modifiers
//

import SwiftUI

struct RenderingModifiersVisualEffectsSection: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Visual Effects")
                    .font(.title)
                    .bold()

                Text("Blur, opacity, shadow - affect rendering only")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Blur Effect")
                            .font(.headline)

                        HStack(spacing: 20) {
                            Text("Sharp")
                                .frame(width: 60, height: 60)
                                .background(Color.blue.opacity(0.3))

                            Text("Blurred")
                                .frame(width: 60, height: 60)
                                .background(Color.green.opacity(0.3))
                                .blur(radius: 3)

                            Text("Sharp")
                                .frame(width: 60, height: 60)
                                .background(Color.orange.opacity(0.3))
                        }

                        Text("Blur doesn't affect layout spacing")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Opacity")
                            .font(.headline)

                        HStack(spacing: 20) {
                            Text("100%")
                                .frame(width: 60, height: 60)
                                .background(Color.blue.opacity(0.3))

                            Text("50%")
                                .frame(width: 60, height: 60)
                                .background(Color.green.opacity(0.3))
                                .opacity(0.5)

                            Text("100%")
                                .frame(width: 60, height: 60)
                                .background(Color.orange.opacity(0.3))
                        }

                        Text("Opacity changes rendering, not layout")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Text("Even at opacity(0), view still occupies layout space")
                            .font(.caption2)
                            .foregroundColor(.orange)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Shadow")
                            .font(.headline)

                        HStack(spacing: 30) {
                            Text("No Shadow")
                                .frame(width: 80, height: 60)
                                .background(Color.blue.opacity(0.3))

                            Text("Shadow")
                                .frame(width: 80, height: 60)
                                .background(Color.green.opacity(0.3))
                                .shadow(color: .black.opacity(0.3), radius: 8, x: 5, y: 5)

                            Text("No Shadow")
                                .frame(width: 80, height: 60)
                                .background(Color.orange.opacity(0.3))
                        }

                        Text("Shadow extends beyond layout frame")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Text("But doesn't push neighbors away")
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
    RenderingModifiersVisualEffectsSection()
}
