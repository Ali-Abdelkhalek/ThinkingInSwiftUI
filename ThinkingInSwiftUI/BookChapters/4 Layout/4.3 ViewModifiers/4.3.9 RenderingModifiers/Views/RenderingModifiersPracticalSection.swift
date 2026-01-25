//
//  RenderingModifiersPracticalSection.swift
//  ThinkingInSwiftUI
//
//  Practical implications and use cases for rendering modifiers
//

import SwiftUI

struct RenderingModifiersPracticalSection: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Practical Implications")
                    .font(.title)
                    .bold()

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Problem: Z-Index and Overlapping")
                            .font(.headline)

                        Text("Rendering modifiers can cause unexpected overlaps:")
                            .font(.caption)

                        ZStack(alignment: .leading) {
                            HStack(spacing: 0) {
                                Text("1")
                                    .frame(width: 60, height: 60)
                                    .background(Color.blue.opacity(0.5))
                                    .offset(x: 30)

                                Text("2")
                                    .frame(width: 60, height: 60)
                                    .background(Color.green.opacity(0.5))
                            }
                        }

                        Text("↑ Blue offset causes overlap - which one is on top?")
                            .font(.caption2)
                            .foregroundColor(.orange)

                        Text("Solution: Use .zIndex() to control stacking:")
                            .font(.caption)
                            .padding(.top, 8)

                        ZStack(alignment: .leading) {
                            HStack(spacing: 0) {
                                Text("1")
                                    .frame(width: 60, height: 60)
                                    .background(Color.blue.opacity(0.5))
                                    .offset(x: 30)
                                    .zIndex(1)  // Bring to front

                                Text("2")
                                    .frame(width: 60, height: 60)
                                    .background(Color.green.opacity(0.5))
                            }
                        }

                        Text("↑ .zIndex(1) brings blue to front")
                            .font(.caption2)
                            .foregroundColor(.green)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Problem: Hit Testing")
                            .font(.headline)

                        Text("Rendering position ≠ touch/click target:")
                            .font(.caption)

                        HStack(spacing: 20) {
                            Button("Click Me") { }
                                .buttonStyle(.bordered)
                                .offset(x: 50)
                        }
                        .border(Color.red)

                        Text("↑ Button renders 50pt right, but tap target is at original position (red box)")
                            .font(.caption2)
                            .foregroundColor(.red)

                        Text("💡 User must tap where the button WAS, not where it APPEARS")
                            .font(.caption)
                            .foregroundColor(.orange)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("When to Use Rendering Modifiers")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 6) {
                            Text("✓ Animations (smooth transformations)")
                                .font(.caption)
                                .foregroundColor(.green)
                            Text("✓ Decorative effects (shadows, rotations)")
                                .font(.caption)
                                .foregroundColor(.green)
                            Text("✓ Visual feedback (scale on press)")
                                .font(.caption)
                                .foregroundColor(.green)
                            Text("✓ Overlays and floating elements")
                                .font(.caption)
                                .foregroundColor(.green)

                            Divider()
                                .padding(.vertical, 4)

                            Text("✗ Don't use for actual layout positioning")
                                .font(.caption)
                                .foregroundColor(.red)
                            Text("✗ Don't offset to fix layout issues (fix the layout!)")
                                .font(.caption)
                                .foregroundColor(.red)
                            Text("✗ Avoid if you need siblings to react to size changes")
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Comparison Table")
                            .font(.headline)

                        VStack(spacing: 0) {
                            HStack {
                                Text("Modifier")
                                    .font(.caption)
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("Affects Layout?")
                                    .font(.caption)
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(8)
                            .background(Color.gray.opacity(0.2))

                            RenderingModifiersComparisonRow(
                                modifier: ".offset",
                                affectsLayout: false,
                                color: .blue
                            )

                            RenderingModifiersComparisonRow(
                                modifier: ".padding",
                                affectsLayout: true,
                                color: .green
                            )

                            RenderingModifiersComparisonRow(
                                modifier: ".rotationEffect",
                                affectsLayout: false,
                                color: .blue
                            )

                            RenderingModifiersComparisonRow(
                                modifier: ".rotationEffect3D",
                                affectsLayout: false,
                                color: .blue
                            )

                            RenderingModifiersComparisonRow(
                                modifier: ".scaleEffect",
                                affectsLayout: false,
                                color: .blue
                            )

                            RenderingModifiersComparisonRow(
                                modifier: ".frame",
                                affectsLayout: true,
                                color: .green
                            )

                            RenderingModifiersComparisonRow(
                                modifier: ".blur",
                                affectsLayout: false,
                                color: .blue
                            )

                            RenderingModifiersComparisonRow(
                                modifier: ".opacity",
                                affectsLayout: false,
                                color: .blue
                            )

                            RenderingModifiersComparisonRow(
                                modifier: ".shadow",
                                affectsLayout: false,
                                color: .blue
                            )

                            RenderingModifiersComparisonRow(
                                modifier: ".background",
                                affectsLayout: false,
                                color: .blue
                            )
                        }
                        .border(Color.gray)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Key Takeaways")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 6) {
                            Text("🎯 Rendering modifiers = visual transformations only")
                                .font(.caption)
                            Text("📐 Layout system ignores rendering modifiers")
                                .font(.caption)
                            Text("👆 Touch targets stay at layout position, not render position")
                                .font(.caption)
                            Text("🎨 Great for animations and decorative effects")
                                .font(.caption)
                            Text("⚠️ Can cause overlaps - use .zIndex() to control")
                                .font(.caption)
                        }
                    }
                })
            }
            .padding()
        }
    }
}

// MARK: - Helper View

private struct RenderingModifiersComparisonRow: View {
    let modifier: String
    let affectsLayout: Bool
    let color: Color

    var body: some View {
        HStack {
            Text(modifier)
                .font(.caption2)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(affectsLayout ? "Yes ✓" : "No ✗")
                .font(.caption2)
                .foregroundColor(color)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(8)
        .background(Color.gray.opacity(0.05))
    }
}

#Preview {
    RenderingModifiersPracticalSection()
}
