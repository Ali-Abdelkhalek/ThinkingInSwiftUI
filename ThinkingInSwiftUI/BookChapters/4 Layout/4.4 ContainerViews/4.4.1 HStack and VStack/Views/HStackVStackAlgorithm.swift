//
//  HStackVStackAlgorithm.swift
//  ThinkingInSwiftUI
//
//  HStack and VStack Layout Algorithm - Regular Stacks
//

import SwiftUI


struct HStackVStackLayoutAlgorithm: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {

                // MARK: - The Surprising Behavior

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("🤔 THE SURPRISING BEHAVIOR")
                            .font(.headline)

                        Text("Watch what happens as we reduce the width:")
                            .font(.subheadline)

                        VStack(spacing: 15) {
                            // Wide proposal - works as expected
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Proposed: 250×50")
                                    .font(.caption)
                                    .foregroundColor(.secondary)

                                HStack(spacing: 0) {
                                    Color.cyan
                                    Text("Hello, World!")
                                    Color.teal
                                }
                                .frame(height: 50)
                                .border(Color.gray)
                            }

                            // Medium proposal - text wraps even though there's space!
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Proposed: 180×50")
                                    .font(.caption)
                                    .foregroundColor(.secondary)

                                HStack(spacing: 0) {
                                    Color.cyan
                                    Text("Hello, World!")
                                    Color.teal
                                }
                                .frame(width: 180, height: 50)
                                .border(Color.gray)
                            }

                            // Narrow proposal - text wraps even more
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Proposed: 100×50")
                                    .font(.caption)
                                    .foregroundColor(.secondary)

                                HStack(spacing: 0) {
                                    Color.cyan
                                    Text("Hello, World!")
                                    Color.teal
                                }
                                .frame(width: 100, height: 50)
                                .border(Color.gray)
                            }
                        }

                        Text("❓ Why does the text wrap at 180pt when 'Hello, World!' only needs ~100pt?")
                            .font(.caption)
                            .foregroundColor(.orange)
                            .padding(.top, 5)

                        Text("Answer: Stack divides 180÷3 = 60pt to each subview. Text gets 60pt, wraps to fit!")
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                }

                // MARK: - Understanding Flexibility

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("📏 UNDERSTANDING FLEXIBILITY")
                            .font(.headline)

                        Text("Stacks determine flexibility by PROBING (proposing 0 and ∞):")
                            .font(.subheadline)

                        VStack(alignment: .leading, spacing: 10) {
                            FlexibilityRow(
                                name: "Color.cyan",
                                zeroWidth: "0pt",
                                infinityWidth: "∞pt",
                                flexibility: "∞ - 0 = ∞",
                                color: .cyan
                            )

                            FlexibilityRow(
                                name: "Text('Hello, World!')",
                                zeroWidth: "0pt (truncated)",
                                infinityWidth: "~100pt (ideal)",
                                flexibility: "100 - 0 = 100",
                                color: .primary
                            )

                            FlexibilityRow(
                                name: "Color.teal",
                                zeroWidth: "0pt",
                                infinityWidth: "∞pt",
                                flexibility: "∞ - 0 = ∞",
                                color: .teal
                            )
                        }
                        .font(.caption)

                        Text("Stack sorts by flexibility (least → most):")
                            .font(.subheadline)
                            .padding(.top, 5)

                        HStack(spacing: 10) {
                            FlexibilityBadge(name: "Text", flex: "100", order: "1st")
                            Text("→")
                            FlexibilityBadge(name: "cyan", flex: "∞", order: "2nd")
                            Text("→")
                            FlexibilityBadge(name: "teal", flex: "∞", order: "3rd")
                        }
                        .font(.caption)
                    }
                }

                // MARK: - The Algorithm Step-by-Step

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("🔄 THE ALGORITHM (Step-by-Step)")
                            .font(.headline)

                        Text("Proposal: 180×50 to HStack")
                            .font(.subheadline)
                            .foregroundColor(.blue)

                        VStack(alignment: .leading, spacing: 8) {
                            AlgorithmStep(
                                step: "1",
                                description: "Probe all subviews to determine flexibility",
                                result: "Text = 100, Colors = ∞"
                            )

                            AlgorithmStep(
                                step: "2",
                                description: "Sort by flexibility (least → most)",
                                result: "Text, cyan, teal"
                            )

                            AlgorithmStep(
                                step: "3",
                                description: "Propose to Text: 180÷3 = 60pt",
                                result: "Text wraps, reports 60×40"
                            )

                            AlgorithmStep(
                                step: "4",
                                description: "Remaining: 180-60 = 120pt, 2 views left",
                                result: "Propose to cyan: 120÷2 = 60pt"
                            )

                            AlgorithmStep(
                                step: "5",
                                description: "cyan accepts 60pt",
                                result: "Remaining: 120-60 = 60pt, 1 view left"
                            )

                            AlgorithmStep(
                                step: "6",
                                description: "Propose to teal: 60÷1 = 60pt",
                                result: "teal accepts 60pt"
                            )

                            AlgorithmStep(
                                step: "✓",
                                description: "Final layout",
                                result: "cyan(60) + Text(60) + teal(60) = 180pt"
                            )
                        }
                        .font(.caption)

                        Text("💡 The text only gets 60pt, so it wraps — even though its ideal size is ~100pt!")
                            .font(.caption)
                            .foregroundColor(.orange)
                            .padding(.top, 5)
                    }
                }

                // MARK: - Solution 1: fixedSize()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("✅ SOLUTION 1: fixedSize()")
                            .font(.headline)

                        Text("Apply .fixedSize() to the text so it ignores the proposal:")
                            .font(.subheadline)

                        VStack(spacing: 15) {
                            // Works well with enough space
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Proposed: 180×50 (enough space)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)

                                HStack(spacing: 0) {
                                    Color.cyan
                                    Text("Hello, World!")
                                        .fixedSize()
                                    Color.teal
                                }
                                .frame(width: 180, height: 50)
                                .border(Color.gray)

                                Text("✓ Text at ideal size (~100pt), colors fill remaining space")
                                    .font(.caption)
                                    .foregroundColor(.green)
                            }

                            // Overflows when not enough space!
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Proposed: 40×40 (NOT enough space)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)

                                HStack(spacing: 0) {
                                    Color.cyan
                                    Text("Hello, World!")
                                        .fixedSize()
                                    Color.teal
                                }
                                .frame(width: 40, height: 40)
                                .border(Color.gray)

                                Text("⚠️ Text renders at full ~100pt width — OUT OF BOUNDS!")
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                        }

                        Text("Conclusion: fixedSize() works well when there's enough space, but causes overflow otherwise.")
                            .font(.caption)
                            .foregroundColor(.orange)
                            .padding(.top, 5)
                    }
                }

                // MARK: - Solution 2: layoutPriority()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("✅ SOLUTION 2: layoutPriority() (BETTER!)")
                            .font(.headline)

                        Text("Give the text higher priority — stack proposes to it FIRST:")
                            .font(.subheadline)

                        VStack(spacing: 15) {
                            // With enough space
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Proposed: 250×50 (enough space)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)

                                HStack(spacing: 0) {
                                    Color.cyan
                                    Text("Hello, World!")
                                        .layoutPriority(1)
                                    Color.teal
                                }
                                .frame(width: 250, height: 50)
                                .border(Color.gray)

                                Text("✓ Text gets proposed 250pt first, takes ~100pt, colors share remaining 150pt")
                                    .font(.caption)
                                    .foregroundColor(.green)
                            }

                            // Medium space
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Proposed: 120×50")
                                    .font(.caption)
                                    .foregroundColor(.secondary)

                                HStack(spacing: 0) {
                                    Color.cyan
                                    Text("Hello, World!")
                                        .layoutPriority(1)
                                    Color.teal
                                }
                                .frame(width: 120, height: 50)
                                .border(Color.gray)

                                Text("✓ Text gets 120pt first, takes ~100pt, colors share remaining 20pt")
                                    .font(.caption)
                                    .foregroundColor(.green)
                            }

                            // Not enough space - text finally wraps
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Proposed: 80×50 (NOT enough)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)

                                HStack(spacing: 0) {
                                    Color.cyan
                                    Text("Hello, World!")
                                        .layoutPriority(1)
                                    Color.teal
                                }
                                .frame(width: 80, height: 50)
                                .border(Color.gray)

                                Text("✓ Text gets 80pt first, wraps to fit, respects bounds!")
                                    .font(.caption)
                                    .foregroundColor(.green)
                            }
                        }

                        Text("Conclusion: layoutPriority() is better — text gets full width first, only wraps when truly necessary!")
                            .font(.caption)
                            .foregroundColor(.green)
                            .padding(.top, 5)
                    }
                }

                // MARK: - Understanding layoutPriority Values

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("🎯 UNDERSTANDING layoutPriority()")
                            .font(.headline)

                        Text("Default priority is 0. Higher numbers = earlier proposal.")
                            .font(.subheadline)

                        VStack(alignment: .leading, spacing: 8) {
                            PriorityExample(
                                priority: "0 (default)",
                                description: "All views have same priority → sorted by flexibility"
                            )

                            PriorityExample(
                                priority: "1",
                                description: "Gets proposed to before priority 0 views"
                            )

                            PriorityExample(
                                priority: "10",
                                description: "Gets proposed to before priority 1 and 0 views"
                            )

                            PriorityExample(
                                priority: "-1",
                                description: "Gets proposed to AFTER priority 0 views"
                            )
                        }
                        .font(.caption)

                        // Example with multiple priorities
                        Text("Example: Multiple Priorities")
                            .font(.subheadline)
                            .padding(.top, 5)

                        VStack(alignment: .leading, spacing: 5) {
                            HStack(spacing: 0) {
                                Color.cyan
                                Text("High Priority")
                                    .layoutPriority(2)
                                Color.orange
                                Text("Medium Priority")
                                    .layoutPriority(1)
                                Color.teal
                            }
                            .frame(width: 250, height: 50)
                            .border(Color.gray)

                            Text("Proposal order: High Priority → Medium Priority → Colors (by flexibility)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }

                // MARK: - The Full Algorithm

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("📋 THE FULL ALGORITHM (Informal)")
                            .font(.headline)

                        Text("This algorithm hasn't changed since 2020 and is considered stable:")
                            .font(.subheadline)

                        VStack(alignment: .leading, spacing: 10) {
                            FullAlgorithmStep(
                                number: "1",
                                title: "Determine flexibility of all subviews",
                                detail: "Probe by proposing 0×height and ∞×height. Flexibility = difference."
                            )

                            FullAlgorithmStep(
                                number: "2",
                                title: "Group subviews by layout priority",
                                detail: "Default priority is 0. Higher priorities processed first."
                            )

                            FullAlgorithmStep(
                                number: "3",
                                title: "Calculate remainingWidth",
                                detail: "Start with proposed width, subtract minimum widths + spacing."
                            )

                            FullAlgorithmStep(
                                number: "4",
                                title: "While there are remaining groups:",
                                detail: ""
                            )

                            VStack(alignment: .leading, spacing: 8) {
                                FullAlgorithmSubStep(
                                    letter: "a",
                                    detail: "Pick group with highest priority"
                                )

                                FullAlgorithmSubStep(
                                    letter: "b",
                                    detail: "Add minimum widths back to remainingWidth"
                                )

                                FullAlgorithmSubStep(
                                    letter: "c",
                                    detail: "While there are remaining views in group:"
                                )

                                VStack(alignment: .leading, spacing: 5) {
                                    FullAlgorithmSubSubStep(
                                        roman: "i",
                                        detail: "Pick view with smallest flexibility"
                                    )

                                    FullAlgorithmSubSubStep(
                                        roman: "ii",
                                        detail: "Propose (remainingWidth ÷ numberOfRemainingViews) × height"
                                    )

                                    FullAlgorithmSubSubStep(
                                        roman: "iii",
                                        detail: "Subtract view's reported width from remainingWidth"
                                    )
                                }
                                .padding(.leading, 20)
                            }
                            .padding(.leading, 15)
                        }
                        .font(.caption)

                        Text("💡 You can verify this by placing custom shapes with sizeThatFits() logging!")
                            .font(.caption)
                            .foregroundColor(.blue)
                            .padding(.top, 5)
                    }
                }

                // MARK: - Verifying with Custom Shapes

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("🔍 VERIFYING THE ALGORITHM")
                            .font(.headline)

                        Text("Use custom shapes that log proposals to verify the algorithm:")
                            .font(.subheadline)

                        Text("""
                        Check the Xcode console to see the proposals!
                        You'll see how the stack probes and proposes to each view.
                        """)
                            .font(.caption)
                            .foregroundColor(.secondary)

                        // Example with logging shapes
                        VStack(alignment: .leading, spacing: 5) {
                            Text("HStack with 3 ProbeLoggingShapes:")
                                .font(.caption)

                            HStack(spacing: 0) {
                                ProbeLoggingShape(name: "Shape A", color: .cyan, idealWidth: 50)
                                ProbeLoggingShape(name: "Shape B", color: .orange, idealWidth: 100)
                                ProbeLoggingShape(name: "Shape C", color: .teal, idealWidth: 75)
                            }
                            .frame(width: 200, height: 50)
                            .border(Color.gray)

                            Text("Console shows: Probing (0 and ∞), then final proposals")
                                .font(.caption)
                                .foregroundColor(.green)
                        }

                        Text("""
                        Expected console output:
                        [Probe] Shape A proposed: (0.0, 50.0)
                        [Probe] Shape A proposed: (inf, 50.0)
                        [Probe] Shape B proposed: (0.0, 50.0)
                        [Probe] Shape B proposed: (inf, 50.0)
                        [Probe] Shape C proposed: (0.0, 50.0)
                        [Probe] Shape C proposed: (inf, 50.0)
                        [Final] Shape B proposed: (66.67, 50.0) → reports: 66.67
                        [Final] Shape C proposed: (66.67, 50.0) → reports: 66.67
                        [Final] Shape A proposed: (66.67, 50.0) → reports: 50.0
                        """)
                            .font(.system(.caption, design: .monospaced))
                            .foregroundColor(.secondary)
                            .padding(.top, 5)
                    }
                }

                // MARK: - VStack Works the Same Way

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("↕️ VSTACK WORKS THE SAME WAY")
                            .font(.headline)

                        Text("Vertical stacks use the same algorithm, just with height as the major axis:")
                            .font(.subheadline)

                        HStack(spacing: 20) {
                            // VStack example
                            VStack(alignment: .leading, spacing: 5) {
                                Text("VStack (height axis)")
                                    .font(.caption)

                                VStack(spacing: 0) {
                                    Color.cyan
                                    Text("Hello, World!")
                                        .fixedSize()
                                    Color.teal
                                }
                                .frame(width: 100, height: 150)
                                .border(Color.gray)
                            }

                            // HStack equivalent
                            VStack(alignment: .leading, spacing: 5) {
                                Text("HStack (width axis)")
                                    .font(.caption)

                                HStack(spacing: 0) {
                                    Color.cyan
                                    Text("Hello, World!")
                                        .fixedSize()
                                    Color.teal
                                }
                                .frame(width: 150, height: 100)
                                .border(Color.gray)
                            }
                        }

                        Text("The algorithm is identical, just swap 'width' for 'height'!")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                }

                // MARK: - Common Pitfalls

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("⚠️ COMMON PITFALLS")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 10) {
                            PitfallItem(
                                emoji: "1️⃣",
                                title: "Expecting fair division",
                                description: "Stack divides by COUNT, not by NEED. Use layoutPriority()!"
                            )

                            PitfallItem(
                                emoji: "2️⃣",
                                title: "Using fixedSize() everywhere",
                                description: "Works for small views, but causes overflow for larger ones."
                            )

                            PitfallItem(
                                emoji: "3️⃣",
                                title: "Forgetting about flexibility",
                                description: "Colors/Spacers are infinitely flexible. Text/Images have limits."
                            )

                            PitfallItem(
                                emoji: "4️⃣",
                                title: "Not using layoutPriority()",
                                description: "Best solution for giving important views full proposal first!"
                            )

                            PitfallItem(
                                emoji: "5️⃣",
                                title: "Assuming spacing doesn't matter",
                                description: "Spacing is subtracted from available width before division!"
                            )
                        }
                    }
                }

                // MARK: - Quick Reference

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("📚 QUICK REFERENCE")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            QuickRefItem(
                                term: "Flexibility",
                                definition: "Width at ∞ proposal - Width at 0 proposal"
                            )

                            QuickRefItem(
                                term: "Probing",
                                definition: "Proposing multiple sizes (0 and ∞) to determine flexibility"
                            )

                            QuickRefItem(
                                term: "Division",
                                definition: "remainingWidth ÷ numberOfRemainingViews"
                            )

                            QuickRefItem(
                                term: "Order",
                                definition: "By layoutPriority (high→low), then by flexibility (low→high)"
                            )

                            QuickRefItem(
                                term: "fixedSize()",
                                definition: "Ignores proposal, becomes ideal size (can overflow)"
                            )

                            QuickRefItem(
                                term: "layoutPriority()",
                                definition: "Higher = proposed to earlier (default = 0)"
                            )
                        }
                        .font(.caption)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("HStack/VStack Layout")
    }
}

// MARK: - Helper Views

struct FlexibilityRow: View {
    let name: String
    let zeroWidth: String
    let infinityWidth: String
    let flexibility: String
    let color: Color

    var body: some View {
        HStack(spacing: 10) {
            Circle()
                .fill(color == .primary ? Color.gray : color)
                .frame(width: 8, height: 8)

            Text(name)
                .frame(width: 150, alignment: .leading)

            VStack(alignment: .leading, spacing: 2) {
                Text("@ 0: \(zeroWidth)")
                Text("@ ∞: \(infinityWidth)")
                Text("Flex: \(flexibility)")
                    .foregroundColor(.blue)
            }
        }
    }
}

struct FlexibilityBadge: View {
    let name: String
    let flex: String
    let order: String

    var body: some View {
        VStack(spacing: 2) {
            Text(name)
                .font(.caption2)
                .bold()
            Text("Flex: \(flex)")
                .font(.caption2)
                .foregroundColor(.secondary)
            Text(order)
                .font(.caption2)
                .foregroundColor(.blue)
        }
        .padding(6)
        .background(Color.blue.opacity(0.1))
        .cornerRadius(5)
    }
}

struct AlgorithmStep: View {
    let step: String
    let description: String
    let result: String

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text(step)
                .font(.caption)
                .bold()
                .foregroundColor(.white)
                .frame(width: 20, height: 20)
                .background(step == "✓" ? Color.green : Color.blue)
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 2) {
                Text(description)
                Text("→ \(result)")
                    .foregroundColor(.green)
            }
        }
    }
}

struct PriorityExample: View {
    let priority: String
    let description: String

    var body: some View {
        HStack(spacing: 10) {
            Text(priority)
                .font(.caption)
                .bold()
                .frame(minWidth: 80, alignment: .leading)
            Text(description)
                .foregroundColor(.secondary)
        }
    }
}

struct FullAlgorithmStep: View {
    let number: String
    let title: String
    let detail: String

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text(number)
                .font(.caption)
                .bold()
                .foregroundColor(.white)
                .frame(width: 20, height: 20)
                .background(Color.blue)
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .bold()
                if !detail.isEmpty {
                    Text(detail)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

struct FullAlgorithmSubStep: View {
    let letter: String
    let detail: String

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text(letter + ".")
                .font(.caption)
                .bold()
                .frame(minWidth: 20, alignment: .leading)
            Text(detail)
                .foregroundColor(.secondary)
        }
    }
}

struct FullAlgorithmSubSubStep: View {
    let roman: String
    let detail: String

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text(roman + ".")
                .font(.caption)
                .frame(minWidth: 15, alignment: .leading)
            Text(detail)
                .foregroundColor(.secondary)
        }
    }
}

struct PitfallItem: View {
    let emoji: String
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Text(emoji)
                .font(.caption)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .bold()
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct QuickRefItem: View {
    let term: String
    let definition: String

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text(term + ":")
                .bold()
                .frame(minWidth: 100, alignment: .leading)
            Text(definition)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Probe Logging Shape

/// A custom shape that logs all size proposals to help verify the stack layout algorithm
struct ProbeLoggingShape: Shape {
    let name: String
    let color: Color
    let idealWidth: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRect(rect)
        return path
    }

    func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize {
        let width = proposal.width ?? idealWidth
        let height = proposal.height ?? 50

        // Log the proposal
        if proposal.width == 0 || proposal.width == .infinity {
            print("[Probe] \(name) proposed: (\(proposal.width ?? 0), \(proposal.height ?? 0))")
        } else {
            let reportedWidth = min(width, idealWidth)
            print("[Final] \(name) proposed: (\(width), \(height)) → reports: \(reportedWidth)")
            return CGSize(width: reportedWidth, height: height)
        }

        // Return size based on proposal
        if proposal.width == 0 {
            return CGSize(width: 0, height: height)
        } else if proposal.width == .infinity {
            return CGSize(width: idealWidth, height: height)
        } else {
            return CGSize(width: min(width, idealWidth), height: height)
        }
    }
}

// MARK: - LazyHStack and LazyVStack
//
// LazyHStack and LazyVStack behave similarly to their non-lazy counterparts with
// KEY DIFFERENCES:
//
// 1. SIZE BEHAVIOR (Same as regular stacks):
//    - Become the size of the union of all subviews' frames
//
// 2. SPACE DISTRIBUTION (Different from regular stacks):
//    - Don't distribute available space along the major axis
//    - LazyHStack proposes nil×proposedHeight (subviews become ideal width)
//    - LazyVStack proposes proposedWidth×nil (subviews become ideal height)
//
// 3. LAZY CREATION:
//    - When embedded in a ScrollView, create subviews lazily (as needed)
//    - Must estimate size based on already-laid-out subviews
//    - Update size as new subviews appear (similar to List)

