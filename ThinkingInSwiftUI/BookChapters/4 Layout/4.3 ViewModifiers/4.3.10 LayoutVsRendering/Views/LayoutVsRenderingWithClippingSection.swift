//
//  LayoutVsRenderingWithClippingSection.swift
//  ThinkingInSwiftUI
//
//  Shows layout with clipping
//

import SwiftUI

struct LayoutVsRenderingWithClippingSection: View {
    var body: some View {
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
}

#Preview {
    ScrollView {
        LayoutVsRenderingWithClippingSection()
            .padding()
    }
}
