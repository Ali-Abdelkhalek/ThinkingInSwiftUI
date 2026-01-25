//
//  CustomAlignmentExample.swift
//  ThinkingInSwiftUI
//
//  Advanced Alignments - Custom Alignment Identifiers
//

import SwiftUI

/// Demonstrates how to create completely custom alignment identifiers
/// that propagate through containers.
///
/// CUSTOM ALIGNMENT PROTOCOL:
/// 1. Define struct conforming to AlignmentID
/// 2. Implement defaultValue(in:) method
/// 3. Extend HorizontalAlignment or VerticalAlignment
/// 4. Use with VStack/HStack alignment parameter
/// 5. Set explicit guides with .alignmentGuide() or use default
///
/// KEY ADVANTAGE:
/// Custom alignments PROPAGATE through containers!
/// - Modified built-in guides get blocked by intermediate containers
/// - Custom guides pass through HStack/VStack to nested children
///
/// USE CASES:
/// - Menu items with varying content (align to circle centers)
/// - Decimal point alignment in price lists
/// - Chat message avatar alignment to first line
/// - Form labels of different widths
///
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

#Preview {
    CustomAlignmentExample()
}
