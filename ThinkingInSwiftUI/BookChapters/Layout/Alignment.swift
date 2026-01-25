//
//  Alignment.swift
//  ThinkingInSwiftUI
//
//  Understanding Alignment - Built-in, Modified, and Custom
//

import SwiftUI

// MARK: - Alignment Concepts
//
// SwiftUI uses alignment to position views RELATIVE to each other.
//
// Key insight: Alignment is always a NEGOTIATION between parent and child.
// - Parent asks child: "Where is your alignment guide for X?"
// - Child responds with a position in its local coordinates
// - Parent uses this to position the child
//
// Three types:
// 1. Built-in alignments (.center, .leading, .top, .bottom, etc.)
// 2. Modified alignments (.alignmentGuide to override built-in)
// 3. Custom alignments (define your own with AlignmentID)

// MARK: - Built-in Alignment Basics

struct BuiltInAlignmentBasics: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Built-in Alignments")
                    .font(.title)
                    .bold()

                Text("Alignment is a negotiation between parent and child")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("How Alignment Works")
                            .font(.headline)

                        Text("The parent doesn't just place the child - it ASKS the child where its alignment guides are!")
                            .font(.caption)
                            .foregroundColor(.orange)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("1️⃣ Parent asks child: 'Where is your center?'")
                                .font(.caption)
                            Text("2️⃣ Child responds: 'My center is at (25, 10) in my coordinates'")
                                .font(.caption)
                            Text("3️⃣ Parent computes its own center: (50, 50)")
                                .font(.caption)
                            Text("4️⃣ Parent places child by taking difference: (50-25, 50-10) = (25, 40)")
                                .font(.caption)
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Built-in Alignment Guides")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("HorizontalAlignment:")
                                .font(.caption)
                                .bold()
                            Text("  • .leading")
                                .font(.caption2)
                            Text("  • .center")
                                .font(.caption2)
                            Text("  • .trailing")
                                .font(.caption2)

                            Text("VerticalAlignment:")
                                .font(.caption)
                                .bold()
                                .padding(.top, 4)
                            Text("  • .top")
                                .font(.caption2)
                            Text("  • .center")
                                .font(.caption2)
                            Text("  • .bottom")
                                .font(.caption2)
                            Text("  • .firstTextBaseline")
                                .font(.caption2)
                            Text("  • .lastTextBaseline")
                                .font(.caption2)

                            Text("Composite Alignment:")
                                .font(.caption)
                                .bold()
                                .padding(.top, 4)
                            Text("  • .topLeading, .topTrailing, .bottomLeading, .bottomTrailing, .center, etc.")
                                .font(.caption2)
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Which containers use which alignment?")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 6) {
                            Text("Two-dimensional (Alignment):")
                                .font(.caption)
                                .bold()
                            Text("  • .frame(alignment:) - both H & V")
                                .font(.caption2)
                            Text("  • ZStack(alignment:) - both H & V")
                                .font(.caption2)
                            Text("  • .overlay(alignment:) - both H & V")
                                .font(.caption2)
                            Text("  • .background(alignment:) - both H & V")
                                .font(.caption2)

                            Text("One-dimensional:")
                                .font(.caption)
                                .bold()
                                .padding(.top, 4)
                            Text("  • HStack(alignment:) - only VerticalAlignment")
                                .font(.caption2)
                            Text("  • VStack(alignment:) - only HorizontalAlignment")
                                .font(.caption2)
                        }
                    }
                })
            }
            .padding()
        }
    }
}

// MARK: - Frame Alignment Example

struct FrameAlignmentExample: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Frame Alignment")
                    .font(.title)
                    .bold()

                Text("Understanding the alignment algorithm step by step")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: .center alignment")
                            .font(.headline)

                        Text("Hello")
                            .background(Color.blue.opacity(0.2))
                            .frame(width: 100, height: 100, alignment: .center)
                            .border(Color.red, width: 2)

                        Text("Algorithm:")
                            .font(.caption)
                            .bold()

                        VStack(alignment: .leading, spacing: 4) {
                            Text("1. Frame asks text: 'What's your horizontal center?'")
                                .font(.caption2)
                            Text("   Text responds: '25' (text is 50pt wide)")
                                .font(.caption2)
                                .foregroundColor(.secondary)

                            Text("2. Frame asks text: 'What's your vertical center?'")
                                .font(.caption2)
                            Text("   Text responds: '10' (text is 20pt tall)")
                                .font(.caption2)
                                .foregroundColor(.secondary)

                            Text("3. Frame computes its own center: (50, 50)")
                                .font(.caption2)

                            Text("4. Frame places text at: (50-25, 50-10) = (25, 40)")
                                .font(.caption2)
                                .foregroundColor(.blue)
                        }

                        Text("Result: Text is centered within 100×100 frame")
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: .bottomTrailing alignment")
                            .font(.headline)

                        Text("Hello")
                            .background(Color.green.opacity(0.2))
                            .frame(width: 100, height: 100, alignment: .bottomTrailing)
                            .border(Color.red, width: 2)

                        Text("Algorithm:")
                            .font(.caption)
                            .bold()

                        VStack(alignment: .leading, spacing: 4) {
                            Text("1. Frame asks text: 'What's your trailing guide?'")
                                .font(.caption2)
                            Text("   Text responds: '50' (trailing edge position)")
                                .font(.caption2)
                                .foregroundColor(.secondary)

                            Text("2. Frame asks text: 'What's your bottom guide?'")
                                .font(.caption2)
                            Text("   Text responds: '20' (bottom edge position)")
                                .font(.caption2)
                                .foregroundColor(.secondary)

                            Text("3. Frame computes its own bottom trailing: (100, 100)")
                                .font(.caption2)

                            Text("4. Frame places text at: (100-50, 100-20) = (50, 80)")
                                .font(.caption2)
                                .foregroundColor(.blue)
                        }

                        Text("Result: Text is at bottom trailing corner")
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("All Alignment Options")
                            .font(.headline)

                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                            FrameAlignmentDemo(alignment: .topLeading, label: "topLeading")
                            FrameAlignmentDemo(alignment: .top, label: "top")
                            FrameAlignmentDemo(alignment: .topTrailing, label: "topTrailing")
                            FrameAlignmentDemo(alignment: .leading, label: "leading")
                            FrameAlignmentDemo(alignment: .center, label: "center")
                            FrameAlignmentDemo(alignment: .trailing, label: "trailing")
                            FrameAlignmentDemo(alignment: .bottomLeading, label: "bottomLeading")
                            FrameAlignmentDemo(alignment: .bottom, label: "bottom")
                            FrameAlignmentDemo(alignment: .bottomTrailing, label: "bottomTrailing")
                        }
                    }
                })
            }
            .padding()
        }
    }
}

// MARK: - Stack Alignment Examples

struct StackAlignmentExample: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Stack Alignment")
                    .font(.title)
                    .bold()

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("HStack - Vertical Alignment")
                            .font(.headline)

                        Text("HStack only has vertical alignment (aligns items vertically within the stack)")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        VStack(alignment: .leading, spacing: 10) {
                            Text(".top:")
                                .font(.caption)
                            HStack(alignment: .top, spacing: 10) {
                                Text("Short")
                                    .padding(4)
                                    .background(Color.blue.opacity(0.2))
                                Text("Much\nTaller\nText")
                                    .padding(4)
                                    .background(Color.green.opacity(0.2))
                                Text("Short")
                                    .padding(4)
                                    .background(Color.orange.opacity(0.2))
                            }

                            Text(".center:")
                                .font(.caption)
                            HStack(alignment: .center, spacing: 10) {
                                Text("Short")
                                    .padding(4)
                                    .background(Color.blue.opacity(0.2))
                                Text("Much\nTaller\nText")
                                    .padding(4)
                                    .background(Color.green.opacity(0.2))
                                Text("Short")
                                    .padding(4)
                                    .background(Color.orange.opacity(0.2))
                            }

                            Text(".bottom:")
                                .font(.caption)
                            HStack(alignment: .bottom, spacing: 10) {
                                Text("Short")
                                    .padding(4)
                                    .background(Color.blue.opacity(0.2))
                                Text("Much\nTaller\nText")
                                    .padding(4)
                                    .background(Color.green.opacity(0.2))
                                Text("Short")
                                    .padding(4)
                                    .background(Color.orange.opacity(0.2))
                            }

                            Text(".firstTextBaseline:")
                                .font(.caption)
                            HStack(alignment: .firstTextBaseline, spacing: 10) {
                                Text("Short")
                                    .font(.caption)
                                    .padding(4)
                                    .background(Color.blue.opacity(0.2))
                                Text("Much\nTaller\nText")
                                    .font(.title)
                                    .padding(4)
                                    .background(Color.green.opacity(0.2))
                                Text("Short")
                                    .font(.caption)
                                    .padding(4)
                                    .background(Color.orange.opacity(0.2))
                            }

                            Text("↑ Aligns first baseline of text - important for text!")
                                .font(.caption2)
                                .foregroundColor(.orange)
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("VStack - Horizontal Alignment")
                            .font(.headline)

                        Text("VStack only has horizontal alignment (aligns items horizontally within the stack)")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        HStack(spacing: 20) {
                            VStack(spacing: 5) {
                                Text(".leading")
                                    .font(.caption2)
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Short")
                                        .padding(4)
                                        .background(Color.blue.opacity(0.2))
                                    Text("Much Longer Text")
                                        .padding(4)
                                        .background(Color.green.opacity(0.2))
                                    Text("Short")
                                        .padding(4)
                                        .background(Color.orange.opacity(0.2))
                                }
                                .border(Color.gray)
                            }

                            VStack(spacing: 5) {
                                Text(".center")
                                    .font(.caption2)
                                VStack(alignment: .center, spacing: 5) {
                                    Text("Short")
                                        .padding(4)
                                        .background(Color.blue.opacity(0.2))
                                    Text("Much Longer Text")
                                        .padding(4)
                                        .background(Color.green.opacity(0.2))
                                    Text("Short")
                                        .padding(4)
                                        .background(Color.orange.opacity(0.2))
                                }
                                .border(Color.gray)
                            }

                            VStack(spacing: 5) {
                                Text(".trailing")
                                    .font(.caption2)
                                VStack(alignment: .trailing, spacing: 5) {
                                    Text("Short")
                                        .padding(4)
                                        .background(Color.blue.opacity(0.2))
                                    Text("Much Longer Text")
                                        .padding(4)
                                        .background(Color.green.opacity(0.2))
                                    Text("Short")
                                        .padding(4)
                                        .background(Color.orange.opacity(0.2))
                                }
                                .border(Color.gray)
                            }
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Text Baseline Alignment")
                            .font(.headline)

                        Text("Text views have special alignment guides for baselines:")
                            .font(.caption)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("This is Text\nOver\nThree Lines")
                                .font(.title2)
                                .padding()
                                .background(
                                    GeometryReader { geo in
                                        VStack(spacing: 0) {
                                            Color.red.frame(height: 1)
                                                .overlay(Text(".top").font(.caption2).offset(x: -30), alignment: .leading)
                                            Spacer()
                                            Color.blue.frame(height: 1)
                                                .overlay(Text(".firstTextBaseline").font(.caption2).offset(x: -100), alignment: .leading)
                                            Spacer()
                                            Color.green.frame(height: 1)
                                                .overlay(Text(".center").font(.caption2).offset(x: -40), alignment: .leading)
                                            Spacer()
                                            Color.purple.frame(height: 1)
                                                .overlay(Text(".lastTextBaseline").font(.caption2).offset(x: -100), alignment: .leading)
                                            Spacer()
                                            Color.orange.frame(height: 1)
                                                .overlay(Text(".bottom").font(.caption2).offset(x: -50), alignment: .leading)
                                        }
                                    }
                                )
                                .border(Color.gray)
                        }

                        Text("⚠️ For views without text, baseline guides default to .bottom")
                            .font(.caption)
                            .foregroundColor(.orange)
                    }
                })
            }
            .padding()
        }
    }
}

// MARK: - ZStack Alignment Example

struct ZStackAlignmentExample: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("ZStack Alignment")
                    .font(.title)
                    .bold()

                Text("ZStack aligns multiple subviews relative to each other")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("ZStack Algorithm (2 Steps)")
                            .font(.headline)

                        Text("Step 1: Determine ZStack's own size")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.blue)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("1. Ask each subview for size + alignment guides")
                                .font(.caption2)
                            Text("2. Compute subview origins relative to first subview")
                                .font(.caption2)
                            Text("3. Compute union of all subview frames")
                                .font(.caption2)
                            Text("4. Union's size = ZStack's size")
                                .font(.caption2)
                        }

                        Text("Step 2: Place the subviews")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.green)
                            .padding(.top, 8)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("1. Compute ZStack's alignment guides based on its size")
                                .font(.caption2)
                            Text("2. Place each subview by subtracting its alignment guides from ZStack's")
                                .font(.caption2)
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: Center Alignment")
                            .font(.headline)

                        ZStack(alignment: .center) {
                            Rectangle()
                                .fill(Color.teal)
                                .frame(width: 50, height: 50)
                            Text("Hello, World!")
                                .background(Color.yellow.opacity(0.3))
                        }
                        .border(Color.red, width: 2)

                        Text("Rectangle: 50×50, center at (25, 25)")
                            .font(.caption2)
                            .foregroundColor(.blue)
                        Text("Text: ~100×20, center at (~50, 10)")
                            .font(.caption2)
                            .foregroundColor(.green)
                        Text("ZStack aligns both centers")
                            .font(.caption2)
                            .foregroundColor(.orange)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("All ZStack Alignments")
                            .font(.headline)

                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                            ZStackAlignmentDemo(alignment: .topLeading, label: "topLeading")
                            ZStackAlignmentDemo(alignment: .top, label: "top")
                            ZStackAlignmentDemo(alignment: .topTrailing, label: "topTrailing")
                            ZStackAlignmentDemo(alignment: .leading, label: "leading")
                            ZStackAlignmentDemo(alignment: .center, label: "center")
                            ZStackAlignmentDemo(alignment: .trailing, label: "trailing")
                            ZStackAlignmentDemo(alignment: .bottomLeading, label: "bottomLeading")
                            ZStackAlignmentDemo(alignment: .bottom, label: "bottom")
                            ZStackAlignmentDemo(alignment: .bottomTrailing, label: "bottomTrailing")
                        }
                    }
                })
            }
            .padding()
        }
    }
}

// MARK: - Modified Alignment Guides

struct ModifiedAlignmentExample: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Modified Alignment Guides")
                    .font(.title)
                    .bold()

                Text("Override built-in alignment guides with .alignmentGuide")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Why Modify Alignment Guides?")
                            .font(.headline)

                        Text("Built-in alignments only let you align the SAME guide on both views:")
                            .font(.caption)

                        VStack(alignment: .leading, spacing: 6) {
                            Text("✓ Align top of A to top of B")
                                .font(.caption2)
                                .foregroundColor(.green)
                            Text("✓ Align center of A to center of B")
                                .font(.caption2)
                                .foregroundColor(.green)
                            Text("✗ Align center of A to top of B")
                                .font(.caption2)
                                .foregroundColor(.red)
                            Text("✗ Align bottom of A to center of B")
                                .font(.caption2)
                                .foregroundColor(.red)
                        }

                        Text("Solution: Override alignment guides to align different guides!")
                            .font(.caption)
                            .foregroundColor(.orange)
                            .padding(.top, 4)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The 'Trick': Overriding What Alignment Means")
                            .font(.headline)

                        Text("How the override works:")
                            .font(.caption)
                            .bold()

                        VStack(alignment: .leading, spacing: 6) {
                            Text("1. Parent says: 'Use .topTrailing alignment'")
                                .font(.caption2)
                            Text("2. Parent asks child: 'Where is your .top guide?'")
                                .font(.caption2)
                            Text("3. Child (with override): 'My .top is at height/2' (lying - it's actually center!)")
                                .font(.caption2)
                                .foregroundColor(.orange)
                            Text("4. Parent asks: 'Where is your .trailing guide?'")
                                .font(.caption2)
                            Text("5. Child (with override): 'My .trailing is at width/2' (lying - it's actually center!)")
                                .font(.caption2)
                                .foregroundColor(.orange)
                            Text("6. Parent positions child using these 'fake' guides")
                                .font(.caption2)
                            Text("7. Result: Child's CENTER aligns to parent's TOP TRAILING")
                                .font(.caption2)
                                .foregroundColor(.green)
                                .bold()
                        }

                        Text("💡 We 'trick' SwiftUI by redefining what .top and .trailing mean for this view!")
                            .font(.caption)
                            .foregroundColor(.orange)
                            .padding(.top, 8)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: Badge Overlay")
                            .font(.headline)

                        Text("Goal: Overlay badge CENTER on view's TOP TRAILING corner")
                            .font(.caption)

                        Text("Hello")
                            .padding()
                            .background(Color.teal)
                            .customBadge {
                                Circle()
                                    .fill(Color.orange)
                                    .frame(width: 20, height: 20)
                            }

                        Text("How it works:")
                            .font(.caption)
                            .padding(.top, 8)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("1. Overlay uses .topTrailing alignment")
                                .font(.caption2)
                            Text("2. Badge overrides .top to be at its vertical center")
                                .font(.caption2)
                            Text("3. Badge overrides .trailing to be at its horizontal center")
                                .font(.caption2)
                            Text("4. Result: Badge center aligns to view's top trailing")
                                .font(.caption2)
                                .foregroundColor(.green)
                        }

                        Text("Code:")
                            .font(.caption)
                            .padding(.top, 8)

                        Text("""
                        .overlay(alignment: .topTrailing) {
                            badge()
                                .alignmentGuide(.top) { $0.height/2 }
                                .alignmentGuide(.trailing) { $0.width/2 }
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("ViewDimensions Parameter")
                            .font(.headline)

                        Text("The closure receives ViewDimensions with:")
                            .font(.caption)

                        VStack(alignment: .leading, spacing: 6) {
                            Text("• .width - view's width")
                                .font(.caption2)
                            Text("• .height - view's height")
                                .font(.caption2)
                            Text("• [alignment] - access other alignment guides")
                                .font(.caption2)
                        }

                        Text("Example: Use existing alignment guide")
                            .font(.caption)
                            .padding(.top, 8)

                        Text("""
                        .alignmentGuide(.firstTextBaseline) { d in
                            d[VerticalAlignment.center]
                        }
                        // Same as: d.height / 2
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                })
            }
            .padding()
        }
    }
}

// MARK: - Custom Alignment Identifiers

struct CustomAlignmentExample: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Custom Alignment Identifiers")
                    .font(.title)
                    .bold()

                Text("Create completely custom alignments that propagate through containers")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Problem")
                            .font(.headline)

                        Text("Menu with items that should align to circle centers:")
                            .font(.caption)

                        VStack(alignment: .trailing, spacing: 10) {
                            HStack {
                                Text("Inbox")
                                CircleButton(symbol: "tray.and.arrow.down.fill")
                                    .frame(width: 30, height: 30)
                            }
                            HStack {
                                Text("Sent")
                                CircleButton(symbol: "tray.and.arrow.up.fill")
                                    .frame(width: 30, height: 30)
                            }
                            CircleButton(symbol: "line.3.horizontal")
                                .frame(width: 40, height: 40)
                        }

                        Text("↑ Bottom button should align to circle centers, not text")
                            .font(.caption2)
                            .foregroundColor(.red)

                        Text("Problem: No built-in alignment works!")
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(.top, 4)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("• .trailing aligns to HStack's trailing (includes text)")
                                .font(.caption2)
                            Text("• Can't override .trailing on CircleButton (HStack has its own .trailing)")
                                .font(.caption2)
                            Text("• Explicit guide on CircleButton never gets used!")
                                .font(.caption2)
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Solution: Custom Alignment")
                            .font(.headline)

                        Text("Step 1: Define AlignmentID")
                            .font(.caption)
                            .bold()

                        Text("""
                        struct MenuAlignment: AlignmentID {
                            static func defaultValue(in context: ViewDimensions) -> CGFloat {
                                context.width / 2
                            }
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)

                        Text("Step 2: Extend HorizontalAlignment")
                            .font(.caption)
                            .bold()
                            .padding(.top, 8)

                        Text("""
                        extension HorizontalAlignment {
                            static let menu = HorizontalAlignment(MenuAlignment.self)
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)

                        Text("Step 3: Use custom alignment")
                            .font(.caption)
                            .bold()
                            .padding(.top, 8)

                        Text("""
                        VStack(alignment: .menu) {
                            HStack {
                                Text("Inbox")
                                CircleButton(...)
                                    .alignmentGuide(.menu) { $0.width/2 }
                            }
                            CircleButton(...)
                            // Uses default value (center)
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Working Example")
                            .font(.headline)

                        VStack(alignment: .menu, spacing: 10) {
                            HStack {
                                Text("Inbox")
                                CircleButton(symbol: "tray.and.arrow.down.fill")
                                    .frame(width: 30, height: 30)
                                    .alignmentGuide(.menu) { $0.width / 2 }
                            }
                            HStack {
                                Text("Sent")
                                CircleButton(symbol: "tray.and.arrow.up.fill")
                                    .frame(width: 30, height: 30)
                                    .alignmentGuide(.menu) { $0.width / 2 }
                            }
                            CircleButton(symbol: "line.3.horizontal")
                                .frame(width: 40, height: 40)
                                // No explicit .menu guide → uses default (width/2)
                        }

                        Text("↑ Bottom button perfectly aligned to circle centers!")
                            .font(.caption2)
                            .foregroundColor(.green)

                        Text("How it works for ALL items:")
                            .font(.caption)
                            .bold()
                            .padding(.top, 8)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("• VStack(alignment: .menu) applies to ALL children")
                                .font(.caption2)
                            Text("• HStack 1: CircleButton has explicit .menu guide (width/2)")
                                .font(.caption2)
                                .foregroundColor(.blue)
                            Text("• HStack 2: CircleButton has explicit .menu guide (width/2)")
                                .font(.caption2)
                                .foregroundColor(.blue)
                            Text("• Bottom CircleButton: No explicit guide → uses default (width/2)")
                                .font(.caption2)
                                .foregroundColor(.green)
                            Text("• All three circles report the same .menu value → perfectly aligned!")
                                .font(.caption2)
                                .foregroundColor(.orange)
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Important: Alignment Applies to ALL Items")
                            .font(.headline)

                        Text("When you set VStack(alignment: .menu):")
                            .font(.caption)
                            .bold()

                        VStack(alignment: .leading, spacing: 6) {
                            Text("✓ VStack asks ALL children for their .menu guide")
                                .font(.caption2)
                            Text("✓ Each child can provide explicit value OR use default")
                                .font(.caption2)
                            Text("✓ VStack aligns ALL children using their .menu values")
                                .font(.caption2)
                        }

                        Text("Example breakdown:")
                            .font(.caption)
                            .padding(.top, 8)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("VStack asks HStack 1: 'Where is your .menu?'")
                                .font(.caption2)
                            Text("  → HStack asks CircleButton: 'Where is your .menu?'")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Text("  → CircleButton: 'width/2 = 15' (explicit)")
                                .font(.caption2)
                                .foregroundColor(.blue)

                            Text("VStack asks HStack 2: 'Where is your .menu?'")
                                .font(.caption2)
                                .padding(.top, 4)
                            Text("  → HStack asks CircleButton: 'Where is your .menu?'")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Text("  → CircleButton: 'width/2 = 15' (explicit)")
                                .font(.caption2)
                                .foregroundColor(.blue)

                            Text("VStack asks bottom CircleButton: 'Where is your .menu?'")
                                .font(.caption2)
                                .padding(.top, 4)
                            Text("  → CircleButton: 'width/2 = 20' (default, no explicit)")
                                .font(.caption2)
                                .foregroundColor(.green)

                            Text("VStack aligns ALL three using these values!")
                                .font(.caption2)
                                .foregroundColor(.orange)
                                .bold()
                                .padding(.top, 4)
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("How Custom Alignments Propagate")
                            .font(.headline)

                        Text("This is the magic of custom alignments!")
                            .font(.caption)
                            .foregroundColor(.orange)

                        VStack(alignment: .leading, spacing: 6) {
                            Text("1. VStack asks HStack: 'Where is your .menu guide?'")
                                .font(.caption2)
                            Text("2. HStack checks its children for explicit .menu guides")
                                .font(.caption2)
                            Text("3. HStack finds CircleButton has explicit .menu guide")
                                .font(.caption2)
                            Text("4. HStack returns CircleButton's .menu value to VStack")
                                .font(.caption2)
                            Text("5. VStack aligns all items using this propagated value")
                                .font(.caption2)
                        }

                        Text("💡 Custom alignments propagate through containers!")
                            .font(.caption)
                            .foregroundColor(.green)
                            .padding(.top, 8)

                        Text("Built-in modified guides don't propagate (HStack's .trailing blocks child's .trailing)")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Another Example: Decimal Point Alignment")
                            .font(.headline)

                        Text("Problem: Align prices by decimal point")
                            .font(.caption)

                        Text("Without custom alignment (using .trailing):")
                            .font(.caption)
                            .padding(.top, 8)

                        VStack(alignment: .trailing, spacing: 5) {
                            Text("$12.99")
                                .font(.largeTitle)
                            Text("$8.11")
                                .font(.largeTitle)
                            Text("$1,234.00")
                                .font(.largeTitle)
                        }
                        .padding(8)
                        .background(Color.gray.opacity(0.1))

                        Text("↑ Decimal points don't align")
                            .font(.caption2)
                            .foregroundColor(.red)

                        Divider()

                        Text("With custom alignment:")
                            .font(.caption)
                            .padding(.top, 8)

                        VStack(alignment: .decimalPoint, spacing: 5) {
                            PriceText(dollars: "12", cents: "99")
                            PriceText(dollars: "8", cents: "11")
                            PriceText(dollars: "1,234", cents: "00")
                        }
                        .padding(8)
                        .background(Color.gray.opacity(0.1))

                        Text("↑ Decimal points perfectly aligned!")
                            .font(.caption2)
                            .foregroundColor(.green)

                        Text("Implementation:")
                            .font(.caption)
                            .padding(.top, 8)

                        Text("""
                        struct DecimalAlignment: AlignmentID {
                            static func defaultValue(in d: ViewDimensions) -> CGFloat {
                                d[.trailing]
                            }
                        }

                        extension HorizontalAlignment {
                            static let decimalPoint = HorizontalAlignment(DecimalAlignment.self)
                        }

                        struct PriceText: View {
                            let dollars: String
                            let cents: String

                            var body: some View {
                                HStack(spacing: 0) {
                                    Text("$" + dollars)
                                    Text(".")
                                        .alignmentGuide(.decimalPoint) { d in d[.trailing] }
                                    Text(cents)
                                }
                                .font(.title2)
                            }
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)

                        Text("How it works:")
                            .font(.caption)
                            .padding(.top, 8)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("1. VStack uses custom .decimalPoint alignment")
                                .font(.caption2)
                            Text("2. Each PriceText marks the '.' position with .alignmentGuide(.decimalPoint)")
                                .font(.caption2)
                            Text("3. VStack aligns all '.' characters to same horizontal position")
                                .font(.caption2)
                            Text("4. Result: Perfectly aligned price list!")
                                .font(.caption2)
                                .foregroundColor(.green)
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example 3: Chat Message Alignment")
                            .font(.headline)

                        Text("Problem: Align avatars to first line of message text")
                            .font(.caption)

                        Text("WITHOUT custom alignment (.top):")
                            .font(.caption)
                            .padding(.top, 8)

                        VStack(alignment: .leading, spacing: 15) {
                            ChatMessageBad(
                                name: "Alice",
                                message: "Hey! How are you?",
                                color: .blue
                            )

                            ChatMessageBad(
                                name: "Bob",
                                message: "I'm doing great! Just finished a really long project that took weeks to complete.",
                                color: .green
                            )

                            ChatMessageBad(
                                name: "Charlie",
                                message: "Nice!",
                                color: .orange
                            )
                        }
                        .padding(8)
                        .background(Color.gray.opacity(0.1))

                        Text("↑ Avatars align to top - looks bad for long messages")
                            .font(.caption2)
                            .foregroundColor(.red)

                        Divider()

                        Text("WITH custom alignment (.messageAlignment):")
                            .font(.caption)
                            .padding(.top, 8)

                        VStack(alignment: .leading, spacing: 15) {
                            ChatMessage(
                                name: "Alice",
                                message: "Hey! How are you?",
                                color: .blue
                            )

                            ChatMessage(
                                name: "Bob",
                                message: "I'm doing great! Just finished a really long project that took weeks to complete.",
                                color: .green
                            )

                            ChatMessage(
                                name: "Charlie",
                                message: "Nice!",
                                color: .orange
                            )
                        }
                        .padding(8)
                        .background(Color.gray.opacity(0.1))

                        Text("↑ Avatars align to first baseline - perfect!")
                            .font(.caption2)
                            .foregroundColor(.green)

                        Text("Implementation:")
                            .font(.caption)
                            .padding(.top, 8)

                        Text("""
                        struct MessageAlignment: AlignmentID {
                            static func defaultValue(in d: ViewDimensions) -> CGFloat {
                                d[VerticalAlignment.center]
                            }
                        }

                        extension VerticalAlignment {
                            static let messageAlignment = VerticalAlignment(MessageAlignment.self)
                        }

                        struct ChatMessage: View {
                            var body: some View {
                                HStack(alignment: .messageAlignment) {
                                    Circle()
                                        .fill(color)
                                        .frame(width: 30, height: 30)
                                        .alignmentGuide(.messageAlignment) { d in d[.top] + 15 }

                                    Text(message)
                                        .alignmentGuide(.messageAlignment) { d in d[.firstTextBaseline] }
                                }
                            }
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)

                        Text("How it works:")
                            .font(.caption)
                            .padding(.top, 8)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("1. HStack uses custom .messageAlignment")
                                .font(.caption2)
                            Text("2. Avatar: .messageAlignment = top + 15 (center of 30pt circle)")
                                .font(.caption2)
                                .foregroundColor(.blue)
                            Text("3. Text: .messageAlignment = .firstTextBaseline")
                                .font(.caption2)
                                .foregroundColor(.green)
                            Text("4. Result: Avatar center aligns to first line of text")
                                .font(.caption2)
                                .foregroundColor(.orange)
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Key Takeaways")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 6) {
                            Text("✓ Custom alignments propagate through multiple containers")
                                .font(.caption)
                                .foregroundColor(.green)
                            Text("✓ Useful when you need to align across nested views")
                                .font(.caption)
                                .foregroundColor(.green)
                            Text("✓ Default value is used unless explicit guide provided")
                                .font(.caption)
                                .foregroundColor(.green)
                            Text("✓ Real-world uses: prices, chat bubbles, forms, timelines")
                                .font(.caption)
                                .foregroundColor(.green)
                            Text("⚠️ Create custom alignment only when modifying built-in doesn't work")
                                .font(.caption)
                                .foregroundColor(.orange)
                        }
                    }
                })
            }
            .padding()
        }
    }
}

// MARK: - Helper Views

struct FrameAlignmentDemo: View {
    let alignment: Alignment
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            Text("Hello")
                .font(.caption2)
                .background(Color.blue.opacity(0.2))
                .frame(width: 80, height: 60, alignment: alignment)
                .border(Color.gray)

            Text(label)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}

struct ZStackAlignmentDemo: View {
    let alignment: Alignment
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            ZStack(alignment: alignment) {
                Rectangle()
                    .fill(Color.teal.opacity(0.3))
                    .frame(width: 40, height: 40)
                Text("Hi")
                    .font(.caption2)
                    .background(Color.yellow.opacity(0.5))
            }
            .frame(width: 80, height: 60)
            .border(Color.gray)

            Text(label)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}

struct CircleButton: View {
    let symbol: String

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.blue.opacity(0.3))
            Image(systemName: symbol)
                .foregroundColor(.white)
        }
    }
}

// Custom badge modifier extension (renamed to avoid conflict with SwiftUI's badge)
extension View {
    func customBadge<B: View>(@ViewBuilder _ badge: () -> B) -> some View {
        overlay(alignment: .topTrailing) {
            badge()
                .alignmentGuide(.top) { $0.height / 2 }
                .alignmentGuide(.trailing) { $0.width / 2 }
        }
    }
}

// Custom alignment for menu example
struct MenuAlignment: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
        context.width / 2
    }
}

extension HorizontalAlignment {
    static let menu = HorizontalAlignment(MenuAlignment.self)
}

// Custom alignment for decimal point example
struct DecimalAlignment: AlignmentID {
    static func defaultValue(in d: ViewDimensions) -> CGFloat {
        d[.trailing]
    }
}

extension HorizontalAlignment {
    static let decimalPoint = HorizontalAlignment(DecimalAlignment.self)
}

struct PriceText: View {
    let dollars: String
    let cents: String

    var body: some View {
        HStack(spacing: 0) {
            Text("$" + dollars)
            Text(".")
                .alignmentGuide(.decimalPoint) { d in d[.trailing] }
            Text(cents)
        }
        .font(.largeTitle)
    }
}

// Custom alignment for chat message example
struct MessageAlignment: AlignmentID {
    static func defaultValue(in d: ViewDimensions) -> CGFloat {
        d[VerticalAlignment.center]
    }
}

extension VerticalAlignment {
    static let messageAlignment = VerticalAlignment(MessageAlignment.self)
}

struct ChatMessageBad: View {
    let name: String
    let message: String
    let color: Color

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Circle()
                .fill(color.opacity(0.3))
                .frame(width: 30, height: 30)

            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .font(.caption)
                    .bold()
                Text(message)
            }
        }
    }
}

struct ChatMessage: View {
    let name: String
    let message: String
    let color: Color

    var body: some View {
        HStack(alignment: .messageAlignment, spacing: 10) {
            Circle()
                .fill(color.opacity(0.3))
                .frame(width: 30, height: 30)
                .alignmentGuide(.messageAlignment) { d in d[.top] + 15 }

            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .font(.caption)
                    .bold()
                Text(message)
                    .alignmentGuide(.messageAlignment) { d in d[.firstTextBaseline] }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    TabView {
        BuiltInAlignmentBasics()
            .tabItem { Label("Basics", systemImage: "1.circle") }

        FrameAlignmentExample()
            .tabItem { Label("Frame", systemImage: "2.circle") }

        StackAlignmentExample()
            .tabItem { Label("Stacks", systemImage: "3.circle") }

        ZStackAlignmentExample()
            .tabItem { Label("ZStack", systemImage: "4.circle") }

        ModifiedAlignmentExample()
            .tabItem { Label("Modified", systemImage: "5.circle") }

        CustomAlignmentExample()
            .tabItem { Label("Custom", systemImage: "6.circle") }
    }
}
