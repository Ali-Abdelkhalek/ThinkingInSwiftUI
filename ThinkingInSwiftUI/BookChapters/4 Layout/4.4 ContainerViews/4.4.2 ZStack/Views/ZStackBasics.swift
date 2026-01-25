//
//  ZStackBasics.swift
//  ThinkingInSwiftUI
//
//  ZStack Basics - Understanding ZStack Layout
//

import SwiftUI

// MARK: - ZStack Basics

struct ZStackBasics: View {
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
                
            }
            .padding()
        }
    }
}
