//
//  FlexibleFramesConflicts.swift
//  ThinkingInSwiftUI
//
//  What happens when frame modifiers conflict?
//  Shows how SwiftUI resolves competing constraints and proposals
//

import SwiftUI

struct FlexibleFramesConflicts: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                sectionHeader("Frame Conflicts & Resolution")

                introSection

                sectionHeader("1. Fixed Child in Constrained Parent")

                fixedChildInParent

                sectionHeader("2. Multiple Frames on Same View")

                multipleFramesOnSameView

                sectionHeader("3. Nested Flexible Frames")

                nestedFlexibleFrames

                sectionHeader("4. Conflicting Min/Max Constraints")

                conflictingConstraints

                sectionHeader("5. Edge Cases: Infinity in Wrong Place")

                infinityEdgeCases

                sectionHeader("6. Child Demands vs Parent Proposals")

                childVsParentDemands

                sectionHeader("7. Overflow Scenarios")

                overflowScenarios

                sectionHeader("8. The Resolution Rules")

                resolutionRules
            }
            .padding()
        }
    }

    // MARK: - Introduction

    private var introSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Key Principle:")
                .font(.headline)

            Text("SwiftUI's layout system follows strict rules when frames conflict. Understanding these rules is crucial for predictable layouts.")
                .foregroundColor(.secondary)

            VStack(alignment: .leading, spacing: 8) {
                ruleItem("1", "Frames wrap views - each frame is a PARENT of the view it's applied to")
                ruleItem("2", "Inner frames receive proposals from outer frames")
                ruleItem("3", "Fixed frames (width: 100) IGNORE proposals - they always return their fixed size")
                ruleItem("4", "Views can report a size different from what was proposed")
                ruleItem("5", "Parents can't force children to be a specific size - only propose")
            }
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(12)
    }

    // MARK: - 1. Fixed Child in Constrained Parent

    private var fixedChildInParent: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Child Larger Than Parent Proposal",
                description: "Parent proposes 100pt width, child demands 200pt",
                hierarchy: "frame(width: 100) → frame(width: 200) → Text"
            ) {
                VStack(spacing: 10) {
                    Text("Hello World")
                        .background(Color.red)
                        .frame(width: 200)  // Child demands 200
                        .background(Color.orange.opacity(0.3))
                        .border(Color.orange, width: 2)
                        .frame(width: 100)  // Parent offers only 100
                        .background(Color.blue.opacity(0.3))
                        .border(Color.blue, width: 2)

                    Text("Result: Child overflows parent! Inner frame reports 200, outer frame also becomes 200.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Step-by-Step Flow",
                description: "How the 100 vs 200 conflict resolves",
                hierarchy: ""
            ) {
                VStack(alignment: .leading, spacing: 6) {
                    flowStep("1", "Outer frame receives proposal (e.g., 300pt)")
                    flowStep("2", "Outer frame is fixed width: 100, proposes 100 to inner")
                    flowStep("3", "Inner frame is fixed width: 200, proposes 200 to Text")
                    flowStep("4", "Text reports actual size (e.g., 80×17)")
                    flowStep("5", "Inner frame IGNORES text size, reports 200 (fixed)")
                    flowStep("6", "Outer frame IGNORES inner size, reports 100... WAIT!")
                    flowStep("7", "Actually, outer frame reports 200! WHY?")

                    Text("\n⚠️ The outer frame becomes 200 because its child reported 200. Fixed frames can't shrink their children, so the parent expands to accommodate.")
                        .font(.caption)
                        .foregroundColor(.orange)
                        .padding(.top, 4)
                }
                .font(.system(.caption, design: .monospaced))
            }

            exampleCard(
                title: "Child Smaller Than Parent Proposal",
                description: "Parent proposes 200pt width, child demands 100pt",
                hierarchy: "frame(width: 200) → frame(width: 100) → Text"
            ) {
                VStack(spacing: 10) {
                    Text("Hi")
                        .background(Color.red)
                        .frame(width: 100)  // Child demands 100
                        .background(Color.orange.opacity(0.3))
                        .border(Color.orange, width: 2)
                        .frame(width: 200)  // Parent offers 200
                        .background(Color.blue.opacity(0.3))
                        .border(Color.blue, width: 2)

                    Text("Result: Parent becomes 200 (its fixed size), child is 100 and centered within parent.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }

    // MARK: - 2. Multiple Frames on Same View

    private var multipleFramesOnSameView: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Two Fixed Widths - Order Matters!",
                description: "Each frame wraps the previous one",
                hierarchy: "frame(width: 200) wraps frame(width: 100)"
            ) {
                VStack(spacing: 16) {
                    VStack(spacing: 8) {
                        Text("Outer First")
                            .background(Color.red)
                            .frame(width: 100)
                            .background(Color.orange.opacity(0.3))
                            .border(Color.orange, width: 2)
                            .frame(width: 200)
                            .background(Color.blue.opacity(0.3))
                            .border(Color.blue, width: 2)

                        Text("100 first, then 200: Outer wins (200)")
                            .font(.caption)
                    }

                    VStack(spacing: 8) {
                        Text("Outer First")
                            .background(Color.red)
                            .frame(width: 200)
                            .background(Color.blue.opacity(0.3))
                            .border(Color.blue, width: 2)
                            .frame(width: 100)
                            .background(Color.orange.opacity(0.3))
                            .border(Color.orange, width: 2)

                        Text("200 first, then 100: But result is still 200! (child overflows)")
                            .font(.caption)
                    }
                }
            }

            exampleCard(
                title: "Fixed Then Flexible",
                description: "Flexible frame wraps fixed frame",
                hierarchy: "frame(maxWidth: .infinity) → frame(width: 150)"
            ) {
                VStack(spacing: 10) {
                    Text("Hello")
                        .background(Color.red)
                        .frame(width: 150)
                        .background(Color.orange.opacity(0.3))
                        .border(Color.orange, width: 2)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.3))
                        .border(Color.blue, width: 2)

                    Text("Inner is 150 (fixed), outer fills available space but child stays 150")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Flexible Then Fixed",
                description: "Fixed frame wraps flexible frame",
                hierarchy: "frame(width: 150) → frame(maxWidth: .infinity)"
            ) {
                VStack(spacing: 10) {
                    Text("Hello")
                        .background(Color.red)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.3))
                        .border(Color.blue, width: 2)
                        .frame(width: 150)
                        .background(Color.orange.opacity(0.3))
                        .border(Color.orange, width: 2)

                    Text("Outer is 150 (fixed), proposes 150 to inner, inner becomes 150")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }

    // MARK: - 3. Nested Flexible Frames

    private var nestedFlexibleFrames: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "maxWidth: .infinity Nested",
                description: "Multiple maxWidth: .infinity in a chain",
                hierarchy: "maxWidth: ∞ → maxWidth: ∞ → maxWidth: ∞"
            ) {
                VStack(spacing: 10) {
                    Text("Hello")
                        .background(Color.red)
                        .frame(maxWidth: .infinity)
                        .background(Color.purple.opacity(0.3))
                        .border(Color.purple, width: 2)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.3))
                        .border(Color.blue, width: 2)
                        .frame(maxWidth: .infinity)
                        .background(Color.green.opacity(0.3))
                        .border(Color.green, width: 2)

                    Text("All frames fill available width - they all have the same width!")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Constraining maxWidth in Chain",
                description: "Each frame can constrain the next",
                hierarchy: "maxWidth: ∞ → maxWidth: 200 → maxWidth: ∞"
            ) {
                VStack(spacing: 10) {
                    Text("Constrained")
                        .background(Color.red)
                        .frame(maxWidth: .infinity)
                        .background(Color.purple.opacity(0.3))
                        .border(Color.purple, width: 2)
                        .frame(maxWidth: 200)  // Middle frame constrains!
                        .background(Color.orange.opacity(0.3))
                        .border(Color.orange, width: 2)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.3))
                        .border(Color.blue, width: 2)

                    Text("Middle frame (200) limits inner frame. Outer frame expands to fill, but displays 200.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "minWidth Conflicts",
                description: "Multiple minWidth constraints",
                hierarchy: "minWidth: 50 → minWidth: 150 → Text(30pt wide)"
            ) {
                VStack(spacing: 10) {
                    Text("Hi")
                        .background(Color.red)
                        .frame(minWidth: 150)  // Inner demands 150 minimum
                        .background(Color.orange.opacity(0.3))
                        .border(Color.orange, width: 2)
                        .frame(minWidth: 50)   // Outer demands only 50
                        .background(Color.blue.opacity(0.3))
                        .border(Color.blue, width: 2)

                    Text("Inner frame reports 150, outer frame must accommodate it. Result: 150")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }

    // MARK: - 4. Conflicting Min/Max Constraints

    private var conflictingConstraints: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Impossible Constraints: min > max",
                description: "What if minWidth > maxWidth?",
                hierarchy: "frame(minWidth: 200, maxWidth: 100)"
            ) {
                VStack(spacing: 10) {
                    Text("Impossible!")
                        .background(Color.red)
                        .frame(minWidth: 200, maxWidth: 100)
                        .background(Color.orange.opacity(0.3))
                        .border(Color.orange, width: 2)

                    Text("⚠️ minWidth wins! SwiftUI respects minimum over maximum. Result: 200")
                        .font(.caption)
                        .foregroundColor(.orange)
                }
            }

            exampleCard(
                title: "Nested Impossible Constraints",
                description: "Parent max < Child min",
                hierarchy: "maxWidth: 100 → minWidth: 200"
            ) {
                VStack(spacing: 10) {
                    Text("Conflict")
                        .background(Color.red)
                        .frame(minWidth: 200)
                        .background(Color.orange.opacity(0.3))
                        .border(Color.orange, width: 2)
                        .frame(maxWidth: 100)
                        .background(Color.blue.opacity(0.3))
                        .border(Color.blue, width: 2)

                    Text("Child reports 200 (its minimum). Parent can't constrain it. Result: 200")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Parent min > Child max",
                description: "Parent demands more than child allows",
                hierarchy: "minWidth: 200 → maxWidth: 100"
            ) {
                VStack(spacing: 10) {
                    Text("Conflict")
                        .background(Color.red)
                        .frame(maxWidth: 100)
                        .background(Color.orange.opacity(0.3))
                        .border(Color.orange, width: 2)
                        .frame(minWidth: 200)
                        .background(Color.blue.opacity(0.3))
                        .border(Color.blue, width: 2)

                    Text("Child reports 100 (its maximum). Parent must expand to 200 (its minimum). Result: 200")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }

    // MARK: - 5. Edge Cases: Infinity in Wrong Place

    private var infinityEdgeCases: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "⚠️ minWidth: .infinity - CRASHES OR UNPREDICTABLE!",
                description: "What happens when minimum is infinity? Undefined behavior - crashes or messed up layouts!",
                hierarchy: "frame(minWidth: .infinity) ← DON'T DO THIS"
            ) {
                VStack(spacing: 10) {
                    Text("❌ DANGEROUS EXAMPLE (Not Runnable)")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)

                    Text("Code that causes problems:")
                        .font(.caption)
                        .fontWeight(.semibold)

                    Text(".frame(minWidth: .infinity)")
                        .font(.system(.caption, design: .monospaced))
                        .padding(8)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(4)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Why it's dangerous:")
                            .font(.caption)
                            .fontWeight(.semibold)

                        Text("• SwiftUI tries to satisfy 'minimum = infinity'")
                        Text("• Layout calculations may produce NaN (Not a Number)")
                        Text("• Sometimes crashes: 'CALayer position contains NaN'")
                        Text("• Sometimes results in unpredictable/messed up layouts")
                        Text("• Behavior depends on context and SwiftUI version")
                        Text("• Same applies to minHeight: .infinity")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "minWidth: .infinity vs maxWidth: .infinity",
                description: "Theoretical comparison (minWidth creates undefined behavior)",
                hierarchy: "Comparison"
            ) {
                VStack(alignment: .leading, spacing: 12) {
                    VStack(spacing: 8) {
                        Text("✅ maxWidth: .infinity (SAFE)")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.green)

                        Text("A")
                            .background(Color.red)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.3))
                            .border(Color.blue, width: 2)

                        Text("Works perfectly - fills available width")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    Divider()

                    VStack(spacing: 8) {
                        Text("❌ minWidth: .infinity (UNPREDICTABLE)")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.red)

                        Text("Would crash or produce messed up layout")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("// .frame(minWidth: .infinity)")
                            .font(.system(.caption, design: .monospaced))
                            .foregroundColor(.secondary)
                    }

                    Text("Semantic difference:\n• maxWidth: 'I can be AT MOST infinite' → fills space ✅\n• minWidth: 'I NEED AT LEAST infinite' → impossible, undefined behavior ❌")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.top, 4)
                }
            }

            exampleCard(
                title: "Both min AND max as infinity",
                description: "Also dangerous because of minWidth: .infinity",
                hierarchy: "frame(minWidth: .infinity, maxWidth: .infinity) ← UNPREDICTABLE"
            ) {
                VStack(spacing: 10) {
                    Text("❌ DANGEROUS EXAMPLE (Not Runnable)")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)

                    Text(".frame(minWidth: .infinity, maxWidth: .infinity)")
                        .font(.system(.caption, design: .monospaced))
                        .padding(8)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(4)

                    Text("The minWidth: .infinity part causes undefined behavior (crashes or messed up layout). Use only maxWidth: .infinity instead.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "✅ idealWidth: .infinity (SAFE)",
                description: "This one works! Used when nil is proposed",
                hierarchy: "frame(idealWidth: .infinity)"
            ) {
                VStack(spacing: 10) {
                    HStack {
                        Color.clear.frame(width: 0)
                        Text("Ideal ∞")
                            .background(Color.red)
                            .frame(idealWidth: .infinity)
                            .background(Color.cyan.opacity(0.3))
                            .border(Color.cyan, width: 2)
                    }

                    Text("✅ Works! When nil is proposed (like in HStack), uses infinity → takes all space")
                        .font(.caption)
                        .foregroundColor(.green)
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Summary - What's Safe?")
                    .font(.headline)

                HStack(alignment: .top, spacing: 4) {
                    Text("✅")
                    Text("SAFE: maxWidth: .infinity, maxHeight: .infinity")
                }
                .font(.caption)

                HStack(alignment: .top, spacing: 4) {
                    Text("✅")
                    Text("SAFE: idealWidth: .infinity, idealHeight: .infinity")
                }
                .font(.caption)

                HStack(alignment: .top, spacing: 4) {
                    Text("❌")
                    Text("DANGEROUS: minWidth: .infinity, minHeight: .infinity")
                }
                .font(.caption)

                HStack(alignment: .top, spacing: 4) {
                    Text("❌")
                    Text("DANGEROUS: Any combination with min = infinity")
                }
                .font(.caption)

                Text("\nWhy? Setting a minimum to infinity means \"I need AT LEAST infinite space,\" which is impossible to satisfy. This creates undefined behavior - sometimes NaN values that crash CoreAnimation, sometimes just produces unpredictable/messed up layouts.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top, 4)
            }
            .padding()
            .background(Color.yellow.opacity(0.1))
            .cornerRadius(8)
        }
    }

    // MARK: - 6. Child Demands vs Parent Proposals

    private var childVsParentDemands: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Fixed Child Ignores Parent Proposal",
                description: "Parent proposes 50, child is fixed at 300",
                hierarchy: "Container(50) → frame(width: 300)"
            ) {
                VStack(spacing: 10) {
                    HStack {
                        Color.clear.frame(width: 50)
                            .border(Color.gray.opacity(0.5), width: 1)

                        Text("Proposed 50pt")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    Text("But child is 300pt")
                        .background(Color.red)
                        .frame(width: 300)
                        .background(Color.orange.opacity(0.3))
                        .border(Color.orange, width: 2)

                    Text("Child doesn't care about proposal - it's 300pt regardless!")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Flexible Child Respects Proposal",
                description: "Parent proposes 100, child accepts with maxWidth: .infinity",
                hierarchy: "Container(100) → frame(maxWidth: ∞)"
            ) {
                VStack(spacing: 10) {
                    Text("Flexible")
                        .background(Color.red)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.3))
                        .border(Color.blue, width: 2)
                        .frame(width: 100)

                    Text("maxWidth: .infinity respects parent's proposal. Result: 100")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "The Greedy Child",
                description: "Child wants more than parent offers",
                hierarchy: "maxWidth: 150 → minWidth: 300"
            ) {
                VStack(spacing: 10) {
                    Text("Greedy")
                        .background(Color.red)
                        .frame(minWidth: 300)
                        .background(Color.orange.opacity(0.3))
                        .border(Color.orange, width: 2)
                        .frame(maxWidth: 150)
                        .background(Color.blue.opacity(0.3))
                        .border(Color.blue, width: 2)

                    Text("Parent tries to limit to 150, child demands 300. Child wins: 300")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }

    // MARK: - 7. Overflow Scenarios

    private var overflowScenarios: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Text Overflow in Fixed Frame",
                description: "Text is wider than its fixed frame",
                hierarchy: "frame(width: 50) → Text(150pt natural width)"
            ) {
                VStack(spacing: 10) {
                    Text("Very Long Text Here That Overflows")
                        .background(Color.red)
                        .frame(width: 100)
                        .background(Color.blue.opacity(0.3))
                        .border(Color.blue, width: 2)

                    Text("Text gets truncated with '...' to fit the frame")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Shape Overflow in Fixed Frame",
                description: "Shape is larger than its fixed frame",
                hierarchy: "frame(width: 100, height: 100) → Circle()"
            ) {
                VStack(spacing: 10) {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 150, height: 150)
                        .background(Color.orange.opacity(0.3))
                        .border(Color.orange, width: 2)
                        .frame(width: 100, height: 100)
                        .background(Color.blue.opacity(0.3))
                        .border(Color.blue, width: 2)
                        .clipped()

                    Text("Shape gets clipped by outer frame")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Preventing Overflow with clipped()",
                description: "Use .clipped() to prevent visual overflow",
                hierarchy: "frame(width: 100).clipped()"
            ) {
                VStack(spacing: 10) {
                    HStack(spacing: 20) {
                        VStack {
                            Text("Overflow")
                                .frame(width: 200)
                                .background(Color.red)
                                .frame(width: 100)
                                .background(Color.blue.opacity(0.3))
                                .border(Color.blue, width: 2)

                            Text("Without clipped")
                                .font(.caption)
                        }

                        VStack {
                            Text("Overflow")
                                .frame(width: 200)
                                .background(Color.red)
                                .frame(width: 100)
                                .background(Color.blue.opacity(0.3))
                                .border(Color.blue, width: 2)
                                .clipped()

                            Text("With clipped")
                                .font(.caption)
                        }
                    }
                }
            }
        }
    }

    // MARK: - 8. Resolution Rules

    private var resolutionRules: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("SwiftUI's Conflict Resolution Rules:")
                .font(.headline)

            ruleCard(
                number: "1",
                title: "Fixed Frames Always Win",
                description: "A fixed frame (width: 100) ignores proposals and always reports its fixed size",
                color: .blue
            )

            ruleCard(
                number: "2",
                title: "Children Can Overflow Parents",
                description: "If a child reports a larger size than the parent's constraint, the child overflows. The parent often expands to accommodate.",
                color: .orange
            )

            ruleCard(
                number: "3",
                title: "Minimum Over Maximum",
                description: "If minWidth > maxWidth, minWidth wins. SwiftUI respects minimums over maximums.",
                color: .red
            )

            ruleCard(
                number: "4",
                title: "Inner Frames Receive Proposals from Outer",
                description: "Frames form a chain. Each outer frame proposes to the next inner frame.",
                color: .green
            )

            ruleCard(
                number: "5",
                title: "Reported Size Flows Outward",
                description: "Size flows from innermost view outward. Each frame can modify or accept the size reported by its child.",
                color: .purple
            )

            ruleCard(
                number: "6",
                title: "Flexible Frames Adapt",
                description: "Flexible frames (maxWidth: .infinity) respect proposals and adapt to available space.",
                color: .cyan
            )

            ruleCard(
                number: "7",
                title: "Order Matters!",
                description: ".frame(width: 100).frame(width: 200) is different from .frame(width: 200).frame(width: 100)",
                color: .pink
            )
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
        hierarchy: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)

            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary)

            if !hierarchy.isEmpty {
                Text("Hierarchy: \(hierarchy)")
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

    private func ruleItem(_ number: String, _ text: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Text("\(number).")
                .fontWeight(.semibold)
                .frame(width: 20, alignment: .leading)
            Text(text)
        }
        .font(.caption)
    }

    private func flowStep(_ number: String, _ text: String) -> some View {
        HStack(alignment: .top, spacing: 6) {
            Text("\(number).")
                .fontWeight(.semibold)
                .frame(width: 20, alignment: .leading)
            Text(text)
        }
    }

    private func ruleCard(number: String, title: String, description: String, color: Color) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Text(number)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(color)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)

                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(8)
    }
}

// MARK: - Interactive Conflict Simulator

struct ConflictSimulator: View {
    @State private var outerWidth: CGFloat = 150
    @State private var innerWidth: CGFloat = 200
    @State private var useOuterFixed = true
    @State private var useInnerFixed = true

    var body: some View {
        VStack(spacing: 20) {
            Text("Frame Conflict Simulator")
                .font(.title2)
                .fontWeight(.bold)

            VStack(alignment: .leading, spacing: 16) {
                Text("Outer Frame:")
                    .font(.headline)

                Toggle("Fixed Width", isOn: $useOuterFixed)

                HStack {
                    Text("Width: \(Int(outerWidth))")
                        .frame(width: 80)
                    Slider(value: $outerWidth, in: 50...300)
                }

                Divider()

                Text("Inner Frame:")
                    .font(.headline)

                Toggle("Fixed Width", isOn: $useInnerFixed)

                HStack {
                    Text("Width: \(Int(innerWidth))")
                        .frame(width: 80)
                    Slider(value: $innerWidth, in: 50...300)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)

            VStack(spacing: 8) {
                Text("Result:")
                    .font(.headline)

                Text("Hello World")
                    .background(Color.red)
                    .modifier(ConditionalFrame(width: innerWidth, isFixed: useInnerFixed, color: .orange))
                    .modifier(ConditionalFrame(width: outerWidth, isFixed: useOuterFixed, color: .blue))

                Text(currentCode)
                    .font(.system(.caption, design: .monospaced))
                    .padding(8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(4)

                predictionText
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding()
                    .background(Color.yellow.opacity(0.1))
                    .cornerRadius(8)
            }

            Spacer()
        }
        .padding()
    }

    private var currentCode: String {
        let innerCode = useInnerFixed ? "frame(width: \(Int(innerWidth)))" : "frame(maxWidth: \(Int(innerWidth)))"
        let outerCode = useOuterFixed ? "frame(width: \(Int(outerWidth)))" : "frame(maxWidth: \(Int(outerWidth)))"
        return ".\(innerCode).\(outerCode)"
    }

    private var predictionText: Text {
        if useOuterFixed && useInnerFixed {
            if innerWidth > outerWidth {
                return Text("Prediction: Inner (\(Int(innerWidth))) overflows outer. Result: \(Int(innerWidth))")
            } else {
                return Text("Prediction: Outer is \(Int(outerWidth)), contains inner \(Int(innerWidth)). Result: \(Int(outerWidth))")
            }
        } else if useOuterFixed && !useInnerFixed {
            return Text("Prediction: Outer fixes at \(Int(outerWidth)), inner adapts. Result: \(Int(outerWidth))")
        } else if !useOuterFixed && useInnerFixed {
            return Text("Prediction: Inner fixes at \(Int(innerWidth)), outer can't constrain it. Result: ~\(Int(innerWidth))")
        } else {
            return Text("Prediction: Both flexible - depends on container's proposal")
        }
    }
}

struct ConditionalFrame: ViewModifier {
    let width: CGFloat
    let isFixed: Bool
    let color: Color

    func body(content: Content) -> some View {
        if isFixed {
            content
                .frame(width: width)
                .background(color.opacity(0.3))
                .border(color, width: 2)
        } else {
            content
                .frame(maxWidth: width)
                .background(color.opacity(0.3))
                .border(color, width: 2)
        }
    }
}

// MARK: - Preview

#Preview("Conflicts") {
    FlexibleFramesConflicts()
}

#Preview("Simulator") {
    ConflictSimulator()
}

/*
 FRAME CONFLICT RESOLUTION SUMMARY:

 ## The 7 Rules:

 1. **Fixed Frames Always Win**
    - .frame(width: 100) ignores all proposals
    - Always reports exactly 100, regardless of container or child

 2. **Children Can Overflow Parents**
    - If child reports 200 and parent wants 100, child wins
    - Parent often expands to accommodate the child
    - Visual overflow can happen (use .clipped() to prevent)

 3. **Minimum Over Maximum**
    - If minWidth: 200, maxWidth: 100 → result is 200
    - SwiftUI prioritizes minimum constraints

 4. **Inner Frames Receive Proposals from Outer**
    - .frame(width: 200).frame(width: 100)
    - Outer frame (100) proposes 100 to inner frame (200)
    - But inner frame is fixed, reports 200 anyway

 5. **Reported Size Flows Outward**
    - Layout is a two-way process:
      • Proposals flow inward (parent → child)
      • Sizes flow outward (child → parent)

 6. **Flexible Frames Adapt**
    - .frame(maxWidth: .infinity) respects proposals
    - Takes max(proposed, child size)

 7. **Order Matters!**
    - Each .frame() wraps the previous view
    - .frame(A).frame(B) ≠ .frame(B).frame(A)

 ## Common Conflict Scenarios:

 ### Scenario 1: Nested Fixed Frames
 ```
 .frame(width: 200)
 .frame(width: 100)
 ```
 Result: Inner demands 200, outer must accommodate → 200

 ### Scenario 2: Fixed in Flexible
 ```
 .frame(width: 100)
 .frame(maxWidth: .infinity)
 ```
 Result: Inner is 100, outer fills available but displays 100

 ### Scenario 3: Impossible Constraints
 ```
 .frame(minWidth: 200, maxWidth: 100)
 ```
 Result: minWidth wins → 200

 ### Scenario 4: Greedy Child
 ```
 .frame(minWidth: 300)
 .frame(maxWidth: 150)
 ```
 Result: Child demands 300, parent can't constrain → 300

 ## Key Insight:

 SwiftUI's layout is COOPERATIVE, not AUTHORITATIVE:
 - Parents can only PROPOSE sizes, not FORCE them
 - Children report their needs
 - Conflicts resolved by letting children "overflow" or parents "expand"
 - Fixed frames are inflexible - they always report their fixed size
 */
