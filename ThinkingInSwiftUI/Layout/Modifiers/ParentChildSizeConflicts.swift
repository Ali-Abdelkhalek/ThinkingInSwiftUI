//
//  ParentChildSizeConflicts.swift
//  ThinkingInSwiftUI
//
//  What happens when child size > parent size?
//  Does the child overflow? Does the parent expand?
//  The answer: IT DEPENDS on the parent type!
//

import SwiftUI

struct ParentChildSizeConflicts: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                sectionHeader("Parent vs Child Size Conflicts")

                keyInsightSection

                sectionHeader("1. Fixed Frame Parent")

                fixedFrameParent

                sectionHeader("2. Container Parent (VStack/HStack)")

                containerParent

                sectionHeader("3. Flexible Frame Parent")

                flexibleFrameParent

                sectionHeader("4. Real Measurements")

                realMeasurements

                sectionHeader("5. The Three Scenarios")

                threeScenarios

                sectionHeader("6. Visual Summary")

                visualSummary
            }
            .padding()
        }
    }

    // MARK: - Key Insight

    private var keyInsightSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("The Answer: IT DEPENDS!")
                .font(.headline)
                .foregroundColor(.orange)

            Text("What happens when child is larger than parent depends on the PARENT TYPE:")
                .foregroundColor(.secondary)

            scenarioCard(
                icon: "1️⃣",
                title: "Fixed Frame Parent",
                description: "Parent keeps its size, child overflows",
                example: ".frame(width: 100) with 200pt child",
                result: "Parent: 100pt, Child: 200pt (overflow!)",
                color: .red
            )

            scenarioCard(
                icon: "2️⃣",
                title: "Container Parent (VStack/HStack)",
                description: "Parent expands to fit child",
                example: "VStack with 200pt child",
                result: "Parent: 200pt, Child: 200pt (no overflow)",
                color: .green
            )

            scenarioCard(
                icon: "3️⃣",
                title: "Flexible Frame Parent",
                description: "Depends on constraints",
                example: ".frame(maxWidth: 100) with 200pt child",
                result: "Parent: 200pt (expands!), Child: 200pt",
                color: .blue
            )
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }

    // MARK: - Fixed Frame Parent

    private var fixedFrameParent: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Fixed Frame Parent - Two Separate Sizes!",
                description: "Parent has its own size, child has its own size",
                code: ".frame(width: 100) with child .frame(width: 200)"
            ) {
                VStack(spacing: 16) {
                    // Visual demonstration with measurement
                    MeasuredView(
                        label: "Parent Frame",
                        color: .blue
                    ) {
                        MeasuredView(
                            label: "Child",
                            color: .red
                        ) {
                            Color.red
                                .frame(width: 200, height: 50)
                        }
                        .frame(width: 100, height: 60)
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text("What happens:")
                            .fontWeight(.semibold)

                        explanationItem("1", "Parent frame modifier reports 100pt to ITS parent")
                        explanationItem("2", "Child exists at full 200pt size")
                        explanationItem("3", "Child OVERFLOWS parent's bounds visually")
                        explanationItem("4", "Both sizes exist simultaneously!")
                    }
                    .font(.caption)
                    .padding()
                    .background(Color.yellow.opacity(0.1))
                    .cornerRadius(8)

                    Text("✅ Parent: 100pt (reported to grandparent)\n✅ Child: 200pt (actual size)\n⚠️ Visual overflow!")
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.orange)
                }
            }

            exampleCard(
                title: "Layout Space vs Child Size",
                description: "Parent allocates 100pt, child renders at 200pt",
                code: ""
            ) {
                VStack(spacing: 12) {
                    Text("The hierarchy:")
                        .font(.caption)
                        .fontWeight(.semibold)

                    VStack(alignment: .leading, spacing: 4) {
                        hierarchyItem(level: 0, name: "Grandparent", size: "sees 100pt")
                        hierarchyItem(level: 1, name: "Fixed Frame Parent", size: "reports 100pt ↑, contains 200pt child ↓")
                        hierarchyItem(level: 2, name: "Child", size: "is 200pt")
                    }
                    .font(.system(.caption, design: .monospaced))
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Key insight:")
                            .fontWeight(.semibold)

                        Text("• Parent's LAYOUT SIZE = 100pt (what others see)")
                        Text("• Child's ACTUAL SIZE = 200pt (what it is)")
                        Text("• They are DIFFERENT and both exist!")
                        Text("• Child overflows parent's layout bounds")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Sibling Positioning Proof",
                description: "Siblings see parent as 100pt, not 200pt",
                code: ""
            ) {
                VStack(spacing: 12) {
                    HStack(spacing: 0) {
                        // Parent with overflowing child
                        ZStack(alignment: .leading) {
                            // Parent's layout bounds
                            Rectangle()
                                .stroke(Color.blue, lineWidth: 2)
                                .frame(width: 100, height: 50)

                            // Child (overflows)
                            Rectangle()
                                .fill(Color.red.opacity(0.3))
                                .frame(width: 200, height: 40)
                        }
                        .frame(width: 100, height: 50)

                        // Sibling
                        Text("Sibling")
                            .font(.caption)
                            .padding(8)
                            .background(Color.green.opacity(0.3))
                            .border(Color.green, width: 2)
                    }

                    Text("Green sibling is positioned at 100pt mark (parent's size), NOT 200pt (child's size)!")
                        .font(.caption)
                        .foregroundColor(.green)
                }
            }
        }
    }

    // MARK: - Container Parent

    private var containerParent: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Container Parent - Parent Expands!",
                description: "VStack/HStack expand to fit children",
                code: "VStack with 200pt child"
            ) {
                VStack(spacing: 16) {
                    // Demonstrate VStack expanding
                    MeasuredView(
                        label: "VStack Parent",
                        color: .green
                    ) {
                        VStack {
                            MeasuredView(
                                label: "Child",
                                color: .blue
                            ) {
                                Color.blue
                                    .frame(width: 200, height: 50)
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text("What happens:")
                            .fontWeight(.semibold)

                        explanationItem("1", "Child reports 200pt size")
                        explanationItem("2", "VStack receives 200pt from child")
                        explanationItem("3", "VStack EXPANDS to 200pt to fit child")
                        explanationItem("4", "VStack reports 200pt to its parent")
                    }
                    .font(.caption)
                    .padding()
                    .background(Color.yellow.opacity(0.1))
                    .cornerRadius(8)

                    Text("✅ Parent: 200pt (expanded!)\n✅ Child: 200pt\n✅ No overflow - sizes match!")
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.green)
                }
            }

            exampleCard(
                title: "Container Behavior",
                description: "Containers size themselves to their content",
                code: ""
            ) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Container views (VStack, HStack, ZStack):")
                        .fontWeight(.semibold)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("• Ask children for their sizes")
                        Text("• Calculate their own size based on children")
                        Text("• EXPAND to accommodate all children")
                        Text("• Report combined size to parent")
                    }
                    .font(.caption)

                    Divider()

                    Text("Example: VStack with 50pt and 200pt children")
                        .fontWeight(.semibold)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("• Child 1: 50pt")
                        Text("• Child 2: 200pt")
                        Text("• VStack width: max(50, 200) = 200pt")
                        Text("• VStack expands to widest child!")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }
        }
    }

    // MARK: - Flexible Frame Parent

    private var flexibleFrameParent: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Flexible Frame - Can Expand!",
                description: "maxWidth allows expansion, but has limits",
                code: ".frame(maxWidth: 100) with 200pt child"
            ) {
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Scenario: .frame(maxWidth: 100)")
                            .fontWeight(.semibold)

                        VStack(alignment: .leading, spacing: 4) {
                            flowItem("1", "Parent proposes 100pt to child")
                            flowItem("2", "Child reports 200pt")
                            flowItem("3", "maxWidth tries to limit to 100pt")
                            flowItem("4", "But child is 200pt...")
                            flowItem("5", "Parent EXPANDS to 200pt!")
                            flowItem("6", "Child \"wins\" - parent expands")
                        }
                        .font(.caption)

                        Text("Result: Both are 200pt. The child overflow forces parent expansion.")
                            .font(.caption)
                            .foregroundColor(.orange)
                            .padding(.top, 4)
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)

                    Text("⚠️ Flexible frames TRY to constrain but can be overridden by child demands")
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.orange)
                }
            }

            exampleCard(
                title: "minWidth - Child Must Win!",
                description: "minWidth sets a minimum, child can be larger",
                code: ".frame(minWidth: 100) with 200pt child"
            ) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Scenario: .frame(minWidth: 100)")
                        .fontWeight(.semibold)

                    VStack(alignment: .leading, spacing: 4) {
                        flowItem("1", "Parent says: \"at least 100pt\"")
                        flowItem("2", "Child reports 200pt")
                        flowItem("3", "200pt > 100pt minimum ✅")
                        flowItem("4", "Parent: \"OK, 200pt is fine\"")
                        flowItem("5", "Parent becomes 200pt")
                    }
                    .font(.caption)

                    Text("Result: Parent is 200pt (child size), which is > minimum")
                        .font(.caption)
                        .foregroundColor(.green)
                }
            }
        }
    }

    // MARK: - Real Measurements

    private var realMeasurements: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Live Measurement Comparison",
                description: "See actual reported sizes",
                code: ""
            ) {
                VStack(spacing: 20) {
                    // Fixed frame parent
                    VStack(alignment: .leading, spacing: 8) {
                        Text("1. Fixed Frame Parent")
                            .font(.caption)
                            .fontWeight(.semibold)

                        GeometryReader { parentGeo in
                            ZStack(alignment: .leading) {
                                // Show parent bounds
                                Rectangle()
                                    .stroke(Color.blue, lineWidth: 2)
                                    .background(
                                        Text("Parent: \(Int(parentGeo.size.width))pt")
                                            .font(.caption)
                                            .offset(y: -20)
                                    )

                                // Child (will overflow)
                                GeometryReader { childGeo in
                                    Rectangle()
                                        .fill(Color.red.opacity(0.3))
                                        .frame(width: 200)
                                        .background(
                                            Text("Child: \(Int(childGeo.size.width))pt")
                                                .font(.caption)
                                                .offset(y: 30)
                                        )
                                }
                            }
                        }
                        .frame(width: 100, height: 80)
                    }

                    // Container parent
                    VStack(alignment: .leading, spacing: 8) {
                        Text("2. Container Parent (VStack)")
                            .font(.caption)
                            .fontWeight(.semibold)

                        GeometryReader { parentGeo in
                            VStack {
                                Rectangle()
                                    .fill(Color.blue.opacity(0.3))
                                    .frame(width: 200, height: 50)
                                    .overlay(
                                        Text("Child: 200pt")
                                            .font(.caption)
                                    )
                            }
                            .background(
                                Text("Parent: \(Int(parentGeo.size.width))pt")
                                    .font(.caption)
                                    .offset(y: -20)
                            )
                            .border(Color.green, width: 2)
                        }
                        .frame(height: 80)
                    }

                    Text("See the difference?\nFixed frame: parent stays 100pt\nContainer: parent expands to 200pt")
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.orange)
                }
            }
        }
    }

    // MARK: - Three Scenarios

    private var threeScenarios: some View {
        VStack(spacing: 16) {
            Text("Summary: Three Different Behaviors")
                .font(.headline)

            comparisonCard(
                scenario: "Fixed Frame Parent",
                code: ".frame(width: 100)",
                parentSize: "100pt (fixed)",
                childSize: "200pt (actual)",
                relationship: "Two separate sizes",
                outcome: "Child overflows visually",
                color: .red
            )

            comparisonCard(
                scenario: "Container Parent",
                code: "VStack { }",
                parentSize: "200pt (expanded)",
                childSize: "200pt (actual)",
                relationship: "Sizes match",
                outcome: "Parent expands to fit",
                color: .green
            )

            comparisonCard(
                scenario: "Flexible Frame Parent",
                code: ".frame(maxWidth: 100)",
                parentSize: "200pt (expanded)",
                childSize: "200pt (actual)",
                relationship: "Child wins",
                outcome: "Parent expands beyond max",
                color: .blue
            )
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }

    // MARK: - Visual Summary

    private var visualSummary: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Visual Summary")
                .font(.headline)

            VStack(alignment: .leading, spacing: 12) {
                Text("Question: Child (200pt) larger than parent (100pt)")
                    .fontWeight(.semibold)

                Divider()

                summaryOption(
                    icon: "❌",
                    title: "Fixed Frame: Two separate sizes",
                    description: "Parent: 100pt (layout), Child: 200pt (overflows)",
                    color: .red
                )

                summaryOption(
                    icon: "✅",
                    title: "Container: Parent expands",
                    description: "Parent: 200pt (expanded), Child: 200pt (fits)",
                    color: .green
                )

                summaryOption(
                    icon: "⚠️",
                    title: "Flexible: Usually expands",
                    description: "Parent: 200pt (child won), Child: 200pt (fits)",
                    color: .blue
                )
            }

            Text("\nThe answer depends on what TYPE of parent contains the child!")
                .font(.subheadline)
                .foregroundColor(.orange)
                .padding()
                .background(Color.orange.opacity(0.1))
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

    private func scenarioCard(icon: String, title: String, description: String, example: String, result: String, color: Color) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Text(icon)
                .font(.title)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .fontWeight(.semibold)
                    .foregroundColor(color)

                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text("Example: \(example)")
                    .font(.caption)
                    .italic()

                Text("→ \(result)")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(color)
            }
        }
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(8)
    }

    private func explanationItem(_ number: String, _ text: String) -> some View {
        HStack(alignment: .top, spacing: 6) {
            Text("\(number).")
                .fontWeight(.semibold)
            Text(text)
        }
    }

    private func flowItem(_ number: String, _ text: String) -> some View {
        HStack(alignment: .top, spacing: 6) {
            Text("\(number).")
                .fontWeight(.semibold)
                .foregroundColor(.blue)
            Text(text)
        }
    }

    private func hierarchyItem(level: Int, name: String, size: String) -> some View {
        HStack(spacing: 4) {
            Text(String(repeating: "  ", count: level) + "└─")
                .foregroundColor(.secondary)
            Text(name)
                .fontWeight(.medium)
            Spacer()
            Text(size)
                .foregroundColor(.secondary)
        }
    }

    private func comparisonCard(scenario: String, code: String, parentSize: String, childSize: String, relationship: String, outcome: String, color: Color) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(scenario)
                    .fontWeight(.semibold)
                    .foregroundColor(color)
                Spacer()
                Text(code)
                    .font(.system(.caption, design: .monospaced))
                    .foregroundColor(.secondary)
            }

            VStack(alignment: .leading, spacing: 4) {
                comparisonRow("Parent Size:", parentSize)
                comparisonRow("Child Size:", childSize)
                comparisonRow("Relationship:", relationship)
                comparisonRow("Outcome:", outcome)
            }
            .font(.caption)
        }
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(8)
    }

    private func comparisonRow(_ label: String, _ value: String) -> some View {
        HStack {
            Text(label)
                .foregroundColor(.secondary)
            Text(value)
                .fontWeight(.medium)
        }
    }

    private func summaryOption(icon: String, title: String, description: String, color: Color) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Text(icon)
                .font(.title3)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .fontWeight(.semibold)
                    .foregroundColor(color)

                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

// MARK: - Measured View Helper

struct MeasuredView<Content: View>: View {
    let label: String
    let color: Color
    let content: Content

    init(label: String, color: Color, @ViewBuilder content: () -> Content) {
        self.label = label
        self.color = color
        self.content = content()
    }

    var body: some View {
        GeometryReader { geo in
            content
                .border(color, width: 2)
                .overlay(
                    Text("\(label): \(Int(geo.size.width))pt")
                        .font(.caption)
                        .foregroundColor(color)
                        .padding(4)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(4)
                        .offset(y: -25),
                    alignment: .top
                )
        }
    }
}

// MARK: - Preview

#Preview {
    ParentChildSizeConflicts()
}

/*
 PARENT-CHILD SIZE CONFLICTS SUMMARY:

 ## The Question:

 When child size (200pt) > parent constraint (100pt), what happens?
 - Does child overflow with its own size?
 - Does parent expand to swallow child?

 ## The Answer: IT DEPENDS ON PARENT TYPE!

 ### 1. Fixed Frame Parent (.frame(width: 100))

 Result: TWO SEPARATE SIZES!
 - Parent's layout size: 100pt (reported to grandparent)
 - Child's actual size: 200pt (exists at full size)
 - Child OVERFLOWS parent's bounds visually
 - Siblings positioned based on parent's 100pt, not child's 200pt

 Analogy: A box that's 100cm, containing a 200cm object that sticks out

 ### 2. Container Parent (VStack, HStack, ZStack)

 Result: PARENT EXPANDS!
 - Parent size: 200pt (expanded to fit child)
 - Child size: 200pt (actual size)
 - NO overflow - parent grows to accommodate
 - Siblings positioned based on 200pt

 Analogy: A stretchy bag that expands to fit whatever you put in

 ### 3. Flexible Frame Parent (.frame(maxWidth: 100))

 Result: USUALLY EXPANDS!
 - Parent tries to constrain to 100pt
 - Child demands 200pt
 - Child "wins" - parent expands to 200pt
 - Similar to container behavior

 Analogy: A "max 100cm" rule that gets overridden by actual content

 ## Key Insights:

 1. Fixed frames create TWO SIZES:
    - Layout size (what parent reports upward)
    - Content size (what child actually is)
    - These can be different!

 2. Containers adapt to children:
    - They measure children first
    - Then size themselves accordingly
    - Parent and child sizes match

 3. Layout vs Rendering:
    - Even with overflow, layout sees parent's size
    - Rendering shows child's full size
    - Sibling positioning based on layout, not rendering

 ## Visual Examples:

 Fixed Frame:
 ┌─────────┐
 │ Parent  │Content Extends Beyond
 │ 100pt   │
 └─────────┘
 ↑ Reports 100pt to grandparent
 ↑ Contains 200pt child (overflows)

 Container:
 ┌──────────────────────┐
 │ Parent 200pt         │
 │  ┌────────────────┐  │
 │  │ Child 200pt    │  │
 │  └────────────────┘  │
 └──────────────────────┘
 ↑ Expands to fit child
 */
