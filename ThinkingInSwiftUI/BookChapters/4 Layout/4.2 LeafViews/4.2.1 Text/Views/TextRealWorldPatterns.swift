//
//  TextRealWorldPatterns.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Text - Real-World Patterns
//

import SwiftUI

struct TextRealWorldPatternsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Real-World Patterns")
                    .font(.title)
                    .bold()

                multilineLabelsPattern
                singleLinePattern
                adaptiveSizingPattern
                fixedHeightPreviewPattern
                summarySection
            }
            .padding()
        }
    }

    // MARK: - Sections

    private var multilineLabelsPattern: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("Pattern 1: Multiline Labels")
                    .font(.headline)

                Text("""
                Problem: Labels in forms should wrap, not truncate

                Solution:
                Text("Long descriptive label")
                    .fixedSize(horizontal: false, vertical: true)

                Allows vertical expansion, constrains horizontal
                """)
                .font(.caption)
                .padding(8)
                .background(Color.green.opacity(0.1))
                .cornerRadius(5)

                VStack(alignment: .leading) {
                    Text("User Agreement")
                        .font(.caption)
                    Text("I agree to the terms and conditions and privacy policy of this application.")
                        .font(.caption2)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
            }
        }
    }

    private var singleLinePattern: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("Pattern 2: Guaranteed Single Line")
                    .font(.headline)

                Text("""
                Problem: Want text on single line, truncate if needed

                Solution:
                Text("Long text here")
                    .lineLimit(1)

                Perfect for list cells, headers, badges
                """)
                .font(.caption)
                .padding(8)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(5)

                HStack {
                    Image(systemName: "person.circle.fill")
                        .font(.largeTitle)
                    VStack(alignment: .leading) {
                        Text("User Name That Could Be Very Long")
                            .lineLimit(1)
                            .font(.headline)
                        Text("Subtitle")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
            }
        }
    }

    private var adaptiveSizingPattern: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("Pattern 3: Adaptive Sizing")
                    .font(.headline)

                Text("""
                Problem: Button text should scale down if needed

                Solution:
                Button("Action") { }
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)

                Scales font down to 70% before truncating
                """)
                .font(.caption)
                .padding(8)
                .background(Color.orange.opacity(0.1))
                .cornerRadius(5)

                Button(action: {}) {
                    Text("Very Long Button Title")
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                        .frame(maxWidth: 150)
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }

    private var fixedHeightPreviewPattern: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("Pattern 4: Fixed Height Preview")
                    .font(.headline)

                Text("""
                Problem: Show preview of long text with consistent height

                Solution:
                Text(longContent)
                    .lineLimit(3)
                    .truncationMode(.tail)

                Always 3 lines max, truncates rest
                """)
                .font(.caption)
                .padding(8)
                .background(Color.purple.opacity(0.1))
                .cornerRadius(5)

                VStack(alignment: .leading) {
                    Text("Article Title")
                        .font(.headline)
                    Text("SwiftUI is radically different from UIKit. In this short book, we will help you build a mental model of how SwiftUI works. We explain the most important concepts in detail and help you build a solid foundation.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                        .truncationMode(.tail)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
            }
        }
    }

    private var summarySection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("Summary: Text Modifiers")
                    .font(.headline)

                VStack(alignment: .leading, spacing: 6) {
                    Text("• .lineLimit(n) - Limit lines")
                    Text("• .lineLimit(n, reservesSpace: true) - Reserve space")
                    Text("• .truncationMode(.tail/.head/.middle) - Where to truncate")
                    Text("• .minimumScaleFactor(0.x) - Allow font scaling")
                    Text("• .fixedSize() - Ideal size (no wrapping)")
                    Text("• .fixedSize(horizontal: false, vertical: true) - Directional")
                }
                .font(.caption)
                .padding(8)
                .background(Color.gray.opacity(0.05))
                .cornerRadius(5)
            }
        }
    }
}

#Preview {
    TextRealWorldPatternsView()
}
