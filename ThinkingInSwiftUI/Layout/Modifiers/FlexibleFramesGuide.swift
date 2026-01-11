//
//  FlexibleFramesGuide.swift
//  ThinkingInSwiftUI
//
//  Comprehensive guide to flexible frames in SwiftUI
//  Covers all combinations of minWidth, maxWidth, idealWidth, minHeight, maxHeight, idealHeight
//

import SwiftUI

struct FlexibleFramesGuide: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                sectionHeader("Width-Only Flexible Frames")

                widthOnlyExamples

                sectionHeader("Height-Only Flexible Frames")

                heightOnlyExamples

                sectionHeader("Ideal Size Examples")

                idealSizeExamples

                sectionHeader("Combined Width + Height")

                combinedExamples

                sectionHeader("Alignment Parameter")

                alignmentExamples

                sectionHeader("Common Patterns")

                commonPatterns
            }
            .padding()
        }
    }

    // MARK: - Width-Only Examples

    private var widthOnlyExamples: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "1. maxWidth Only",
                description: "Frame becomes at least proposed width, or subview width if wider",
                code: ".frame(maxWidth: .infinity)"
            ) {
                Text("Short")
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.3))
                    .border(Color.blue, width: 2)
            }

            exampleCard(
                title: "2. maxWidth with Fixed Value",
                description: "Frame becomes min(proposed, maxWidth) or subview width if smaller",
                code: ".frame(maxWidth: 150)"
            ) {
                VStack(spacing: 10) {
                    Text("Short")
                        .frame(maxWidth: 150)
                        .background(Color.green.opacity(0.3))
                        .border(Color.green, width: 2)

                    Text("Very Long Text That Exceeds 150")
                        .frame(maxWidth: 150)
                        .background(Color.green.opacity(0.3))
                        .border(Color.green, width: 2)
                }
            }

            exampleCard(
                title: "3. minWidth Only",
                description: "Frame becomes at least minWidth, at most subview width",
                code: ".frame(minWidth: 200)"
            ) {
                VStack(spacing: 10) {
                    Text("Short")
                        .frame(minWidth: 200)
                        .background(Color.orange.opacity(0.3))
                        .border(Color.orange, width: 2)

                    Text("Very Long Text That Exceeds 200 Points Width")
                        .frame(minWidth: 200)
                        .background(Color.orange.opacity(0.3))
                        .border(Color.orange, width: 2)
                }
            }

            exampleCard(
                title: "4. minWidth + maxWidth",
                description: "Frame becomes exactly proposed width (clamped between min and max)",
                code: ".frame(minWidth: 0, maxWidth: .infinity)"
            ) {
                Text("Any Size")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.purple.opacity(0.3))
                    .border(Color.purple, width: 2)
            }

            exampleCard(
                title: "5. minWidth + maxWidth (Fixed Range)",
                description: "Frame width clamped between 100-250",
                code: ".frame(minWidth: 100, maxWidth: 250)"
            ) {
                VStack(spacing: 10) {
                    Text("Hi")
                        .frame(minWidth: 100, maxWidth: 250)
                        .background(Color.pink.opacity(0.3))
                        .border(Color.pink, width: 2)

                    Text("Medium Text Here")
                        .frame(minWidth: 100, maxWidth: 250)
                        .background(Color.pink.opacity(0.3))
                        .border(Color.pink, width: 2)

                    Text("Very Long Text That Would Exceed 250 Points")
                        .frame(minWidth: 100, maxWidth: 250)
                        .background(Color.pink.opacity(0.3))
                        .border(Color.pink, width: 2)
                }
            }
        }
    }

    // MARK: - Height-Only Examples

    private var heightOnlyExamples: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "1. maxHeight Only",
                description: "Frame becomes at least proposed height, or subview height if taller",
                code: ".frame(maxHeight: .infinity)"
            ) {
                HStack(spacing: 20) {
                    Text("Fills\nAvailable\nHeight")
                        .frame(maxHeight: .infinity)
                        .background(Color.blue.opacity(0.3))
                        .border(Color.blue, width: 2)

                    Text("Also\nFills")
                        .frame(maxHeight: .infinity)
                        .background(Color.blue.opacity(0.3))
                        .border(Color.blue, width: 2)
                }
                .frame(height: 150)
            }

            exampleCard(
                title: "2. minHeight Only",
                description: "Frame becomes at least minHeight, at most subview height",
                code: ".frame(minHeight: 100)"
            ) {
                HStack(spacing: 20) {
                    Text("Short")
                        .frame(minHeight: 100)
                        .background(Color.orange.opacity(0.3))
                        .border(Color.orange, width: 2)

                    Text("Tall\nText\nWith\nMany\nLines")
                        .frame(minHeight: 100)
                        .background(Color.orange.opacity(0.3))
                        .border(Color.orange, width: 2)
                }
            }

            exampleCard(
                title: "3. minHeight + maxHeight",
                description: "Frame becomes exactly proposed height (clamped)",
                code: ".frame(minHeight: 0, maxHeight: .infinity)"
            ) {
                Text("Accepts\nProposed\nHeight")
                    .frame(minHeight: 0, maxHeight: .infinity)
                    .background(Color.purple.opacity(0.3))
                    .border(Color.purple, width: 2)
                    .frame(height: 120)
            }
        }
    }

    // MARK: - Ideal Size Examples

    private var idealSizeExamples: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "1. idealWidth",
                description: "Used when nil is proposed for width. Frame proposes idealWidth to subview and reports it as own width",
                code: ".frame(idealWidth: 200)"
            ) {
                // In a container that proposes nil (like HStack with spacing)
                HStack {
                    Color.clear.frame(width: 0)
                    Text("Ideal")
                        .frame(idealWidth: 200)
                        .background(Color.cyan.opacity(0.3))
                        .border(Color.cyan, width: 2)
                }
            }

            exampleCard(
                title: "2. idealWidth + minWidth + maxWidth",
                description: "idealWidth used when nil proposed, otherwise clamped between min/max",
                code: ".frame(minWidth: 100, idealWidth: 200, maxWidth: 300)"
            ) {
                VStack(spacing: 10) {
                    Text("With Constraints")
                        .frame(minWidth: 100, idealWidth: 200, maxWidth: 300)
                        .background(Color.mint.opacity(0.3))
                        .border(Color.mint, width: 2)

                    Text("Explanation: If proposed nil → uses 200. If proposed 50 → becomes 100. If proposed 250 → becomes 250. If proposed 400 → becomes 300.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "3. idealHeight",
                description: "Used when nil is proposed for height",
                code: ".frame(idealHeight: 100)"
            ) {
                VStack {
                    Color.clear.frame(height: 0)
                    Text("Ideal\nHeight")
                        .frame(idealHeight: 100)
                        .background(Color.indigo.opacity(0.3))
                        .border(Color.indigo, width: 2)
                }
            }
        }
    }

    // MARK: - Combined Width + Height Examples

    private var combinedExamples: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "1. Fill All Available Space",
                description: "Takes all proposed width and height",
                code: ".frame(maxWidth: .infinity, maxHeight: .infinity)"
            ) {
                Text("Fills Everything")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.blue.opacity(0.3))
                    .border(Color.blue, width: 2)
                    .frame(height: 150)
            }

            exampleCard(
                title: "2. Accept Proposed Size",
                description: "Accepts exactly what's proposed for both dimensions",
                code: ".frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)"
            ) {
                Text("Exact\nProposed")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .background(Color.purple.opacity(0.3))
                    .border(Color.purple, width: 2)
                    .frame(height: 100)
            }

            exampleCard(
                title: "3. Constrained Both Dimensions",
                description: "Width: 100-250, Height: 50-150",
                code: ".frame(minWidth: 100, maxWidth: 250, minHeight: 50, maxHeight: 150)"
            ) {
                Text("Constrained\nBox")
                    .frame(minWidth: 100, maxWidth: 250, minHeight: 50, maxHeight: 150)
                    .background(Color.green.opacity(0.3))
                    .border(Color.green, width: 2)
            }

            exampleCard(
                title: "4. Ideal Width + Max Height",
                description: "Uses ideal width when nil proposed, fills height",
                code: ".frame(idealWidth: 200, maxHeight: .infinity)"
            ) {
                Text("Ideal W\nMax H")
                    .frame(idealWidth: 200, maxHeight: .infinity)
                    .background(Color.orange.opacity(0.3))
                    .border(Color.orange, width: 2)
                    .frame(height: 100)
            }
        }
    }

    // MARK: - Alignment Examples

    private var alignmentExamples: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "1. Default Alignment (Center)",
                description: "Subview centered in frame",
                code: ".frame(width: 200, height: 100)"
            ) {
                Text("Centered")
                    .background(Color.red)
                    .frame(width: 200, height: 100)
                    .background(Color.gray.opacity(0.3))
                    .border(Color.gray, width: 2)
            }

            exampleCard(
                title: "2. Top Leading Alignment",
                description: "Subview positioned at top-leading corner",
                code: ".frame(width: 200, height: 100, alignment: .topLeading)"
            ) {
                Text("Top Leading")
                    .background(Color.red)
                    .frame(width: 200, height: 100, alignment: .topLeading)
                    .background(Color.gray.opacity(0.3))
                    .border(Color.gray, width: 2)
            }

            exampleCard(
                title: "3. Bottom Trailing Alignment",
                description: "Subview positioned at bottom-trailing corner",
                code: ".frame(width: 200, height: 100, alignment: .bottomTrailing)"
            ) {
                Text("Bottom Trailing")
                    .background(Color.red)
                    .frame(width: 200, height: 100, alignment: .bottomTrailing)
                    .background(Color.gray.opacity(0.3))
                    .border(Color.gray, width: 2)
            }

            exampleCard(
                title: "4. Flexible Frame with Alignment",
                description: "maxWidth with leading alignment",
                code: ".frame(maxWidth: .infinity, alignment: .leading)"
            ) {
                Text("Leading")
                    .background(Color.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.3))
                    .border(Color.gray, width: 2)
            }
        }
    }

    // MARK: - Common Patterns

    private var commonPatterns: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Pattern: Full Width",
                description: "Make view span entire available width",
                code: ".frame(maxWidth: .infinity)"
            ) {
                Text("Full Width Button")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            exampleCard(
                title: "Pattern: Accept Proposed Width",
                description: "Ignore subview width, use proposed width",
                code: ".frame(minWidth: 0, maxWidth: .infinity)"
            ) {
                Text("Hi")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color.teal)
                    .foregroundColor(.white)
            }

            exampleCard(
                title: "Pattern: Minimum Size",
                description: "Ensure minimum tappable area",
                code: ".frame(minWidth: 44, minHeight: 44)"
            ) {
                Text("Tap")
                    .frame(minWidth: 44, minHeight: 44)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            exampleCard(
                title: "Pattern: Aspect Ratio Container",
                description: "Fill width, constrain height",
                code: ".frame(maxWidth: .infinity, maxHeight: 200)"
            ) {
                Color.blue
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .overlay(Text("Image Placeholder").foregroundColor(.white))
            }

            exampleCard(
                title: "Pattern: Centered Fixed Size",
                description: "Fixed size centered in available space",
                code: ".frame(width: 100, height: 100)"
            ) {
                Circle()
                    .fill(Color.orange)
                    .frame(width: 100, height: 100)
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

            Text(code)
                .font(.system(.caption, design: .monospaced))
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(4)

            content()
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
}

// MARK: - View Extensions for Common Patterns

extension View {
    /// Pattern: Frame becomes at least proposed width, or subview width if wider
    func proposedWidthOrGreater() -> some View {
        frame(maxWidth: .infinity)
    }

    /// Pattern: Frame becomes exactly proposed width
    func acceptProposedWidth() -> some View {
        frame(minWidth: 0, maxWidth: .infinity)
    }

    /// Pattern: Frame becomes at least proposed height, or subview height if taller
    func proposedHeightOrGreater() -> some View {
        frame(maxHeight: .infinity)
    }

    /// Pattern: Frame becomes exactly proposed height
    func acceptProposedHeight() -> some View {
        frame(minHeight: 0, maxHeight: .infinity)
    }

    /// Pattern: Fill all available space
    func fillAvailableSpace() -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    /// Pattern: Accept all proposed dimensions
    func acceptProposedSize() -> some View {
        frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

// MARK: - Preview

#Preview {
    FlexibleFramesGuide()
}

/*
 FLEXIBLE FRAMES BEHAVIOR SUMMARY:

 ## How Flexible Frames Work (Two-Pass System):

 ### Pass 1 - Proposing to Subview:
 The flexible frame takes the proposed size and clamps it by min/max parameters.
 This clamped size is proposed to the frame's subview.

 Example: If proposed 300 with minWidth: 100, maxWidth: 250
 → Frame proposes 250 to subview (clamped)

 ### Pass 2 - Reporting Own Size:
 After subview reports its size, the frame determines its own size.
 Missing boundaries are substituted with the subview's size.
 The proposed size is clamped by these boundaries and reported.

 Example: If only maxWidth: 250, and subview reports 100
 → Frame size becomes min(100, min(250, proposed))

 ## Parameter Combinations:

 1. **maxWidth only**:
    - Frame width = max(proposed, subview width), capped at maxWidth
    - Common use: .frame(maxWidth: .infinity) for full-width views

 2. **minWidth only**:
    - Frame width = max(minWidth, subview width)
    - Ensures minimum width, grows with content

 3. **minWidth + maxWidth**:
    - Frame width = clamp(proposed, between: minWidth...maxWidth)
    - Common use: .frame(minWidth: 0, maxWidth: .infinity) to accept proposed width

 4. **idealWidth**:
    - Used when nil is proposed (e.g., in HStack with default spacing)
    - Frame proposes idealWidth to subview and reports it as own width

 5. **Same applies for height parameters**

 ## Alignment Parameter:

 When frame is larger than subview, alignment controls subview position:
 - .center (default)
 - .leading, .trailing, .top, .bottom
 - .topLeading, .topTrailing, .bottomLeading, .bottomTrailing

 ## Real-World Use Cases:

 - Full-width buttons: .frame(maxWidth: .infinity)
 - Accept proposed: .frame(minWidth: 0, maxWidth: .infinity)
 - Minimum tappable area: .frame(minWidth: 44, minHeight: 44)
 - Fill container: .frame(maxWidth: .infinity, maxHeight: .infinity)
 */
