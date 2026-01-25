//
//  BuiltInAlignmentBasics.swift
//  ThinkingInSwiftUI
//
//  Built-in Alignments - Understanding the Alignment Negotiation Protocol
//

import SwiftUI

/// Understanding how alignment works through the negotiation protocol
/// between parent and child views.
///
/// KEY CONCEPTS:
/// - Alignment is a NEGOTIATION - parent asks child where its guides are
/// - Parent computes its own guide, child reports its guide
/// - Parent positions child using the difference
/// - Built-in guides: .leading, .center, .trailing, .top, .bottom, .firstTextBaseline, .lastTextBaseline
///
struct BuiltInAlignmentBasics: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Built-in Alignments")
                    .font(.title)
                    .bold()

                Text("Alignment is a negotiation between parent and child")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("How Alignment Works")
                            .font(.headline)

                        Text("The parent doesn't just place the child - it ASKS the child where its alignment guides are!")
                            .font(.caption)
                            .foregroundColor(.orange)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("1️⃣ Parent asks child: 'Where is your center?'")
                                .font(.caption)
                            Text("2️⃣ Child responds: 'My center is at (25, 10) in my coordinates'")
                                .font(.caption)
                            Text("3️⃣ Parent computes its own center: (50, 50)")
                                .font(.caption)
                            Text("4️⃣ Parent places child by taking difference: (50-25, 50-10) = (25, 40)")
                                .font(.caption)
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Built-in Alignment Guides")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("HorizontalAlignment:")
                                .font(.caption)
                                .bold()
                            Text("  • .leading")
                                .font(.caption2)
                            Text("  • .center")
                                .font(.caption2)
                            Text("  • .trailing")
                                .font(.caption2)

                            Text("VerticalAlignment:")
                                .font(.caption)
                                .bold()
                                .padding(.top, 4)
                            Text("  • .top")
                                .font(.caption2)
                            Text("  • .center")
                                .font(.caption2)
                            Text("  • .bottom")
                                .font(.caption2)
                            Text("  • .firstTextBaseline")
                                .font(.caption2)
                            Text("  • .lastTextBaseline")
                                .font(.caption2)

                            Text("Composite Alignment:")
                                .font(.caption)
                                .bold()
                                .padding(.top, 4)
                            Text("  • .topLeading, .topTrailing, .bottomLeading, .bottomTrailing, .center, etc.")
                                .font(.caption2)
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Which containers use which alignment?")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 6) {
                            Text("Two-dimensional (Alignment):")
                                .font(.caption)
                                .bold()
                            Text("  • .frame(alignment:) - both H & V")
                                .font(.caption2)
                            Text("  • ZStack(alignment:) - both H & V")
                                .font(.caption2)
                            Text("  • .overlay(alignment:) - both H & V")
                                .font(.caption2)
                            Text("  • .background(alignment:) - both H & V")
                                .font(.caption2)

                            Text("One-dimensional:")
                                .font(.caption)
                                .bold()
                                .padding(.top, 4)
                            Text("  • HStack(alignment:) - only VerticalAlignment")
                                .font(.caption2)
                            Text("  • VStack(alignment:) - only HorizontalAlignment")
                                .font(.caption2)
                        }
                    }
                })
            }
            .padding()
        }
    }
}

#Preview {
    BuiltInAlignmentBasics()
}
