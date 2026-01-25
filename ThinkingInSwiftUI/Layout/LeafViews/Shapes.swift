//
//  Shapes.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Shapes
//  Understanding how Shapes determine their size
//

import SwiftUI

// MARK: - Tab 1: Built-in Shapes

struct BuiltInShapesView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Built-in Shapes")
                    .font(.title)
                    .bold()

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
            .padding()
        }
    }
}

// MARK: - Tab 2: Circle Special Behavior

struct CircleSpecialBehaviorView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Circle Special Case")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Circle is Different!")
                            .font(.headline)

                        Text("""
                        Unlike other shapes, Circle tries to become a SQUARE.

                        When proposed a non-square size:
                        • Takes the SMALLER dimension
                        • Reports a square size
                        • Draws a circle inscribed in that square

                        Example:
                        Proposed: 200×100
                        Circle reports: 100×100 (uses smaller dimension)
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.orange.opacity(0.2))
                        .cornerRadius(5)
                    }
                }

                GroupBox("Examples: Circle vs Ellipse") {
                    VStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Proposed: 200×100")
                                .font(.caption)
                                .foregroundColor(.secondary)

                            HStack(spacing: 20) {
                                VStack {
                                    Circle()
                                        .fill(Color.red.opacity(0.7))
                                        .frame(width: 200, height: 100)
                                        .border(Color.black, width: 2)

                                    Text("Circle\n100×100")
                                        .font(.caption2)
                                        .multilineTextAlignment(.center)
                                }

                                VStack {
                                    Ellipse()
                                        .fill(Color.blue.opacity(0.7))
                                        .frame(width: 200, height: 100)
                                        .border(Color.black, width: 2)

                                    Text("Ellipse\n200×100")
                                        .font(.caption2)
                                        .multilineTextAlignment(.center)
                                }
                            }

                            Text("Circle takes smaller dimension (100), Ellipse takes all (200×100)")
                                .font(.caption2)
                                .foregroundColor(.green)
                        }

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Proposed: 100×200")
                                .font(.caption)
                                .foregroundColor(.secondary)

                            HStack(spacing: 20) {
                                VStack {
                                    Circle()
                                        .fill(Color.red.opacity(0.7))
                                        .frame(width: 100, height: 200)
                                        .border(Color.black, width: 2)

                                    Text("Circle\n100×100")
                                        .font(.caption2)
                                        .multilineTextAlignment(.center)
                                }

                                VStack {
                                    Ellipse()
                                        .fill(Color.blue.opacity(0.7))
                                        .frame(width: 100, height: 200)
                                        .border(Color.black, width: 2)

                                    Text("Ellipse\n100×200")
                                        .font(.caption2)
                                        .multilineTextAlignment(.center)
                                }
                            }

                            Text("Circle takes smaller dimension (100), Ellipse stretches")
                                .font(.caption2)
                                .foregroundColor(.green)
                        }

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Proposed: 150×150")
                                .font(.caption)
                                .foregroundColor(.secondary)

                            HStack(spacing: 20) {
                                VStack {
                                    Circle()
                                        .fill(Color.red.opacity(0.7))
                                        .frame(width: 150, height: 150)
                                        .border(Color.black, width: 2)

                                    Text("Circle\n150×150")
                                        .font(.caption2)
                                        .multilineTextAlignment(.center)
                                }

                                VStack {
                                    Ellipse()
                                        .fill(Color.blue.opacity(0.7))
                                        .frame(width: 150, height: 150)
                                        .border(Color.black, width: 2)

                                    Text("Ellipse\n150×150")
                                        .font(.caption2)
                                        .multilineTextAlignment(.center)
                                }
                            }

                            Text("When square, both are identical")
                                .font(.caption2)
                                .foregroundColor(.green)
                        }
                    }
                    .padding()
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Why This Matters")
                            .font(.headline)

                        Text("""
                        Understanding Circle's behavior helps with:

                        • Avatar images in non-square frames
                        • Icons in rectangular buttons
                        • Profile pictures in list rows

                        If you WANT an oval, use Ellipse!
                        If you want a perfect circle, use Circle (it ensures square sizing).
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Tab 3: Custom Shapes - Bookmark Example

struct BookmarkExampleView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Custom Shapes: Bookmark")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Creating Custom Shapes")
                            .font(.headline)

                        Text("""
                        You can create custom shapes by conforming to the Shape protocol:

                        protocol Shape {
                            func path(in rect: CGRect) -> Path
                            func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize
                        }

                        • path(in:) - Draw the shape within given rectangle
                        • sizeThatFits(_:) - Determine size based on proposal (optional)

                        Default sizeThatFits accepts any proposal (like Rectangle).
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox("Live Example: Bookmark Shape") {
                    VStack(spacing: 15) {
                        Bookmark()
                            .fill(Color.blue.opacity(0.3))
                            .stroke(Color.blue, lineWidth: 3)
                            .frame(width: 150, height: 200)

                        Text("Custom bookmark shape with 2:3 aspect ratio")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Implementation: path(in:)")
                            .font(.headline)

                        Text("""
                        struct Bookmark: Shape {
                            func path(in rect: CGRect) -> Path {
                                Path { p in
                                    p.addLines([
                                        rect[.topLeading],
                                        rect[.bottomLeading],
                                        rect[.init(x: 0.5, y: 0.8)],  // V-notch
                                        rect[.bottomTrailing],
                                        rect[.topTrailing],
                                        rect[.topLeading]
                                    ])
                                    p.closeSubpath()
                                }
                            }
                        }

                        Helper extension for UnitPoint subscripting:
                        extension CGRect {
                            subscript(_ point: UnitPoint) -> CGPoint {
                                CGPoint(
                                    x: minX + width * point.x,
                                    y: minY + height * point.y
                                )
                            }
                        }
                        """)
                        .font(.system(.caption, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Implementation: sizeThatFits(_:)")
                            .font(.headline)

                        Text("""
                        func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize {
                            var result = proposal.replacingUnspecifiedDimensions()
                            let ratio: CGFloat = 2/3
                            let newWidth = ratio * result.height

                            if newWidth <= result.width {
                                result.width = newWidth
                            } else {
                                result.height = result.width / ratio
                            }

                            return result
                        }

                        This maintains a 2:3 aspect ratio (width:height).

                        Logic:
                        1. Start with proposed size (convert nil → 10)
                        2. Calculate ideal width from height (2/3 ratio)
                        3. If ideal width fits, use it (height stays)
                        4. Otherwise, calculate height from width
                        5. Return constrained size
                        """)
                        .font(.system(.caption, design: .monospaced))
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox("Behavior at Different Proposals") {
                    VStack(spacing: 15) {
                        VStack {
                            Text("Proposed: 300×200")
                                .font(.caption)
                            Bookmark()
                                .fill(Color.teal.opacity(0.3))
                                .stroke(Color.teal, lineWidth: 2)
                                .frame(width: 300, height: 200)
                                .border(Color.red, width: 1)
                            Text("Reports: 133×200 (constrained by width)")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }

                        VStack {
                            Text("Proposed: 100×300")
                                .font(.caption)
                            Bookmark()
                                .fill(Color.purple.opacity(0.3))
                                .stroke(Color.purple, lineWidth: 2)
                                .frame(width: 100, height: 300)
                                .border(Color.red, width: 1)
                            Text("Reports: 100×150 (constrained by height)")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                }
            }
            .padding()
        }
    }
}

// MARK: - Tab 4: sizeThatFits Deep Dive

struct SizeThatFitsDeepDiveView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("sizeThatFits Deep Dive")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("What is sizeThatFits?")
                            .font(.headline)

                        Text("""
                        sizeThatFits(_:) is how a Shape determines its size in response to a size proposal.

                        func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize

                        Input: ProposedViewSize (width?, height?)
                        Output: CGSize (concrete width, height)

                        This is the Shape protocol's equivalent to the layout algorithm's "child determines size" step.
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Default Implementation")
                            .font(.headline)

                        Text("""
                        If you don't implement sizeThatFits, Shape provides a default:

                        func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize {
                            proposal.replacingUnspecifiedDimensions()
                        }

                        This means:
                        • nil width → 10pt
                        • nil height → 10pt
                        • Otherwise, use proposed value

                        Most shapes (Rectangle, Ellipse, etc.) use this default.
                        They accept ANY proposed size.
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Custom sizeThatFits Examples")
                            .font(.headline)

                        Text("""
                        Example 1: Fixed Aspect Ratio

                        func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize {
                            let size = proposal.replacingUnspecifiedDimensions()
                            let side = min(size.width, size.height)
                            return CGSize(width: side, height: side)
                        }

                        Behaves like Circle - always square!

                        Example 2: Minimum Size

                        func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize {
                            let size = proposal.replacingUnspecifiedDimensions()
                            return CGSize(
                                width: max(size.width, 50),
                                height: max(size.height, 50)
                            )
                        }

                        Never smaller than 50×50.

                        Example 3: Preferred Size

                        func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize {
                            if proposal.width == nil && proposal.height == nil {
                                return CGSize(width: 100, height: 100)  // Ideal
                            }
                            return proposal.replacingUnspecifiedDimensions()
                        }

                        When proposed nil×nil, returns preferred 100×100.
                        """)
                        .font(.system(.caption, design: .monospaced))
                        .padding(8)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("When to Use Custom sizeThatFits")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("✅ Maintain aspect ratio (like Bookmark)")
                            Text("✅ Enforce minimum/maximum sizes")
                            Text("✅ Preferred/ideal size when proposed nil")
                            Text("✅ Complex sizing logic (e.g., text-based shapes)")
                            Text("❌ When you want to accept any size (use default)")
                        }
                        .font(.caption)
                        .padding(8)
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(5)
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Tab 5: Ideal Size & ScrollView Behavior

struct IdealSizeScrollViewView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Ideal Size & ScrollView")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Default 10×10 Size")
                            .font(.headline)

                        Text("""
                        When a shape receives nil for a dimension:

                        proposal.replacingUnspecifiedDimensions()
                        → CGSize(width: 10, height: 10)

                        This is why shapes in ScrollView default to 10pt on the scroll axis!
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox("Problem: Tiny Shapes in ScrollView") {
                    VStack(spacing: 15) {
                        Text("Without explicit size:")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        ScrollView {
                            Rectangle()
                                .fill(Color.red.opacity(0.5))
                                .border(Color.black, width: 2)
                        }
                        .frame(height: 100)
                        .border(Color.blue, width: 2)

                        Text("Rectangle is only 10pt tall! (nil height → 10)")
                            .font(.caption2)
                            .foregroundColor(.red)
                    }
                    .padding()
                }

                GroupBox("Solution: Explicit Size") {
                    VStack(spacing: 15) {
                        Text("With .frame(height:):")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        ScrollView {
                            Rectangle()
                                .fill(Color.green.opacity(0.5))
                                .frame(height: 200)
                                .border(Color.black, width: 2)
                        }
                        .frame(height: 100)
                        .border(Color.blue, width: 2)

                        Text("Rectangle is now 200pt tall (explicit size)")
                            .font(.caption2)
                            .foregroundColor(.green)
                    }
                    .padding()
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Why This Happens")
                            .font(.headline)

                        Text("""
                        ScrollView proposes nil on its scroll axis:

                        Vertical ScrollView:
                        • Proposes: width×nil
                        • Shape receives: width×nil
                        • replacingUnspecifiedDimensions() → width×10
                        • Result: 10pt tall shape

                        Horizontal ScrollView:
                        • Proposes: nil×height
                        • Shape receives: nil×height
                        • replacingUnspecifiedDimensions() → 10×height
                        • Result: 10pt wide shape

                        This is universal for all views that don't override sizeThatFits!
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Custom Ideal Size")
                            .font(.headline)

                        Text("""
                        You can define a custom ideal size:

                        struct MyShape: Shape {
                            func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize {
                                if proposal.width == nil && proposal.height == nil {
                                    // When proposed nil×nil, return ideal size
                                    return CGSize(width: 200, height: 300)
                                }
                                return proposal.replacingUnspecifiedDimensions(
                                    width: 200,
                                    height: 300
                                )
                            }

                            func path(in rect: CGRect) -> Path {
                                // ... drawing code ...
                            }
                        }

                        Now in ScrollView, MyShape defaults to 300pt tall instead of 10pt!
                        """)
                        .font(.system(.caption, design: .monospaced))
                        .padding(8)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Summary")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 6) {
                            Text("• Shapes default to 10×10 when proposed nil")
                            Text("• ScrollView proposes nil on scroll axis")
                            Text("• Always specify .frame(height:) for shapes in vertical ScrollView")
                            Text("• Always specify .frame(width:) for shapes in horizontal ScrollView")
                            Text("• Or implement custom sizeThatFits for ideal size")
                        }
                        .font(.caption)
                        .padding(8)
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(5)
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Bookmark Shape Definition

struct Bookmark: Shape {
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.addLines([
                rect[.topLeading],
                rect[.bottomLeading],
                rect[.init(x: 0.5, y: 0.8)],
                rect[.bottomTrailing],
                rect[.topTrailing],
                rect[.topLeading]
            ])
            p.closeSubpath()
        }
    }

    func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize {
        var result = proposal.replacingUnspecifiedDimensions()
        let ratio: CGFloat = 2/3
        let newWidth = ratio * result.height
        if newWidth <= result.width {
            result.width = newWidth
        } else {
            result.height = result.width / ratio
        }
        return result
    }
}

extension CGRect {
    subscript(_ point: UnitPoint) -> CGPoint {
        CGPoint(x: minX + width*point.x, y: minY + height*point.y)
    }
}

// MARK: - Preview

#Preview {
    TabView {
        BuiltInShapesView()
            .tabItem { Label("Built-in", systemImage: "1.circle") }

        CircleSpecialBehaviorView()
            .tabItem { Label("Circle", systemImage: "2.circle") }

        BookmarkExampleView()
            .tabItem { Label("Bookmark", systemImage: "3.circle") }

        SizeThatFitsDeepDiveView()
            .tabItem { Label("sizeThatFits", systemImage: "4.circle") }

        IdealSizeScrollViewView()
            .tabItem { Label("ScrollView", systemImage: "5.circle") }
    }
}
