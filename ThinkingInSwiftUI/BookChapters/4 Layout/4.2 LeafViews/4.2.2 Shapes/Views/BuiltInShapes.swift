//
//  BuiltInShapes.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Shapes - Built-in Shapes
//

import SwiftUI

struct BuiltInShapesView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Built-in Shapes")
                    .font(.title)
                    .bold()

                howShapesFitSection
                gallerySection
                defaultBehaviorSection
            }
            .padding()
        }
    }

    // MARK: - Sections

    private var howShapesFitSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("How Shapes Fit Into Proposed Size")
                    .font(.headline)

                Text("""
                Most built-in shapes (Rectangle, RoundedRectangle, Capsule, Ellipse) accept ANY proposed size and report that same size back.

                They are INFINITELY FLEXIBLE along both axes.

                Exception: Circle has special behavior (see next tab)
                """)
                .font(.caption)
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }

    private var gallerySection: some View {
        GroupBox("Built-in Shapes Gallery") {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Rectangle")
                        .font(.headline)

                    Rectangle()
                        .fill(Color.red.opacity(0.7))
                        .frame(width: 200, height: 80)
                        .overlay {
                            Text("Accepts any size")
                                .foregroundColor(.white)
                        }

                    Text("Fills proposed dimensions exactly")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("RoundedRectangle")
                        .font(.headline)

                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.green.opacity(0.7))
                        .frame(width: 200, height: 80)
                        .overlay {
                            Text("cornerRadius: 15")
                                .foregroundColor(.white)
                        }

                    Text("Accepts any size, rounds corners")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Capsule")
                        .font(.headline)

                    Capsule()
                        .fill(Color.blue.opacity(0.7))
                        .frame(width: 200, height: 80)
                        .overlay {
                            Text("Pill-shaped")
                                .foregroundColor(.white)
                        }

                    Text("Accepts any size, fully rounded ends")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Ellipse")
                        .font(.headline)

                    Ellipse()
                        .fill(Color.orange.opacity(0.7))
                        .frame(width: 200, height: 80)
                        .overlay {
                            Text("Oval")
                                .foregroundColor(.white)
                        }

                    Text("Accepts any size, inscribes ellipse")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
    }

    private var defaultBehaviorSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("Default Behavior")
                    .font(.headline)

                Text("""
                These shapes are commonly used as backgrounds or overlays.

                Because they accept any size, they're perfect for:
                • .background(Color.red) - fills parent exactly
                • .overlay { Circle() } - matches parent size
                • Flexible layouts where content determines size
                """)
                .font(.caption)
                .padding(8)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }
}

#Preview {
    BuiltInShapesView()
}
