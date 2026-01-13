//
//  RenderingModifiers.swift
//  ThinkingInSwiftUI
//
//  Understanding Rendering Modifiers - Modifiers that affect rendering but NOT layout
//

import SwiftUI

// MARK: - Rendering Modifiers Concepts
//
// SwiftUI has modifiers that influence HOW a view is RENDERED,
// but DON'T influence the LAYOUT itself.
//
// Examples: offset, rotationEffect, scaleEffect, blur, etc.
//
// Key insight: These modifiers are like performing CGContext.translate -
// they modify WHERE/HOW a view is DRAWN, but from the layout system's
// perspective, the view is still in its ORIGINAL position.
//
// Layout vs Rendering:
// - Layout: Where SwiftUI decides to POSITION the view
// - Rendering: Where the view is actually DRAWN on screen
//
// Rendering modifiers affect rendering but not layout!

// MARK: - Basic Demonstration

struct BasicRenderingModifiersExample: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Rendering Modifiers")
                    .font(.title)
                    .bold()

                Text("Modifiers that affect rendering but NOT layout")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("What Are Rendering Modifiers?")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("• Affect how a view is DRAWN on screen")
                                .font(.caption)
                            Text("• Do NOT affect layout calculations")
                                .font(.caption)
                            Text("• Do NOT change the view's frame or position in layout")
                                .font(.caption)
                            Text("• Like CGContext transformations - visual only")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }

                        Text("Common rendering modifiers:")
                            .font(.caption)
                            .bold()
                            .padding(.top, 8)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("• .offset(x:y:) - translates rendering position")
                                .font(.caption2)
                            Text("• .rotationEffect(_:) - rotates around anchor")
                                .font(.caption2)
                            Text("• .scaleEffect(_:) - scales up/down")
                                .font(.caption2)
                            Text("• .blur(radius:) - adds blur effect")
                                .font(.caption2)
                            Text("• .opacity(_:) - changes transparency")
                                .font(.caption2)
                            Text("• .shadow(radius:x:y:) - adds drop shadow")
                                .font(.caption2)
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Key Insight: Layout Position ≠ Rendering Position")
                            .font(.headline)

                        Text("The red border shows the LAYOUT position (where SwiftUI thinks it is)")
                            .font(.caption)
                            .foregroundColor(.red)

                        Text("The view renders elsewhere, but layout siblings don't know!")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                })
            }
            .padding()
        }
    }
}

// MARK: - Offset Examples

struct OffsetExample: View {
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

// MARK: - Rotation and Scale Examples

struct RotationAndScaleExample: View {
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

// MARK: - Visual Effects Examples

struct VisualEffectsExample: View {
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

// MARK: - Practical Implications

struct PracticalImplicationsExample: View {
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

// MARK: - Helper Views

struct RenderingModifiersComparisonRow: View {
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

// MARK: - Preview

#Preview {
    TabView {
        BasicRenderingModifiersExample()
            .tabItem { Label("Basics", systemImage: "1.circle") }

        OffsetExample()
            .tabItem { Label("Offset", systemImage: "2.circle") }

        RotationAndScaleExample()
            .tabItem { Label("Rotation & Scale", systemImage: "3.circle") }

        VisualEffectsExample()
            .tabItem { Label("Visual Effects", systemImage: "4.circle") }

        PracticalImplicationsExample()
            .tabItem { Label("Implications", systemImage: "5.circle") }
    }
}
