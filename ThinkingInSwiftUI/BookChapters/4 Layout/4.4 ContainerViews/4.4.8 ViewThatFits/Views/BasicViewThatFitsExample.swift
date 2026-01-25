//
//  BasicViewThatFitsExample.swift
//  ThinkingInSwiftUI
//
//  ViewThatFits Basics
//

import SwiftUI

struct BasicViewThatFitsExample: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("ViewThatFits Basics")
                    .font(.title)
                    .bold()

                Text("Displays different views based on available space")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("How It Works")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("1️⃣ Proposes nil to each subview (asks for ideal size)")
                                .font(.caption)
                            Text("2️⃣ Picks FIRST subview whose ideal size fits")
                                .font(.caption)
                            Text("3️⃣ If none fit, picks LAST subview")
                                .font(.caption)
                            Text("4️⃣ Order matters - tries subviews in order!")
                                .font(.caption)
                                .foregroundColor(.orange)
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: Horizontal vs Vertical Layout")
                            .font(.headline)

                        Text("Try resizing the window to see it adapt:")
                            .font(.caption)

                        ViewThatFits {
                            // First option: Horizontal layout
                            HStack(spacing: 10) {
                                Text("Option 1")
                                    .padding()
                                    .background(Color.blue.opacity(0.3))
                                Text("Option 2")
                                    .padding()
                                    .background(Color.green.opacity(0.3))
                                Text("Option 3")
                                    .padding()
                                    .background(Color.orange.opacity(0.3))
                            }

                            // Second option: Vertical layout
                            VStack(spacing: 10) {
                                Text("Option 1")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue.opacity(0.3))
                                Text("Option 2")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.green.opacity(0.3))
                                Text("Option 3")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.orange.opacity(0.3))
                            }
                        }
                        .border(Color.gray)

                        Text("If HStack fits → shows horizontal layout")
                            .font(.caption2)
                            .foregroundColor(.blue)
                        Text("If HStack doesn't fit → shows vertical layout")
                            .font(.caption2)
                            .foregroundColor(.green)
                    }
                })
            }
            .padding()
        }
    }
}

#Preview {
    BasicViewThatFitsExample()
}
