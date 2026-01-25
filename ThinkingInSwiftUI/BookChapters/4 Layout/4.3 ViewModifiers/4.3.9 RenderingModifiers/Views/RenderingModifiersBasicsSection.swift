//
//  RenderingModifiersBasicsSection.swift
//  ThinkingInSwiftUI
//
//  Basic concepts of rendering modifiers
//

import SwiftUI

struct RenderingModifiersBasicsSection: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Rendering Modifiers")
                    .font(.title)
                    .bold()

                Text("Modifiers that affect rendering but NOT layout")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("What Are Rendering Modifiers?")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("• Affect how a view is DRAWN on screen")
                                .font(.caption)
                            Text("• Do NOT affect layout calculations")
                                .font(.caption)
                            Text("• Do NOT change the view's frame or position in layout")
                                .font(.caption)
                            Text("• Like CGContext transformations - visual only")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }

                        Text("Common rendering modifiers:")
                            .font(.caption)
                            .bold()
                            .padding(.top, 8)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("• .offset(x:y:) - translates rendering position")
                                .font(.caption2)
                            Text("• .rotationEffect(_:) - rotates around anchor")
                                .font(.caption2)
                            Text("• .scaleEffect(_:) - scales up/down")
                                .font(.caption2)
                            Text("• .blur(radius:) - adds blur effect")
                                .font(.caption2)
                            Text("• .opacity(_:) - changes transparency")
                                .font(.caption2)
                            Text("• .shadow(radius:x:y:) - adds drop shadow")
                                .font(.caption2)
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Key Insight: Layout Position ≠ Rendering Position")
                            .font(.headline)

                        Text("The red border shows the LAYOUT position (where SwiftUI thinks it is)")
                            .font(.caption)
                            .foregroundColor(.red)

                        Text("The view renders elsewhere, but layout siblings don't know!")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                })
            }
            .padding()
        }
    }
}

#Preview {
    RenderingModifiersBasicsSection()
}
