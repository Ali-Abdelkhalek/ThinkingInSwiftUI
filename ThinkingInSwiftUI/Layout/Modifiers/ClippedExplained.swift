//
//  ClippedExplained.swift
//  ThinkingInSwiftUI
//
//  Understanding what .clipped() does and doesn't do
//  It clips visual overflow but does NOT change frame size or remove empty space
//

import SwiftUI

struct ClippedExplained: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                sectionHeader("Understanding .clipped()")

                keyConceptSection

                sectionHeader("1. What clipped() Does")

                whatItDoes

                sectionHeader("2. What clipped() Does NOT Do")

                whatItDoesNot

                sectionHeader("3. Overflow Scenarios")

                overflowExamples

                sectionHeader("4. Empty Space Scenarios")

                emptySpaceExamples

                sectionHeader("5. Common Misconceptions")

                misconceptions

                sectionHeader("6. Practical Use Cases")

                practicalUseCases
            }
            .padding()
        }
    }

    // MARK: - Key Concept

    private var keyConceptSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("The Critical Distinction:")
                .font(.headline)

            VStack(alignment: .leading, spacing: 8) {
                conceptItem(
                    symbol: "✅",
                    title: "What .clipped() DOES:",
                    description: "Clips visual rendering of content that extends beyond the view's bounds",
                    color: .green
                )

                conceptItem(
                    symbol: "❌",
                    title: "What .clipped() does NOT do:",
                    description: "Does NOT change the view's frame size or remove empty space",
                    color: .red
                )
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Think of it like this:")
                    .fontWeight(.semibold)
                    .padding(.top, 8)

                Text("• Frame size = what the layout system sees")
                Text("• Visual rendering = what you see on screen")
                Text("• .clipped() only affects visual rendering")
                Text("• Frame size stays exactly the same!")
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(12)
    }

    // MARK: - What It Does

    private var whatItDoes: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Visual Overflow - Without clipped()",
                description: "Content extends beyond frame bounds visually",
                code: ".frame(width: 100).background(Color.red)"
            ) {
                VStack(spacing: 12) {
                    // Container to show the bounds
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .stroke(Color.blue, lineWidth: 2)
                            .frame(width: 100, height: 50)

                        Text("This is very long text that overflows")
                            .background(Color.red.opacity(0.3))
                            .frame(width: 100, height: 50)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Blue border = frame bounds (100pt)")
                        Text("Red background = actual text (extends beyond)")
                        Text("❌ Text visually overflows the frame")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Visual Overflow - With clipped()",
                description: "Content is cropped at frame bounds",
                code: ".frame(width: 100).background(Color.red).clipped()"
            ) {
                VStack(spacing: 12) {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .stroke(Color.blue, lineWidth: 2)
                            .frame(width: 100, height: 50)

                        Text("This is very long text that overflows")
                            .background(Color.red.opacity(0.3))
                            .frame(width: 100, height: 50)
                            .clipped()
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Blue border = frame bounds (100pt)")
                        Text("Red background = text (cropped at 100pt)")
                        Text("✅ Text is clipped at frame boundary")
                        Text("⚠️ Frame is STILL 100pt - only rendering changed!")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Important: Frame Size Unchanged",
                description: "clipped() only affects rendering, not layout",
                code: ""
            ) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 20) {
                        VStack(spacing: 8) {
                            Text("Without")
                                .font(.caption)

                            GeometryReader { geo in
                                Text("Overflow")
                                    .frame(width: 200)
                                    .background(Color.red.opacity(0.3))
                                    .frame(width: 100, height: 50)
                                    .background(
                                        Text("Frame: \(Int(geo.size.width))×\(Int(geo.size.height))")
                                            .font(.caption)
                                            .offset(y: 30)
                                    )
                            }
                            .frame(height: 80)
                        }

                        VStack(spacing: 8) {
                            Text("With .clipped()")
                                .font(.caption)

                            GeometryReader { geo in
                                Text("Overflow")
                                    .frame(width: 200)
                                    .background(Color.red.opacity(0.3))
                                    .frame(width: 100, height: 50)
                                    .clipped()
                                    .background(
                                        Text("Frame: \(Int(geo.size.width))×\(Int(geo.size.height))")
                                            .font(.caption)
                                            .offset(y: 30)
                                    )
                            }
                            .frame(height: 80)
                        }
                    }

                    Text("Both frames are the same size! Only the visual rendering is different.")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.orange)
                        .padding(.top, 8)
                }
            }
        }
    }

    // MARK: - What It Does NOT Do

    private var whatItDoesNot: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Does NOT Remove Empty Space",
                description: "Empty space in the frame remains unchanged",
                code: ".frame(width: 200, height: 200).clipped()"
            ) {
                VStack(spacing: 12) {
                    HStack(spacing: 20) {
                        VStack(spacing: 8) {
                            Text("Without .clipped()")
                                .font(.caption)

                            ZStack {
                                Rectangle()
                                    .stroke(Color.blue, lineWidth: 2)
                                    .frame(width: 150, height: 150)

                                Text("Small\nText")
                                    .background(Color.red.opacity(0.3))
                                    .frame(width: 150, height: 150)
                            }
                        }

                        VStack(spacing: 8) {
                            Text("With .clipped()")
                                .font(.caption)

                            ZStack {
                                Rectangle()
                                    .stroke(Color.blue, lineWidth: 2)
                                    .frame(width: 150, height: 150)

                                Text("Small\nText")
                                    .background(Color.red.opacity(0.3))
                                    .frame(width: 150, height: 150)
                                    .clipped()
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Identical! Both have the same empty space")
                        Text("clipped() does nothing when there's no overflow")
                        Text("Frame is still 150×150 in both cases")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Does NOT Change Layout",
                description: "Other views are positioned based on frame size, not clipped content",
                code: ""
            ) {
                VStack(spacing: 12) {
                    HStack(spacing: 20) {
                        VStack(spacing: 4) {
                            Text("No clipped")
                                .font(.caption)

                            HStack(spacing: 0) {
                                Text("Overflow Text")
                                    .frame(width: 50)
                                    .background(Color.red.opacity(0.3))
                                    .border(Color.red, width: 1)

                                Text("Next")
                                    .background(Color.green.opacity(0.3))
                                    .border(Color.green, width: 1)
                            }
                        }

                        VStack(spacing: 4) {
                            Text("With clipped")
                                .font(.caption)

                            HStack(spacing: 0) {
                                Text("Overflow Text")
                                    .frame(width: 50)
                                    .background(Color.red.opacity(0.3))
                                    .border(Color.red, width: 1)
                                    .clipped()

                                Text("Next")
                                    .background(Color.green.opacity(0.3))
                                    .border(Color.green, width: 1)
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Green view is in the SAME position in both!")
                        Text("Layout sees the frame (50pt), not the visual overflow")
                        Text("clipped() only affects what you see, not layout")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Does NOT Shrink Frame to Content",
                description: "If you want to remove empty space, use fixedSize() instead",
                code: ""
            ) {
                VStack(spacing: 12) {
                    HStack(spacing: 20) {
                        VStack(spacing: 8) {
                            Text("With .clipped()")
                                .font(.caption)

                            Text("Hi")
                                .background(Color.red.opacity(0.3))
                                .frame(width: 150)
                                .background(Color.blue.opacity(0.1))
                                .border(Color.blue, width: 2)
                                .clipped()

                            Text("Frame: 150pt\n(empty space remains)")
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }

                        VStack(spacing: 8) {
                            Text("With .fixedSize()")
                                .font(.caption)

                            Text("Hi")
                                .background(Color.red.opacity(0.3))
                                .frame(width: 150)
                                .fixedSize()
                                .background(Color.blue.opacity(0.1))
                                .border(Color.blue, width: 2)

                            Text("Frame: ~16pt\n(shrunk to content)")
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                    }

                    Text("To remove empty space, use .fixedSize(), NOT .clipped()")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.orange)
                }
            }
        }
    }

    // MARK: - Overflow Examples

    private var overflowExamples: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Image Overflow",
                description: "Image larger than frame",
                code: ".frame(width: 100, height: 100).clipped()"
            ) {
                VStack(spacing: 12) {
                    HStack(spacing: 20) {
                        VStack(spacing: 8) {
                            Text("Without")
                                .font(.caption)

                            Circle()
                                .fill(Color.blue)
                                .frame(width: 150, height: 150)
                                .frame(width: 100, height: 100)
                                .border(Color.red, width: 2)
                        }

                        VStack(spacing: 8) {
                            Text("With .clipped()")
                                .font(.caption)

                            Circle()
                                .fill(Color.blue)
                                .frame(width: 150, height: 150)
                                .frame(width: 100, height: 100)
                                .clipped()
                                .border(Color.red, width: 2)
                        }
                    }

                    Text("Left: Circle overflows visually. Right: Circle cropped at red border.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Shape Overflow",
                description: "Common with aspectRatio and .fill mode",
                code: ".aspectRatio(contentMode: .fill).clipped()"
            ) {
                VStack(spacing: 12) {
                    HStack(spacing: 20) {
                        VStack(spacing: 8) {
                            Text("Without")
                                .font(.caption)

                            Rectangle()
                                .fill(Color.green)
                                .aspectRatio(2, contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .border(Color.red, width: 2)
                        }

                        VStack(spacing: 8) {
                            Text("With .clipped()")
                                .font(.caption)

                            Rectangle()
                                .fill(Color.green)
                                .aspectRatio(2, contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipped()
                                .border(Color.red, width: 2)
                        }
                    }

                    Text("With .fill mode, content often overflows - use .clipped() to crop")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }

    // MARK: - Empty Space Examples

    private var emptySpaceExamples: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Empty Space Remains",
                description: "clipped() does NOT remove padding or empty areas",
                code: ".padding(50).clipped()"
            ) {
                VStack(spacing: 12) {
                    HStack(spacing: 20) {
                        VStack(spacing: 8) {
                            Text("Without")
                                .font(.caption)

                            Text("Text")
                                .background(Color.red.opacity(0.3))
                                .padding(50)
                                .background(Color.blue.opacity(0.1))
                                .border(Color.blue, width: 2)
                        }

                        VStack(spacing: 8) {
                            Text("With .clipped()")
                                .font(.caption)

                            Text("Text")
                                .background(Color.red.opacity(0.3))
                                .padding(50)
                                .background(Color.blue.opacity(0.1))
                                .border(Color.blue, width: 2)
                                .clipped()
                        }
                    }

                    Text("Identical! Padding/empty space is NOT removed by .clipped()")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "To Remove Empty Space: Use Different Approach",
                description: "fixedSize(), removing padding, or adjusting frame",
                code: ""
            ) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Problem: Too much empty space")
                        .fontWeight(.semibold)

                    Text("Text")
                        .background(Color.red.opacity(0.3))
                        .frame(width: 200)
                        .background(Color.blue.opacity(0.1))
                        .border(Color.blue, width: 2)

                    Text("❌ Wrong: .clipped() won't help")
                        .foregroundColor(.red)

                    Text("✅ Right solutions:")
                        .foregroundColor(.green)

                    VStack(alignment: .leading, spacing: 8) {
                        solutionItem("1", ".fixedSize() - shrink to content")
                        solutionItem("2", "Remove or reduce .frame() width")
                        solutionItem("3", "Remove unnecessary padding")
                        solutionItem("4", "Use appropriate alignment")
                    }
                    .font(.caption)
                }
            }
        }
    }

    // MARK: - Misconceptions

    private var misconceptions: some View {
        VStack(spacing: 20) {
            misconceptionCard(
                myth: "Myth: .clipped() removes empty space",
                reality: "Reality: .clipped() only crops overflow, doesn't change frame size",
                example: "A 200pt wide frame with 50pt content stays 200pt wide after .clipped()"
            )

            misconceptionCard(
                myth: "Myth: .clipped() shrinks the view to fit content",
                reality: "Reality: Use .fixedSize() to shrink views to content size",
                example: ".fixedSize() changes layout, .clipped() only changes rendering"
            )

            misconceptionCard(
                myth: "Myth: .clipped() affects layout of sibling views",
                reality: "Reality: Sibling views are positioned based on frame size, not clipped content",
                example: "Views next to clipped content don't move closer"
            )

            misconceptionCard(
                myth: "Myth: .clipped() is needed when there's empty space",
                reality: "Reality: .clipped() is needed when content overflows beyond bounds",
                example: "Empty space = use .fixedSize() or adjust frame. Overflow = use .clipped()"
            )
        }
    }

    // MARK: - Practical Use Cases

    private var practicalUseCases: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Use Case 1: Image with .fill mode",
                description: "Prevent image overflow when using aspectRatio .fill",
                code: ".aspectRatio(contentMode: .fill).clipped()"
            ) {
                VStack(spacing: 8) {
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .aspectRatio(16/9, contentMode: .fill)
                        .frame(width: 200, height: 100)
                        .clipped()
                        .border(Color.red, width: 2)

                    Text("Without .clipped(), gradient would overflow")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Use Case 2: Custom Shape Overflow",
                description: "Clip shapes that extend beyond their container",
                code: ".overlay(shape).clipped()"
            ) {
                VStack(spacing: 8) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 100, height: 100)
                        .overlay(
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 150, height: 150)
                        )
                        .clipped()
                        .border(Color.red, width: 2)

                    Text("Circle is clipped to rectangle bounds")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Use Case 3: Text Truncation Alternative",
                description: "Clip text instead of showing ellipsis",
                code: ".frame(width: 100).clipped()"
            ) {
                VStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Default (ellipsis):")
                            .font(.caption)

                        Text("Long text here that overflows")
                            .frame(width: 150)
                            .background(Color.blue.opacity(0.1))
                            .border(Color.blue, width: 1)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("With .clipped():")
                            .font(.caption)

                        Text("Long text here that overflows")
                            .lineLimit(1)
                            .fixedSize()
                            .frame(width: 150, alignment: .leading)
                            .clipped()
                            .background(Color.green.opacity(0.1))
                            .border(Color.green, width: 1)
                    }

                    Text("Top: shows '...', Bottom: hard clip")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }

    // MARK: - Helper Views

    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.title2)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top)
    }

    private func exampleCard<Content: View>(
        title: String,
        description: String,
        code: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)

            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary)

            if !code.isEmpty {
                Text(code)
                    .font(.system(.caption, design: .monospaced))
                    .padding(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(4)
            }

            content()
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }

    private func conceptItem(symbol: String, title: String, description: String, color: Color) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Text(symbol)
                .font(.title2)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .fontWeight(.semibold)
                    .foregroundColor(color)

                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(8)
    }

    private func misconceptionCard(myth: String, reality: String, example: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 8) {
                Text("❌")
                Text(myth)
                    .fontWeight(.semibold)
                    .foregroundColor(.red)
            }

            HStack(alignment: .top, spacing: 8) {
                Text("✅")
                Text(reality)
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
            }

            Text(example)
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, 4)
        }
        .padding()
        .background(Color.yellow.opacity(0.1))
        .cornerRadius(8)
    }

    private func solutionItem(_ number: String, _ text: String) -> some View {
        HStack(alignment: .top, spacing: 6) {
            Text("\(number).")
                .fontWeight(.semibold)
            Text(text)
        }
    }
}

// MARK: - Preview

#Preview {
    ClippedExplained()
}

/*
 .CLIPPED() SUMMARY:

 ## What It Does:

 - Clips visual rendering of content that extends BEYOND the view's bounds
 - Like using scissors to cut off overflow
 - Only affects what you SEE, not the layout

 ## What It Does NOT Do:

 - Does NOT change the view's frame size
 - Does NOT remove empty space
 - Does NOT affect layout of sibling views
 - Does NOT shrink the view to fit content

 ## Key Concepts:

 1. Frame Size vs Visual Rendering
    - Frame size = what the layout system sees
    - Visual rendering = what you see on screen
    - .clipped() only affects visual rendering

 2. Empty Space vs Overflow
    - Empty space = frame larger than content → .clipped() does nothing
    - Overflow = content larger than frame → .clipped() crops it

 3. To Remove Empty Space:
    - Use .fixedSize() to shrink to content
    - Adjust or remove .frame() modifiers
    - Reduce or remove .padding()
    - NOT .clipped()!

 ## Common Use Cases:

 1. Images with .aspectRatio(contentMode: .fill)
 2. Custom shapes that overflow containers
 3. Preventing visual overflow in fixed-size containers
 4. Alternative to text ellipsis truncation

 ## Example:

 // WITHOUT clipped - visual overflow
 Text("Very long text")
     .frame(width: 50)
 // Result: Text extends beyond 50pt visually, frame is 50pt

 // WITH clipped - cropped at boundary
 Text("Very long text")
     .frame(width: 50)
     .clipped()
 // Result: Text cropped at 50pt visually, frame is STILL 50pt

 The frame size is THE SAME in both cases!
 */
