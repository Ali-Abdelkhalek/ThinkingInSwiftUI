import SwiftUI

/// # ZStack Layout Behavior
///
/// At first glance, ZStack might seem to do the same thing as overlay or background,
/// but it behaves VERY differently!
///
/// ## Key Difference:
/// - **overlay/background**: Take on the size of the PRIMARY subview, discard secondary's size
/// - **ZStack**: Uses the UNION of all subviews' frames to compute its size
///
/// ## How ZStack Works:
/// 1. ZStack receives a proposal
/// 2. ZStack proposes the SAME value to EACH of its subviews
/// 3. Each subview reports back its size
/// 4. ZStack reports the UNION (bounding box) of all subview sizes
///
/// ## Critical Implication:
/// ALL subviews in a ZStack influence the stack's size!
/// (Unlike overlay/background where only primary influences size)

struct ZStackLayoutBehavior: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                
                // MARK: - ZStack vs Overlay/Background
                
                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("🆚 ZSTACK VS OVERLAY/BACKGROUND")
                            .font(.headline)
                        
                        Text("The fundamental difference:")
                            .font(.subheadline)
                        
                        ComparisonRow(
                            title: "overlay/background",
                            behavior: "Size = Primary's size (secondary ignored)",
                            color: .blue
                        )
                        
                        ComparisonRow(
                            title: "ZStack",
                            behavior: "Size = UNION of all subviews' sizes",
                            color: .green
                        )
                        
                        Text("This difference has HUGE layout implications!")
                            .font(.caption)
                            .foregroundColor(.orange)
                    }
                })
                
                // MARK: - The Badge Example
                
                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("📛 THE BADGE EXAMPLE")
                            .font(.headline)
                        
                        Text("Same visual appearance, DIFFERENT layout behavior:")
                            .font(.subheadline)
                        
                        Text("These are bottom-aligned in an HStack. Watch where the 'bottom' is!")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        HStack(alignment: .bottom, spacing: 30) {
                            // Left: Using overlay (correct!)
                            VStack(alignment: .leading, spacing: 5) {
                                Text("With overlay")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                Text("Hello, world")
                                    .font(.title2)
                                    .overlay(alignment: .topTrailing) {
                                        Text("A")
                                            .font(.caption)
                                            .padding(3)
                                            .background(
                                                RoundedRectangle(cornerRadius: 5)
                                                    .fill(Color.teal)
                                            )
                                            .offset(x: 5, y: -5)
                                    }
                                    .border(Color.blue)
                                
                                Text("↑ Bottom = bottom of 'Hello, world'")
                                    .font(.caption2)
                                    .foregroundColor(.blue)
                            }
                            
                            // Right: Using ZStack (problematic!)
                            VStack(alignment: .leading, spacing: 5) {
                                Text("With ZStack")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                ZStack(alignment: .topTrailing) {
                                    Text("Hello, world")
                                        .font(.title2)
                                    
                                    Text("A")
                                        .font(.caption)
                                        .padding(3)
                                        .background(
                                            RoundedRectangle(cornerRadius: 5)
                                                .fill(Color.teal)
                                        )
                                        .offset(x: 5, y: -5)
                                }
                                .border(Color.green)
                                
                                Text("↑ Bottom = bottom of 'A' badge!")
                                    .font(.caption2)
                                    .foregroundColor(.red)
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        
                        Text("Notice the difference:")
                            .font(.subheadline)
                            .padding(.top, 5)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            BadgeComparisonPoint(
                                emoji: "✅",
                                title: "overlay",
                                detail: "Size = 'Hello, world' size. Badge doesn't affect layout.",
                                color: .blue
                            )
                            
                            BadgeComparisonPoint(
                                emoji: "⚠️",
                                title: "ZStack",
                                detail: "Size = UNION of text + badge. Badge influences layout!",
                                color: .red
                            )
                        }
                        .font(.caption)
                        
                        Text("🎯 Result: With ZStack, the badge shifts the baseline down!")
                            .font(.caption)
                            .foregroundColor(.orange)
                            .padding(.top, 5)
                    }
                })
                
                // MARK: - Color Stretching Example
                
                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("🎨 COLOR STRETCHING")
                            .font(.headline)
                        
                        Text("Why does Color stretch to fill the entire ZStack?")
                            .font(.subheadline)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("""
                            ZStack {
                                Color.teal
                                Text("Hello, world")
                            }
                            """)
                            .font(.system(.caption, design: .monospaced))
                            .padding(8)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(5)
                            
                            Text("When used as root view:")
                                .font(.caption)
                                .bold()
                            
                            ZStackAlgorithmStep(
                                step: "1",
                                description: "ZStack gets proposed entire safe area (e.g., 390×844)",
                                result: "ZStack receives proposal"
                            )
                            
                            ZStackAlgorithmStep(
                                step: "2",
                                description: "ZStack proposes SAME size to Color.teal",
                                result: "Color proposes: 390×844"
                            )
                            
                            ZStackAlgorithmStep(
                                step: "3",
                                description: "Color.teal accepts full proposal",
                                result: "Color reports: 390×844"
                            )
                            
                            ZStackAlgorithmStep(
                                step: "4",
                                description: "ZStack proposes SAME size to Text",
                                result: "Text proposes: 390×844"
                            )
                            
                            ZStackAlgorithmStep(
                                step: "5",
                                description: "Text becomes ideal size",
                                result: "Text reports: ~100×20"
                            )
                            
                            ZStackAlgorithmStep(
                                step: "6",
                                description: "ZStack computes UNION of frames",
                                result: "Union(390×844, 100×20) = 390×844"
                            )
                            
                            ZStackAlgorithmStep(
                                step: "✓",
                                description: "ZStack reports final size",
                                result: "390×844 (Color stretches to fill!)"
                            )
                        }
                        .font(.caption)
                        
                        // Visual example
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Live example:")
                                .font(.caption)
                            
                            ZStack {
                                Color.teal
                                Text("Hello, world")
                                    .foregroundColor(.white)
                            }
                            .frame(width: 200, height: 100)
                            .border(Color.gray)
                            
                            Text("Color stretches to 200×100 because ZStack proposed it!")
                                .font(.caption)
                                .foregroundColor(.green)
                        }
                    }
                })
                
                // MARK: - The Union Algorithm
                
                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("📐 THE UNION ALGORITHM")
                            .font(.headline)
                        
                        Text("ZStack computes the bounding box of ALL subviews:")
                            .font(.subheadline)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            UnionExample(
                                subviews: [
                                    ("Rectangle 1", "100×50", "red"),
                                    ("Rectangle 2", "80×80", "blue")
                                ],
                                union: "100×80",
                                explanation: "Width = max(100, 80) = 100\nHeight = max(50, 80) = 80"
                            )
                            
                            Text("Visual representation:")
                                .font(.caption)
                                .padding(.top, 5)
                            
                            // Show the union visually
                            VStack(alignment: .leading, spacing: 5) {
                                ZStack {
                                    Rectangle()
                                        .fill(Color.red.opacity(0.3))
                                        .frame(width: 100, height: 50)
                                    
                                    Rectangle()
                                        .fill(Color.blue.opacity(0.3))
                                        .frame(width: 80, height: 80)
                                }
                                .border(Color.green, width: 2)
                                
                                Text("Green border = ZStack's size (100×80)")
                                    .font(.caption)
                                    .foregroundColor(.green)
                            }
                        }
                        
                        Text("🎯 Key insight: Even a tiny badge can make the ZStack taller!")
                            .font(.caption)
                            .foregroundColor(.orange)
                            .padding(.top, 5)
                    }
                })
                
                // MARK: - ZStack Proposal Behavior
                
                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("📨 ZSTACK PROPOSAL BEHAVIOR")
                            .font(.headline)
                        
                        Text("Unlike HStack/VStack, ZStack proposes the SAME size to ALL subviews:")
                            .font(.subheadline)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            ProposalComparisonRow(
                                container: "HStack",
                                behavior: "Divides width: 200÷3 = ~67pt to each",
                                fair: false
                            )
                            
                            ProposalComparisonRow(
                                container: "VStack",
                                behavior: "Divides height: 200÷3 = ~67pt to each",
                                fair: false
                            )
                            
                            ProposalComparisonRow(
                                container: "ZStack",
                                behavior: "Proposes FULL 200×200 to each!",
                                fair: true
                            )
                        }
                        .font(.caption)
                        
                        Text("This is why Color fills the entire ZStack — it gets the full proposal!")
                            .font(.caption)
                            .foregroundColor(.blue)
                            .padding(.top, 5)
                    }
                })
                
                // MARK: - Alignment Parameter
                
                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("🎯 ALIGNMENT PARAMETER")
                            .font(.headline)
                        
                        Text("ZStack accepts an alignment parameter (default: .center):")
                            .font(.subheadline)
                        
                        VStack(spacing: 15) {
                            // Center (default)
                            AlignmentExample(
                                alignment: .center,
                                alignmentName: ".center (default)"
                            )
                            
                            // Top leading
                            AlignmentExample(
                                alignment: .topLeading,
                                alignmentName: ".topLeading"
                            )
                            
                            // Bottom trailing
                            AlignmentExample(
                                alignment: .bottomTrailing,
                                alignmentName: ".bottomTrailing"
                            )
                        }
                        
                        Text("⚠️ Important: Alignment doesn't change the ZStack's size, only positioning!")
                            .font(.caption)
                            .foregroundColor(.orange)
                            .padding(.top, 5)
                    }
                })
                
                // MARK: - Comparison Table
                
                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("📊 COMPARISON TABLE")
                            .font(.headline)
                        
                        VStack(spacing: 0) {
                            // Header
                            HStack(spacing: 0) {
                                TableHeaderCell(text: "")
                                TableHeaderCell(text: "overlay")
                                TableHeaderCell(text: "background")
                                TableHeaderCell(text: "ZStack")
                            }
                            
                            Divider()
                            
                            // Row: Sizing
                            HStack(spacing: 0) {
                                TableCell(text: "Sizing", isRowHeader: true)
                                TableCell(text: "Primary's size", color: .blue)
                                TableCell(text: "Primary's size", color: .blue)
                                TableCell(text: "Union of all", color: .green)
                            }
                            
                            Divider()
                            
                            // Row: Proposal to subviews
                            HStack(spacing: 0) {
                                TableCell(text: "Proposal", isRowHeader: true)
                                TableCell(text: "Primary → same\nSecondary → primary's size", color: .blue)
                                TableCell(text: "Primary → same\nSecondary → primary's size", color: .blue)
                                TableCell(text: "All → same size", color: .green)
                            }
                            
                            Divider()
                            
                            // Row: Affects layout
                            HStack(spacing: 0) {
                                TableCell(text: "Secondary affects layout?", isRowHeader: true)
                                TableCell(text: "❌ No", color: .blue)
                                TableCell(text: "❌ No", color: .blue)
                                TableCell(text: "✅ Yes", color: .green)
                            }
                            
                            Divider()
                            
                            // Row: Use case
                            HStack(spacing: 0) {
                                TableCell(text: "Best for", isRowHeader: true)
                                TableCell(text: "Decorations, badges", color: .blue)
                                TableCell(text: "Backgrounds", color: .blue)
                                TableCell(text: "Layered content", color: .green)
                            }
                        }
                        .font(.caption)
                        .border(Color.gray)
                    }
                })
                
                // MARK: - Practical Examples
                
                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("💼 PRACTICAL EXAMPLES")
                            .font(.headline)
                        
                        VStack(alignment: .leading, spacing: 15) {
                            // Example 1: Profile picture with status indicator
                            PracticalExample(
                                title: "Profile picture with status indicator",
                                goodApproach: "Use overlay — status dot shouldn't affect layout",
                                badApproach: "Use ZStack — status dot shifts the image position",
                                code: """
                                // ✅ Good: overlay
                                Image("profile")
                                    .overlay(alignment: .bottomTrailing) {
                                        Circle().fill(.green).frame(width: 12)
                                    }
                                
                                // ❌ Bad: ZStack
                                ZStack(alignment: .bottomTrailing) {
                                    Image("profile")
                                    Circle().fill(.green).frame(width: 12)
                                }
                                """
                            )
                            
                            // Example 2: Notification badge
                            PracticalExample(
                                title: "Notification badge on button",
                                goodApproach: "Use overlay — badge shouldn't change button size",
                                badApproach: "Use ZStack — badge makes button taller/wider",
                                code: """
                                // ✅ Good: overlay
                                Button("Messages") { }
                                    .overlay(alignment: .topTrailing) {
                                        Text("5").badge()
                                    }
                                
                                // ❌ Bad: ZStack
                                ZStack(alignment: .topTrailing) {
                                    Button("Messages") { }
                                    Text("5").badge()
                                }
                                """
                            )
                            
                            // Example 3: Layered card design
                            PracticalExample(
                                title: "Layered card design",
                                goodApproach: "Use ZStack — all layers should influence size",
                                badApproach: "Use overlay — top layers might get cut off",
                                code: """
                                // ✅ Good: ZStack
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10).fill(.white)
                                    VStack { /* content */ }
                                    Image("watermark").opacity(0.1)
                                }
                                
                                // ❌ Bad: overlay (if watermark > content)
                                VStack { /* content */ }
                                    .overlay {
                                        Image("watermark").opacity(0.1)
                                    }
                                """
                            )
                        }
                    }
                })
                
                // MARK: - Common Pitfalls
                
                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("⚠️ COMMON PITFALLS")
                            .font(.headline)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            ZStackPitfallItem(
                                emoji: "1️⃣",
                                title: "Using ZStack for badges/decorations",
                                description: "Badges should NOT affect layout. Use overlay instead!",
                                fix: "Use overlay with .fixedSize() for the badge"
                            )
                            
                            ZStackPitfallItem(
                                emoji: "2️⃣",
                                title: "Expecting ZStack to behave like overlay",
                                description: "They look similar but behave VERY differently.",
                                fix: "Remember: ZStack size = UNION of all subviews"
                            )
                            
                            ZStackPitfallItem(
                                emoji: "3️⃣",
                                title: "Not constraining flexible views",
                                description: "Color in ZStack will expand to full proposal.",
                                fix: "Use .frame() to constrain if needed"
                            )
                            
                            ZStackPitfallItem(
                                emoji: "4️⃣",
                                title: "Forgetting about z-index",
                                description: "Later views in ZStack appear on top.",
                                fix: "Order matters! Or use .zIndex() modifier"
                            )
                            
                            ZStackPitfallItem(
                                emoji: "5️⃣",
                                title: "Alignment confusion",
                                description: "Alignment positions subviews, doesn't change ZStack size.",
                                fix: "ZStack size is always the union, regardless of alignment"
                            )
                        }
                    }
                })
                
                // MARK: - Decision Tree
                
                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("🌳 DECISION TREE")
                            .font(.headline)
                        
                        Text("When to use ZStack vs overlay/background:")
                            .font(.subheadline)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            DecisionTreeItem(
                                question: "Should the secondary view affect the layout?",
                                yes: "Use ZStack",
                                no: "Use overlay/background"
                            )
                            
                            DecisionTreeItem(
                                question: "Is the secondary view decorative (badge, border, shadow)?",
                                yes: "Use overlay/background",
                                no: "Consider ZStack"
                            )
                            
                            DecisionTreeItem(
                                question: "Do you want siblings to see the secondary view's size?",
                                yes: "Use ZStack",
                                no: "Use overlay/background"
                            )
                            
                            DecisionTreeItem(
                                question: "Are all subviews equally important to the layout?",
                                yes: "Use ZStack",
                                no: "Use overlay/background"
                            )
                        }
                        .font(.caption)
                    }
                })
                
                // MARK: - Quick Reference
                
                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("📚 QUICK REFERENCE")
                            .font(.headline)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            ZStackQuickRefItem(
                                term: "ZStack size",
                                definition: "UNION (bounding box) of all subviews' frames"
                            )
                            
                            ZStackQuickRefItem(
                                term: "Proposal",
                                definition: "Same size proposed to ALL subviews"
                            )
                            
                            ZStackQuickRefItem(
                                term: "vs overlay",
                                definition: "overlay = primary's size, ZStack = union of all"
                            )
                            
                            ZStackQuickRefItem(
                                term: "Alignment",
                                definition: "Positions subviews within the union (default: .center)"
                            )
                            
                            ZStackQuickRefItem(
                                term: "Z-order",
                                definition: "Later subviews appear on top (or use .zIndex())"
                            )
                            
                            ZStackQuickRefItem(
                                term: "Use for",
                                definition: "Layered content where all views matter to layout"
                            )
                            
                            ZStackQuickRefItem(
                                term: "Don't use for",
                                definition: "Badges, decorations (use overlay instead!)"
                            )
                        }
                        .font(.caption)
                    }
                }
                )
                .padding()
            }
            .navigationTitle("ZStack Layout")
        }
    }
}

// MARK: - Helper Views

struct ComparisonRow: View {
    let title: String
    let behavior: String
    let color: Color

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Circle()
                .fill(color)
                .frame(width: 8, height: 8)
                .padding(.top, 4)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .bold()
                Text(behavior)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct BadgeComparisonPoint: View {
    let emoji: String
    let title: String
    let detail: String
    let color: Color

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text(emoji)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .bold()
                    .foregroundColor(color)
                Text(detail)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct ZStackAlgorithmStep: View {
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

struct UnionExample: View {
    let subviews: [(name: String, size: String, color: String)]
    let union: String
    let explanation: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            ForEach(Array(subviews.enumerated()), id: \.offset) { index, subview in
                HStack(spacing: 8) {
                    Circle()
                        .fill(colorFromString(subview.color))
                        .frame(width: 8, height: 8)
                    Text("\(subview.name): \(subview.size)")
                        .font(.caption)
                }
            }

            Divider()

            HStack(spacing: 8) {
                Circle()
                    .fill(Color.green)
                    .frame(width: 8, height: 8)
                Text("Union: \(union)")
                    .font(.caption)
                    .bold()
                    .foregroundColor(.green)
            }

            Text(explanation)
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.leading, 16)
        }
        .padding(8)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(5)
    }

    private func colorFromString(_ string: String) -> Color {
        switch string {
        case "red": return .red
        case "blue": return .blue
        case "green": return .green
        case "orange": return .orange
        default: return .gray
        }
    }
}

struct ProposalComparisonRow: View {
    let container: String
    let behavior: String
    let fair: Bool

    var body: some View {
        HStack(spacing: 10) {
            Text(container + ":")
                .bold()
                .frame(width: 60, alignment: .leading)
            Text(behavior)
                .foregroundColor(.secondary)
            Spacer()
            if fair {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            }
        }
    }
}

struct AlignmentExample: View {
    let alignment: Alignment
    let alignmentName: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(alignmentName)
                .font(.caption)
                .foregroundColor(.secondary)

            ZStack(alignment: alignment) {
                Rectangle()
                    .fill(Color.teal.opacity(0.3))
                    .frame(width: 150, height: 100)

                Circle()
                    .fill(Color.orange)
                    .frame(width: 30, height: 30)
            }
            .border(Color.gray)
        }
    }
}

struct TableHeaderCell: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.caption)
            .bold()
            .frame(maxWidth: .infinity)
            .padding(8)
            .background(Color.gray.opacity(0.2))
    }
}

struct TableCell: View {
    let text: String
    var isRowHeader: Bool = false
    var color: Color = .primary

    var body: some View {
        Text(text)
            .font(.caption)
            .bold(isRowHeader)
            .foregroundColor(isRowHeader ? .primary : .secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)
            .background(isRowHeader ? Color.gray.opacity(0.1) : Color.clear)
    }
}

struct PracticalExample: View {
    let title: String
    let goodApproach: String
    let badApproach: String
    let code: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .bold()

            HStack(alignment: .top, spacing: 5) {
                Text("✅")
                Text(goodApproach)
                    .font(.caption)
                    .foregroundColor(.green)
            }

            HStack(alignment: .top, spacing: 5) {
                Text("❌")
                Text(badApproach)
                    .font(.caption)
                    .foregroundColor(.red)
            }

            Text(code)
                .font(.system(.caption2, design: .monospaced))
                .foregroundColor(.secondary)
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
        }
        .padding(10)
        .background(Color.gray.opacity(0.05))
        .cornerRadius(8)
    }
}

struct ZStackPitfallItem: View {
    let emoji: String
    let title: String
    let description: String
    let fix: String

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Text(emoji)
                .font(.caption)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .bold()

                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)

                HStack(spacing: 4) {
                    Text("Fix:")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.green)
                    Text(fix)
                        .font(.caption)
                        .foregroundColor(.green)
                }
            }
        }
    }
}

struct DecisionTreeItem: View {
    let question: String
    let yes: String
    let no: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("❓ " + question)
                .bold()

            HStack(spacing: 15) {
                HStack(spacing: 5) {
                    Text("✅ Yes →")
                        .foregroundColor(.green)
                    Text(yes)
                        .foregroundColor(.secondary)
                }

                HStack(spacing: 5) {
                    Text("❌ No →")
                        .foregroundColor(.red)
                    Text(no)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(8)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(5)
    }
}

struct ZStackQuickRefItem: View {
    let term: String
    let definition: String

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text(term + ":")
                .bold()
                .frame(minWidth: 80, alignment: .leading)
            Text(definition)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Extension for badge

extension View {
    func badge() -> some View {
        self
            .font(.caption2)
            .padding(4)
            .background(
                Circle()
                    .fill(Color.red)
            )
            .foregroundColor(.white)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        ZStackLayoutBehavior()
    }
}
