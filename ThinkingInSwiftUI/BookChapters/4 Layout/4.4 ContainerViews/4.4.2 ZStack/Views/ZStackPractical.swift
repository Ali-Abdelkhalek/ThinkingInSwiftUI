//
//  ZStackPractical.swift
//  ThinkingInSwiftUI
//
//  ZStack Practical - Examples, Pitfalls, and Quick Reference
//

import SwiftUI

// MARK: - ZStack Practical Examples

struct ZStackPractical: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
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
