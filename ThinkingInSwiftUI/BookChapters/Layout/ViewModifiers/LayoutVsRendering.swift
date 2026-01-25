//
//  LayoutVsRendering.swift
//  ThinkingInSwiftUI
//
//  Understanding the difference between Layout and Rendering
//  Layout = space allocation in the view hierarchy
//  Rendering = what actually gets drawn on screen
//

import SwiftUI

struct LayoutVsRendering: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                sectionHeader("Layout vs Rendering")

                keyConceptSection

                sectionHeader("1. The Two-Phase System")

                twoPhasesExplanation

                sectionHeader("2. Layout Without Clipping")

                layoutWithoutClipping

                sectionHeader("3. Layout With Clipping")

                layoutWithClipping

                sectionHeader("4. Sibling Positioning")

                siblingPositioning

                sectionHeader("5. Interactive Demonstration")

                interactiveDemo

                sectionHeader("6. Real-World Analogy")

                realWorldAnalogy
            }
            .padding()
        }
    }

    // MARK: - Key Concept

    private var keyConceptSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("YES! You've got it exactly right!")
                .font(.headline)
                .foregroundColor(.green)

            VStack(alignment: .leading, spacing: 8) {
                Text("The Perfect Metaphor:")
                    .font(.headline)
                    .foregroundColor(.blue)

                HStack(spacing: 12) {
                    Text("📋")
                        .font(.title)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Layout = The Plan")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                        Text("Decides sizes and positions")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }

                HStack(spacing: 12) {
                    Text("🎨")
                        .font(.title)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Rendering = The Execution")
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                        Text("Can go off-plan! (overflow, bleeding, conflicts)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding()
            .background(Color.purple.opacity(0.1))
            .cornerRadius(8)

            Text("SwiftUI has TWO separate phases:")
                .fontWeight(.semibold)
                .padding(.top, 8)

            phaseCard(
                number: "1",
                title: "Layout Phase",
                description: "Determines how much SPACE each view occupies and where it's positioned",
                color: .blue,
                details: [
                    "Measures view sizes",
                    "Positions views in the hierarchy",
                    "Allocates space",
                    "This NEVER changes with .clipped()"
                ]
            )

            phaseCard(
                number: "2",
                title: "Rendering Phase",
                description: "Actually DRAWS the content on screen (pixels)",
                color: .orange,
                details: [
                    "Draws shapes, text, images",
                    "Applies colors and effects",
                    "Can overflow beyond layout bounds",
                    "This is what .clipped() affects"
                ]
            )

            VStack(alignment: .leading, spacing: 8) {
                Text("The Key Insight:")
                    .fontWeight(.semibold)
                    .padding(.top, 8)

                Text(".clipped() creates a RENDERING MASK that prevents drawing outside the frame, but:")
                    .font(.subheadline)
                    .foregroundColor(.orange)

                VStack(alignment: .leading, spacing: 4) {
                    Text("• The LAYOUT SPACE remains unchanged")
                    Text("• The RENDERING SIZE remains unchanged")
                    Text("• Only what's VISIBLE changes (clipped at boundary)")
                }
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, 4)

                Text("Example: 150×150 circle in 100×60 frame with .clipped()")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.top, 4)

                VStack(alignment: .leading, spacing: 2) {
                    Text("• Layout: 100×60 (frame size)")
                    Text("• Rendering: 150×150 (circle still draws at full size)")
                    Text("• Visible: Only the 100×60 portion (masked!)")
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }

    // MARK: - Two Phases

    private var twoPhasesExplanation: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Phase 1: Layout (Space Allocation)",
                description: "SwiftUI determines sizes and positions",
                code: ""
            ) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Example: .frame(width: 100)")
                        .fontWeight(.semibold)

                    VStack(alignment: .leading, spacing: 6) {
                        layoutPhaseStep("1", "Parent proposes size to view")
                        layoutPhaseStep("2", "View calculates its size (100pt wide)")
                        layoutPhaseStep("3", "View reports size back to parent")
                        layoutPhaseStep("4", "Parent allocates 100pt of space")
                        layoutPhaseStep("5", "Sibling views positioned accordingly")
                    }
                    .font(.caption)

                    Rectangle()
                        .fill(Color.blue.opacity(0.2))
                        .frame(width: 100, height: 50)
                        .overlay(
                            Text("100pt of allocated space")
                                .font(.caption)
                        )

                    Text("✅ This space is RESERVED in the layout, regardless of content")
                        .font(.caption)
                        .foregroundColor(.green)
                }
            }

            exampleCard(
                title: "Phase 2: Rendering (Drawing)",
                description: "SwiftUI draws the visual content",
                code: ""
            ) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Content can overflow beyond layout bounds!")
                        .fontWeight(.semibold)

                    VStack(alignment: .leading, spacing: 6) {
                        renderPhaseStep("1", "SwiftUI draws content in the allocated space")
                        renderPhaseStep("2", "Content CAN extend beyond the bounds")
                        renderPhaseStep("3", "By default, no clipping mask applied")
                        renderPhaseStep("4", "Overflow is visually drawn on screen")
                        renderPhaseStep("5", "Layout space stays 100pt regardless!")
                    }
                    .font(.caption)

                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color.blue.opacity(0.2))
                            .frame(width: 100, height: 50)

                        Text("Very long content that extends beyond 100pt boundary")
                            .font(.caption)
                            .background(Color.red.opacity(0.3))
                    }

                    Text("⚠️ Visual overflow, but layout is still 100pt!")
                        .font(.caption)
                        .foregroundColor(.orange)
                }
            }
        }
    }

    // MARK: - Without Clipping

    private var layoutWithoutClipping: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Without .clipped() - Rendering Can Overflow",
                description: "Content draws beyond layout bounds",
                code: ".frame(width: 100)"
            ) {
                VStack(spacing: 16) {
                    // Visual demonstration
                    HStack(spacing: 0) {
                        // The frame - WITHOUT clipping
                        ZStack {
                            // Rendered content (will overflow)
                            Circle()
                                .fill(Color.red.opacity(0.3))
                                .frame(width: 150, height: 150)

                            // Layout boundary visualization
                            Rectangle()
                                .stroke(Color.blue, lineWidth: 2)
                                .frame(width: 100, height: 60)
                        }
                        .frame(width: 100, height: 60)
                        // NO .clipped() here - circle overflows!

                        // Next sibling view
                        Text("Next View")
                            .font(.caption)
                            .padding(8)
                            .background(Color.green.opacity(0.3))
                            .border(Color.green, width: 2)
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        legendItem(color: .blue, text: "Blue border = Layout space (100×60)")
                        legendItem(color: .red, text: "Red circle = Rendered content (150×150, overflows!)")
                        legendItem(color: .green, text: "Green view = Next sibling (positioned at 100pt)")
                    }
                    .font(.caption)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("What happens:")
                            .fontWeight(.semibold)

                        Text("• ZStack with 150×150 circle inside")
                        Text("• .frame(width: 100, height: 60) constrains layout to 100×60")
                        Text("• Circle still renders at 150×150 (overflows!)")
                        Text("• Sibling: Green view positioned at 100pt mark")
                        Text("• Result: Layout = 100×60, Rendering = 150×150")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Layout Space vs Visual Rendering",
                description: "They can be different!",
                code: ""
            ) {
                VStack(spacing: 12) {
                    // Show the concept
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Layout Space (what other views see):")
                            .font(.caption)
                            .fontWeight(.semibold)

                        Rectangle()
                            .fill(Color.blue.opacity(0.2))
                            .frame(width: 100, height: 40)
                            .overlay(
                                Text("100pt")
                                    .font(.caption)
                            )
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Visual Rendering (what you see):")
                            .font(.caption)
                            .fontWeight(.semibold)

                        Circle()
                            .fill(Color.red.opacity(0.3))
                            .frame(width: 150, height: 150)
                    }

                    Text("These are TWO DIFFERENT things!\nLayout = 100pt, Rendering = 150pt (overflows!)")
                        .font(.caption)
                        .foregroundColor(.orange)
                        .multilineTextAlignment(.center)
                        .padding(.top, 8)
                }
            }
        }
    }

    // MARK: - With Clipping

    private var layoutWithClipping: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "With .clipped() - Rendering Masked",
                description: "Content drawing is clipped at layout bounds",
                code: ".frame(width: 100).clipped()"
            ) {
                VStack(spacing: 16) {
                    // Visual demonstration
                    HStack(spacing: 0) {
                        // The frame - WITH clipping
                        ZStack {
                            // Rendered content (will be clipped)
                            Circle()
                                .fill(Color.red.opacity(0.3))
                                .frame(width: 150, height: 150)

                            // Layout boundary visualization
                            Rectangle()
                                .stroke(Color.blue, lineWidth: 2)
                                .frame(width: 100, height: 60)
                        }
                        .frame(width: 100, height: 60)
                        .clipped()  // Clips circle at 100×60 boundary!

                        // Next sibling view
                        Text("Next View")
                            .font(.caption)
                            .padding(8)
                            .background(Color.green.opacity(0.3))
                            .border(Color.green, width: 2)
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        legendItem(color: .blue, text: "Blue border = Layout space (100×60)")
                        legendItem(color: .red, text: "Red circle = Rendered content (CLIPPED at boundary!)")
                        legendItem(color: .green, text: "Green view = Next sibling (still at 100pt)")
                    }
                    .font(.caption)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("What happens:")
                            .fontWeight(.semibold)

                        Text("• ZStack with 150×150 circle inside")
                        Text("• .frame(width: 100, height: 60) constrains layout to 100×60")
                        Text("• .clipped() creates a clipping mask at 100×60 boundary")
                        Text("• Circle STILL renders at 150×150, but only visible within 100×60")
                        Text("• Sibling: Green view STILL positioned at 100pt")
                        Text("• Result: Layout = 100×60, Rendering = 150×150 (MASKED to show only 100×60!)")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Why .frame() AFTER ZStack?",
                description: "Critical: Order matters for overflow to happen",
                code: ""
            ) {
                VStack(alignment: .leading, spacing: 12) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Key Insight:")
                            .fontWeight(.semibold)
                            .foregroundColor(.orange)

                        Text("ZStack naturally expands to fit all children. To create overflow:")
                            .font(.caption)

                        Text("1️⃣ Put large content (150×150 circle) in ZStack")
                            .font(.caption)
                        Text("2️⃣ Apply .frame(width: 100, height: 60) to ZStack")
                            .font(.caption)
                        Text("3️⃣ ZStack's layout becomes 100×60")
                            .font(.caption)
                        Text("4️⃣ Circle still renders at 150×150 (overflows!)")
                            .font(.caption)
                        Text("5️⃣ Apply .clipped() to crop at boundary")
                            .font(.caption)
                    }
                    .padding()
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(8)

                    Divider()

                    Text("Without .clipped():")
                        .fontWeight(.semibold)

                    HStack(spacing: 4) {
                        Text("Layout:")
                        Rectangle().fill(Color.blue.opacity(0.3)).frame(width: 80, height: 20)
                        Text("→")
                        Text("Rendering:")
                        Rectangle().fill(Color.red.opacity(0.3)).frame(width: 150, height: 20)
                    }
                    .font(.caption)

                    Divider()

                    Text("With .clipped():")
                        .fontWeight(.semibold)

                    HStack(spacing: 4) {
                        Text("Layout:")
                        Rectangle().fill(Color.blue.opacity(0.3)).frame(width: 80, height: 20)
                        Text("→")
                        Text("Rendering:")
                        ZStack {
                            Rectangle().fill(Color.red.opacity(0.3)).frame(width: 150, height: 20)
                            Rectangle().stroke(Color.orange, lineWidth: 2).frame(width: 80, height: 20)
                        }
                        .frame(width: 80, height: 20)
                        .clipped()
                    }
                    .font(.caption)

                    Text("Orange box = clipping mask (prevents rendering outside)")
                        .font(.caption)
                        .foregroundColor(.orange)
                }
            }
        }
    }

    // MARK: - Sibling Positioning

    private var siblingPositioning: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Proof: Layout is Unchanged",
                description: "Sibling views positioned identically with or without .clipped()",
                code: ""
            ) {
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("WITHOUT .clipped():")
                            .font(.caption)
                            .fontWeight(.semibold)

                        HStack(spacing: 0) {
                            Text("Overflow Text Content Here")
                                .font(.caption)
                                .frame(width: 80)
                                .background(Color.red.opacity(0.3))
                                .border(Color.red, width: 2)

                            Rectangle()
                                .fill(Color.blue)
                                .frame(width: 60, height: 40)
                                .overlay(Text("Sibling").font(.caption).foregroundColor(.white))
                        }

                        Text("Blue sibling starts at 80pt mark →")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("WITH .clipped():")
                            .font(.caption)
                            .fontWeight(.semibold)

                        HStack(spacing: 0) {
                            Text("Overflow Text Content Here")
                                .font(.caption)
                                .frame(width: 80)
                                .background(Color.red.opacity(0.3))
                                .border(Color.red, width: 2)
                                .clipped()

                            Rectangle()
                                .fill(Color.blue)
                                .frame(width: 60, height: 40)
                                .overlay(Text("Sibling").font(.caption).foregroundColor(.white))
                        }

                        Text("Blue sibling STILL starts at 80pt mark →")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    Text("✅ Sibling is in the EXACT same position!\nLayout space is unchanged, only rendering is clipped.")
                        .font(.caption)
                        .foregroundColor(.green)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(8)
                }
            }

            exampleCard(
                title: "Why This Matters",
                description: "Understanding the separation is crucial",
                code: ""
            ) {
                VStack(alignment: .leading, spacing: 8) {
                    importanceItem("Layout determines SPACING and POSITIONING")
                    importanceItem("Rendering determines VISUAL APPEARANCE")
                    importanceItem(".clipped() is a RENDERING-ONLY modifier")
                    importanceItem("Other views don't \"see\" the clipping")
                    importanceItem("Only affects what gets drawn, not space")
                }
            }
        }
    }

    // MARK: - Interactive Demo

    private var interactiveDemo: some View {
        VStack(spacing: 16) {
            Text("Interactive Demonstration")
                .font(.headline)

            ClippingToggleDemo()
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }

    // MARK: - Real World Analogy

    private var realWorldAnalogy: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Real-World Analogy: The Picture Frame")
                .font(.headline)

            analogyCard(
                title: "Layout = The Frame on the Wall",
                description: "The physical space the frame occupies",
                details: [
                    "Takes up 100cm × 100cm on your wall",
                    "This space is reserved - nothing else can go there",
                    "Other frames positioned based on this space",
                    "This NEVER changes"
                ],
                color: .blue
            )

            analogyCard(
                title: "Rendering = The Painting Inside",
                description: "What actually gets displayed",
                details: [
                    "The painting might be larger than 100cm × 100cm",
                    "Without clipping: painting extends beyond frame edges",
                    "With clipping: mat/glass cuts off overflow",
                    "But frame STILL occupies same wall space!"
                ],
                color: .orange
            )

            Text("The wall space (layout) doesn't change just because you trim the painting (rendering)!")
                .font(.subheadline)
                .foregroundColor(.green)
                .padding()
                .background(Color.green.opacity(0.1))
                .cornerRadius(8)
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
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

    private func phaseCard(number: String, title: String, description: String, color: Color, details: [String]) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Text(number)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(color)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(color)

                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                ForEach(details, id: \.self) { detail in
                    HStack(alignment: .top, spacing: 4) {
                        Text("•")
                        Text(detail)
                    }
                    .font(.caption)
                }
            }
        }
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(8)
    }

    private func layoutPhaseStep(_ number: String, _ text: String) -> some View {
        HStack(alignment: .top, spacing: 6) {
            Text("\(number).")
                .fontWeight(.semibold)
                .foregroundColor(.blue)
            Text(text)
        }
    }

    private func renderPhaseStep(_ number: String, _ text: String) -> some View {
        HStack(alignment: .top, spacing: 6) {
            Text("\(number).")
                .fontWeight(.semibold)
                .foregroundColor(.orange)
            Text(text)
        }
    }

    private func legendItem(color: Color, text: String) -> some View {
        HStack(spacing: 6) {
            Circle()
                .fill(color)
                .frame(width: 10, height: 10)
            Text(text)
        }
    }

    private func importanceItem(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 6) {
            Text("→")
                .foregroundColor(.blue)
            Text(text)
                .font(.caption)
        }
    }

    private func analogyCard(title: String, description: String, details: [String], color: Color) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .fontWeight(.semibold)
                .foregroundColor(color)

            Text(description)
                .font(.caption)
                .foregroundColor(.secondary)

            ForEach(details, id: \.self) { detail in
                HStack(alignment: .top, spacing: 4) {
                    Text("•")
                    Text(detail)
                }
                .font(.caption)
            }
        }
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(8)
    }
}

// MARK: - Interactive Toggle Demo

struct ClippingToggleDemo: View {
    @State private var useClipping = false

    var body: some View {
        VStack(spacing: 16) {
            Toggle("Use .clipped()", isOn: $useClipping)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)

            VStack(spacing: 12) {
                Text("Layout Space (always the same):")
                    .font(.caption)
                    .fontWeight(.semibold)

                Rectangle()
                    .fill(Color.blue.opacity(0.2))
                    .frame(width: 120, height: 60)
                    .overlay(
                        Text("120pt × 60pt")
                            .font(.caption)
                    )
                    .border(Color.blue, width: 2)

                Text("Visual Rendering:")
                    .font(.caption)
                    .fontWeight(.semibold)

                Group {
                    if useClipping {
                        // WITH clipping - circle gets cropped
                        ZStack {
                            Circle()
                                .fill(Color.red.opacity(0.3))
                                .frame(width: 180, height: 180)

                            Rectangle()
                                .stroke(Color.blue, lineWidth: 2)
                                .frame(width: 120, height: 60)
                        }
                        .frame(width: 120, height: 60)
                        .clipped()
                    } else {
                        // WITHOUT clipping - circle overflows
                        ZStack {
                            Circle()
                                .fill(Color.red.opacity(0.3))
                                .frame(width: 180, height: 180)

                            Rectangle()
                                .stroke(Color.blue, lineWidth: 2)
                                .frame(width: 120, height: 60)
                        }
                        .frame(width: 120, height: 60)
                    }
                }

                HStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Layout:")
                            .font(.caption)
                            .fontWeight(.semibold)
                        Text("120pt × 60pt")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Rendering:")
                            .font(.caption)
                            .fontWeight(.semibold)
                        Text(useClipping ? "180pt circle (masked)" : "180pt circle (overflows!)")
                            .font(.caption)
                            .foregroundColor(useClipping ? .green : .orange)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            }

            VStack(spacing: 8) {
                Text("Notice: Layout space is ALWAYS 120×60!")
                    .font(.caption)
                    .foregroundColor(.green)
                    .multilineTextAlignment(.center)

                Text("The circle is ALWAYS rendered at 180×180.\n.clipped() just creates a mask - it doesn't change the rendering size!")
                    .font(.caption)
                    .foregroundColor(.orange)
                    .multilineTextAlignment(.center)

                Text("The pattern: ZStack { Circle(180×180) + Border }.frame(120×60).clipped()")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    LayoutVsRendering()
}

/*
 LAYOUT VS RENDERING SUMMARY:

 ## The Perfect Metaphor:

 📋 Layout = The Plan
    - Decides sizes and positions
    - Creates the "contract" of space allocation

 🎨 Rendering = The Execution
    - Actually draws pixels
    - Can go off-plan! (overflow, bleeding, conflicts)

 ## The Two-Phase System:

 ### Phase 1: Layout (The Plan)
 - Determines SIZE and POSITION of views
 - Allocates SPACE in the view hierarchy
 - Other views positioned based on this space
 - This is what .frame() affects
 - Parent-child negotiate the "agreement"

 ### Phase 2: Rendering (The Execution)
 - Actually DRAWS content on screen
 - Can overflow beyond layout bounds
 - Can violate the "plan" from layout phase
 - This is what .clipped() affects
 - Where overflow, bleeding, and conflicts happen

 ## Key Insight:

 Layout and Rendering are SEPARATE!
 Layout is the plan, Rendering can go off-plan!

 Without .clipped():
 - Layout: 100pt of space allocated
 - Rendering: Content can draw beyond 100pt
 - Result: Visual overflow

 With .clipped():
 - Layout: STILL 100pt of space allocated
 - Rendering: Drawing MASKED at 100pt boundary
 - Result: Clean visual, SAME layout

 ## Your Question Answered:

 "Does this mean SwiftUI will prevent drawing any part of child that
 exceeds parent layout but the total layout will still be the same?"

 YES! Exactly right!

 - .clipped() creates a CLIPPING MASK for rendering
 - Content CANNOT draw outside the mask
 - But layout space is UNCHANGED
 - Sibling views positioned based on layout, not rendering

 ## Real-World Analogy:

 Picture frame on a wall:
 - Frame occupies 100cm space on wall (LAYOUT)
 - Painting inside might be larger (RENDERING)
 - Trim painting to fit frame (.clipped())
 - Frame STILL occupies same 100cm wall space!

 ## Bottom Line:

 📋 Layout = The Plan (space reservation, sizes, positions)
 🎨 Rendering = The Execution (visual appearance, can go off-plan!)
 ✂️ .clipped() = Rendering-only modifier (enforces the plan at render time)

 Parent-child relationships in layout phase decide sizes and positions,
 but rendering can behave differently when things go off-plan:
 - Overflow (content larger than layout bounds)
 - Conflicts (child demands more than parent offers)
 - Bleeding (backgrounds/shadows extending beyond)
 */
