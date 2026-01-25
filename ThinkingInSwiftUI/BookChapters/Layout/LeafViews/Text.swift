//
//  Text.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Text
//  Understanding how Text determines its size
//

import SwiftUI

// MARK: - Tab 1: Text Sizing Basics

struct TextSizingBasicsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Text Sizing Basics")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("How Text Fits Into Proposed Size")
                            .font(.headline)

                        Text("""
                        By default, Text views fit themselves into ANY proposed size using these strategies (in order):

                        1. Word wrapping (break lines between words)
                        2. Line wrapping (break up words)
                        3. Truncation (add ...)
                        4. Clipping (cut off text)

                        Text ALWAYS reports the exact size it needs, which is ≤ proposed width, and at least the height of one line (except when proposed 0×0).

                        In other words: Text can become any width from zero to its ideal size.
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox("Examples: Same Text, Different Proposals") {
                    VStack(spacing: 20) {
                        // Narrow proposal
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Proposed: 25×50")
                                .font(.caption)
                                .foregroundColor(.secondary)

                            Text("Hello, World!")
                                .frame(width: 25, height: 50)
                                .border(Color.red, width: 2)

                            Text("Word wraps to fit")
                                .font(.caption2)
                                .foregroundColor(.green)
                        }

                        // Medium proposal
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Proposed: 50×50")
                                .font(.caption)
                                .foregroundColor(.secondary)

                            Text("Hello, World!")
                                .frame(width: 50, height: 50)
                                .border(Color.orange, width: 2)

                            Text("Fits on one line")
                                .font(.caption2)
                                .foregroundColor(.green)
                        }

                        // Wide proposal
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Proposed: 100×50")
                                .font(.caption)
                                .foregroundColor(.secondary)

                            Text("Hello, World!")
                                .frame(width: 100, height: 50)
                                .border(Color.blue, width: 2)

                            Text("Plenty of space")
                                .font(.caption2)
                                .foregroundColor(.green)
                        }
                    }
                    .padding()
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Text Wrapping Order")
                            .font(.headline)

                        Text("""
                        Text tries these strategies sequentially:

                        1️⃣ Word Wrapping
                           Break between words: "Hello, World!" → "Hello,\\nWorld!"

                        2️⃣ Line Wrapping
                           Break words: "Supercalifragilisticexpialidocious"
                                      → "Supercalifragi-\\nlisticexpialid-\\nocious"

                        3️⃣ Truncation
                           Add ellipsis: "Hello, World!" → "Hell..."

                        4️⃣ Clipping
                           Cut off: "Hello, World!" → "Hell" (no ...)
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox("Live Example: Long Text") {
                    VStack(spacing: 15) {
                        Text("SwiftUI is radically different from UIKit. In this short book, we will help you build a mental model of how SwiftUI works.")
                            .padding()
                            .border(Color.black, width: 2)

                        Text("No constraints → Natural size with word wrapping")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                }
            }
            .padding()
        }
    }
}

// MARK: - Tab 2: lineLimit & reservesSpace

struct LineLimitView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("lineLimit & reservesSpace")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text(".lineLimit(_ number:)")
                            .font(.headline)

                        Text("""
                        Limits the maximum number of lines that should be rendered, regardless of whether there's more vertical space.

                        .lineLimit(nil) → No limit (default for most contexts)
                        .lineLimit(1) → Single line (truncates rest)
                        .lineLimit(3) → Maximum 3 lines
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox("Examples") {
                    VStack(spacing: 20) {
                        // No line limit
                        VStack(alignment: .leading, spacing: 5) {
                            Text("No lineLimit (default)")
                                .font(.caption)
                                .bold()

                            Text("SwiftUI is radically different from UIKit. In this short book, we will help you build a mental model of how SwiftUI works. We explain the most important concepts in detail.")
                                .padding()
                                .border(Color.black, width: 2)

                            Text("Word wraps naturally")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }

                        // lineLimit 3
                        VStack(alignment: .leading, spacing: 5) {
                            Text(".lineLimit(3)")
                                .font(.caption)
                                .bold()

                            Text("SwiftUI is radically different from UIKit. In this short book, we will help you build a mental model of how SwiftUI works. We explain the most important concepts in detail.")
                                .lineLimit(3)
                                .padding()
                                .border(Color.black, width: 2)

                            Text("Truncates after 3 lines")
                                .font(.caption2)
                                .foregroundColor(.orange)
                        }

                        // lineLimit 1
                        VStack(alignment: .leading, spacing: 5) {
                            Text(".lineLimit(1)")
                                .font(.caption)
                                .bold()

                            Text("SwiftUI is radically different from UIKit. In this short book, we will help you build a mental model of how SwiftUI works.")
                                .lineLimit(1)
                                .padding()
                                .border(Color.black, width: 2)

                            Text("Single line, rest truncated")
                                .font(.caption2)
                                .foregroundColor(.red)
                        }
                    }
                    .padding()
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text(".lineLimit(_ limit:reservesSpace:)")
                            .font(.headline)

                        Text("""
                        New API: Reserves space for specified lines even if they're empty.

                        Useful for:
                        • Consistent layout (all cells same height in list)
                        • Preventing layout jumps when content changes
                        • Placeholder text areas
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox("reservesSpace Example") {
                    VStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(".lineLimit(7, reservesSpace: false)")
                                .font(.caption)
                                .bold()

                            Text("Short text")
                                .lineLimit(7, reservesSpace: false)
                                .padding()
                                .border(Color.black, width: 2)
                                .background(Color.gray.opacity(0.1))

                            Text("Only reserves space for actual content")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }

                        VStack(alignment: .leading, spacing: 5) {
                            Text(".lineLimit(7, reservesSpace: true)")
                                .font(.caption)
                                .bold()

                            Text("Short text")
                                .lineLimit(7, reservesSpace: true)
                                .padding()
                                .border(Color.black, width: 2)
                                .background(Color.gray.opacity(0.1))

                            Text("Reserves space for all 7 lines!")
                                .font(.caption2)
                                .foregroundColor(.orange)
                        }
                    }
                    .padding()
                }
            }
            .padding()
        }
    }
}

// MARK: - Tab 3: truncationMode & minimumScaleFactor

struct TruncationAndScalingView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("truncationMode & minimumScaleFactor")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text(".truncationMode(_ mode:)")
                            .font(.headline)

                        Text("""
                        Controls WHERE truncation happens:

                        .head → ...ld!
                        .middle → Hel...ld! (default)
                        .tail → Hello...
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox("truncationMode Examples") {
                    VStack(spacing: 15) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(".truncationMode(.head)")
                                .font(.caption)
                                .bold()

                            Text("SwiftUI is radically different from UIKit. In this short book, we will help you build a mental model.")
                                .lineLimit(1)
                                .truncationMode(.head)
                                .padding()
                                .border(Color.red, width: 2)
                        }

                        VStack(alignment: .leading, spacing: 5) {
                            Text(".truncationMode(.middle)")
                                .font(.caption)
                                .bold()

                            Text("SwiftUI is radically different from UIKit. In this short book, we will help you build a mental model.")
                                .lineLimit(1)
                                .truncationMode(.middle)
                                .padding()
                                .border(Color.orange, width: 2)
                        }

                        VStack(alignment: .leading, spacing: 5) {
                            Text(".truncationMode(.tail)")
                                .font(.caption)
                                .bold()

                            Text("SwiftUI is radically different from UIKit. In this short book, we will help you build a mental model.")
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .padding()
                                .border(Color.blue, width: 2)
                        }
                    }
                    .padding()
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text(".minimumScaleFactor(_ factor:)")
                            .font(.headline)

                        Text("""
                        Allows Text to scale font size DOWN to fit into proposed size.

                        Factor range: 0.0 to 1.0
                        • 1.0 = No scaling (default)
                        • 0.5 = Can scale down to 50% of original size
                        • 0.1 = Can scale down to 10% (very small!)

                        Text tries to fit by scaling before truncating.
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox("minimumScaleFactor Example") {
                    VStack(spacing: 15) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Without minimumScaleFactor")
                                .font(.caption)
                                .bold()

                            Text("SwiftUI is radically different from UIKit. In this short book, we will help you build a mental model of how SwiftUI works.")
                                .lineLimit(3)
                                .padding()
                                .border(Color.black, width: 2)

                            Text("Normal size, might truncate")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }

                        VStack(alignment: .leading, spacing: 5) {
                            Text(".minimumScaleFactor(0.4)")
                                .font(.caption)
                                .bold()

                            Text("SwiftUI is radically different from UIKit. In this short book, we will help you build a mental model of how SwiftUI works.")
                                .lineLimit(3)
                                .minimumScaleFactor(0.4)
                                .padding()
                                .border(Color.black, width: 2)
                                .background(Color.cyan.opacity(0.2))

                            Text("Scales down to fit more text!")
                                .font(.caption2)
                                .foregroundColor(.green)
                        }
                    }
                    .padding()
                }
            }
            .padding()
        }
    }
}

// MARK: - Tab 4: fixedSize with Text

struct FixedSizeWithTextView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("fixedSize with Text")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("What .fixedSize() Does")
                            .font(.headline)

                        Text("""
                        .fixedSize() proposes nil×nil to its subview.

                        For Text, this means:
                        "Become your IDEAL SIZE"

                        Ideal size for Text = Size needed to render content WITHOUT wrapping or truncation.
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox("Example: Text with fixedSize()") {
                    VStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Proposed: 25×50, no fixedSize")
                                .font(.caption)
                                .foregroundColor(.secondary)

                            Text("Hello, World!")
                                .frame(width: 25, height: 50)
                                .border(Color.blue, width: 2)

                            Text("Wraps to fit in 25pt")
                                .font(.caption2)
                                .foregroundColor(.blue)
                        }

                        VStack(alignment: .leading, spacing: 5) {
                            Text("Proposed: 25×50, WITH fixedSize")
                                .font(.caption)
                                .foregroundColor(.secondary)

                            Text("Hello, World!")
                                .fixedSize()
                                .frame(width: 25, height: 50)
                                .border(Color.red, width: 2)

                            Text("Ignores proposal, renders at ideal size (draws OUT OF BOUNDS!)")
                                .font(.caption2)
                                .foregroundColor(.red)
                        }

                        VStack(alignment: .leading, spacing: 5) {
                            Text("Proposed: 100×50, WITH fixedSize")
                                .font(.caption)
                                .foregroundColor(.secondary)

                            Text("Hello, World!")
                                .fixedSize()
                                .frame(width: 100, height: 50)
                                .border(Color.green, width: 2)

                            Text("Still ideal size, fits within bounds")
                                .font(.caption2)
                                .foregroundColor(.green)
                        }
                    }
                    .padding()
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text(".fixedSize(horizontal:vertical:)")
                            .font(.headline)

                        Text("""
                        Control which dimension becomes ideal size:

                        .fixedSize(horizontal: true, vertical: false)
                        → Width becomes ideal, height still wraps

                        .fixedSize(horizontal: false, vertical: true)
                        → Height becomes ideal, width still wraps
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox("Directional fixedSize Example") {
                    VStack(spacing: 15) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(".fixedSize(horizontal: false, vertical: true)")
                                .font(.caption)
                                .bold()

                            Text("SwiftUI is radically different from UIKit. In this short book, we will help you build a mental model of how SwiftUI works.")
                                .fixedSize(horizontal: false, vertical: true)
                                .padding()
                                .border(Color.black, width: 2)

                            Text("Width wraps, height at ideal (no line limit)")
                                .font(.caption2)
                                .foregroundColor(.green)
                        }
                    }
                    .padding()
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Common Use Case")
                            .font(.headline)

                        Text("""
                        Text will do ANYTHING to fit into proposed size (truncation, wrapping, etc.).

                        Sometimes you want to PREVENT this:

                        Text("Important Label")
                            .fixedSize()

                        Now it won't truncate or wrap, even if space is limited.

                        ⚠️ Warning: Can cause overflow if there's not enough space!
                        """)
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

// MARK: - Tab 5: Real-World Patterns

struct TextRealWorldPatternsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Real-World Patterns")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Pattern 1: Multiline Labels")
                            .font(.headline)

                        Text("""
                        Problem: Labels in forms should wrap, not truncate

                        Solution:
                        Text("Long descriptive label")
                            .fixedSize(horizontal: false, vertical: true)

                        Allows vertical expansion, constrains horizontal
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(5)

                        VStack(alignment: .leading) {
                            Text("User Agreement")
                                .font(.caption)
                            Text("I agree to the terms and conditions and privacy policy of this application.")
                                .font(.caption2)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Pattern 2: Guaranteed Single Line")
                            .font(.headline)

                        Text("""
                        Problem: Want text on single line, truncate if needed

                        Solution:
                        Text("Long text here")
                            .lineLimit(1)

                        Perfect for list cells, headers, badges
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)

                        HStack {
                            Image(systemName: "person.circle.fill")
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text("User Name That Could Be Very Long")
                                    .lineLimit(1)
                                    .font(.headline)
                                Text("Subtitle")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Pattern 3: Adaptive Sizing")
                            .font(.headline)

                        Text("""
                        Problem: Button text should scale down if needed

                        Solution:
                        Button("Action") { }
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)

                        Scales font down to 70% before truncating
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(5)

                        Button(action: {}) {
                            Text("Very Long Button Title")
                                .lineLimit(1)
                                .minimumScaleFactor(0.7)
                                .frame(maxWidth: 150)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Pattern 4: Fixed Height Preview")
                            .font(.headline)

                        Text("""
                        Problem: Show preview of long text with consistent height

                        Solution:
                        Text(longContent)
                            .lineLimit(3)
                            .truncationMode(.tail)

                        Always 3 lines max, truncates rest
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.purple.opacity(0.1))
                        .cornerRadius(5)

                        VStack(alignment: .leading) {
                            Text("Article Title")
                                .font(.headline)
                            Text("SwiftUI is radically different from UIKit. In this short book, we will help you build a mental model of how SwiftUI works. We explain the most important concepts in detail and help you build a solid foundation.")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .lineLimit(3)
                                .truncationMode(.tail)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Summary: Text Modifiers")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 6) {
                            Text("• .lineLimit(n) - Limit lines")
                            Text("• .lineLimit(n, reservesSpace: true) - Reserve space")
                            Text("• .truncationMode(.tail/.head/.middle) - Where to truncate")
                            Text("• .minimumScaleFactor(0.x) - Allow font scaling")
                            Text("• .fixedSize() - Ideal size (no wrapping)")
                            Text("• .fixedSize(horizontal: false, vertical: true) - Directional")
                        }
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.05))
                        .cornerRadius(5)
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Preview

#Preview {
    TabView {
        TextSizingBasicsView()
            .tabItem { Label("Basics", systemImage: "1.circle") }

        LineLimitView()
            .tabItem { Label("lineLimit", systemImage: "2.circle") }

        TruncationAndScalingView()
            .tabItem { Label("Truncation", systemImage: "3.circle") }

        FixedSizeWithTextView()
            .tabItem { Label("fixedSize", systemImage: "4.circle") }

        TextRealWorldPatternsView()
            .tabItem { Label("Patterns", systemImage: "5.circle") }
    }
}
