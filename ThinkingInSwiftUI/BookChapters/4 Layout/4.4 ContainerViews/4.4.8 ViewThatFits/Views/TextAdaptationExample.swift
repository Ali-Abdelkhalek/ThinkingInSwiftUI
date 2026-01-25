//
//  TextAdaptationExample.swift
//  ThinkingInSwiftUI
//
//  ViewThatFits - Text Adaptation
//

import SwiftUI

struct TextAdaptationExample: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Text Adaptation")
                    .font(.title)
                    .bold()

                Text("Adapting text display based on available space")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Multiple Text Lengths")
                            .font(.headline)

                        ViewThatFits {
                            Text("This is the full, complete, detailed description")
                                .padding()
                                .background(Color.blue.opacity(0.2))

                            Text("This is a shorter description")
                                .padding()
                                .background(Color.green.opacity(0.2))

                            Text("Short desc")
                                .padding()
                                .background(Color.orange.opacity(0.2))
                        }
                        .border(Color.gray)

                        Text("Order tried: Full → Shorter → Short")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Icon + Text vs Icon Only")
                            .font(.headline)

                        ViewThatFits {
                            HStack {
                                Image(systemName: "star.fill")
                                Text("Add to Favorites")
                            }
                            .padding()
                            .background(Color.blue.opacity(0.2))

                            HStack {
                                Image(systemName: "star.fill")
                                Text("Favorite")
                            }
                            .padding()
                            .background(Color.green.opacity(0.2))

                            Image(systemName: "star.fill")
                                .padding()
                                .background(Color.orange.opacity(0.2))
                        }
                        .border(Color.gray)

                        Text("Degrades gracefully: Full text → Short text → Icon only")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                })
            }
            .padding()
        }
    }
}

#Preview {
    TextAdaptationExample()
}
