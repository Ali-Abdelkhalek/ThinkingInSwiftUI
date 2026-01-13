//
//  ViewThatFits.swift
//  ThinkingInSwiftUI
//
//  Understanding ViewThatFits - Adaptive Layout Based on Proposed Size
//

import SwiftUI

// MARK: - ViewThatFits Concepts
//
// ViewThatFits displays different views depending on the proposed size.
//
// How it works:
// 1. Takes multiple subviews as alternatives
// 2. Proposes nil (asks for ideal size) to each subview
// 3. Displays the FIRST subview whose ideal size fits within the proposed size
// 4. If NONE fit, displays the LAST subview
//
// Key insight: Order matters! ViewThatFits tries subviews in order.

// MARK: - Basic Example

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

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Code Example")
                            .font(.headline)

                        Text("""
                        ViewThatFits {
                            HStack { /* wide layout */ }
                            VStack { /* narrow layout */ }
                        }
                        // Tries HStack first, falls back to VStack
                        """)
                        .font(.system(.caption, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                })
            }
            .padding()
        }
    }
}

// MARK: - Text Adaptation Example

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
                            // First: Icon with full text
                            HStack {
                                Image(systemName: "star.fill")
                                Text("Add to Favorites")
                            }
                            .padding()
                            .background(Color.blue.opacity(0.2))

                            // Second: Icon with short text
                            HStack {
                                Image(systemName: "star.fill")
                                Text("Favorite")
                            }
                            .padding()
                            .background(Color.green.opacity(0.2))

                            // Third: Icon only
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

// MARK: - Responsive Layout Example

struct ResponsiveLayoutExample: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Responsive Layouts")
                    .font(.title)
                    .bold()

                Text("Building responsive UIs with ViewThatFits")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Photo Gallery: 3 columns → 2 columns → 1 column")
                            .font(.headline)

                        ViewThatFits {
                            // First: 3 columns
                            HStack(spacing: 10) {
                                ColorBox(color: .blue, label: "1")
                                ColorBox(color: .green, label: "2")
                                ColorBox(color: .orange, label: "3")
                            }

                            // Second: 2 columns
                            HStack(spacing: 10) {
                                VStack(spacing: 10) {
                                    ColorBox(color: .blue, label: "1")
                                    ColorBox(color: .orange, label: "3")
                                }
                                VStack(spacing: 10) {
                                    ColorBox(color: .green, label: "2")
                                    Spacer()
                                        .frame(height: 80)
                                }
                            }

                            // Third: 1 column
                            VStack(spacing: 10) {
                                ColorBox(color: .blue, label: "1")
                                ColorBox(color: .green, label: "2")
                                ColorBox(color: .orange, label: "3")
                            }
                        }
                        .border(Color.gray)

                        Text("Automatically adapts to available width")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Dashboard: Side-by-side → Stacked")
                            .font(.headline)

                        ViewThatFits {
                            // First: Side by side
                            HStack(spacing: 15) {
                                DashboardCard(title: "Sales", value: "$1,234", color: .blue)
                                DashboardCard(title: "Users", value: "5,678", color: .green)
                            }

                            // Second: Stacked
                            VStack(spacing: 15) {
                                DashboardCard(title: "Sales", value: "$1,234", color: .blue)
                                DashboardCard(title: "Users", value: "5,678", color: .green)
                            }
                        }
                        .border(Color.gray)

                        Text("Desktop: side-by-side, Mobile: stacked")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                })
            }
            .padding()
        }
    }
}

// MARK: - Edge Cases

struct EdgeCasesExample: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Edge Cases & Gotchas")
                    .font(.title)
                    .bold()

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("⚠️ What if NONE fit?")
                            .font(.headline)

                        Text("ViewThatFits picks the LAST subview:")
                            .font(.caption)

                        ViewThatFits {
                            Text("This is way too long to fit in this tiny space")
                                .frame(width: 500)
                                .background(Color.blue.opacity(0.2))

                            Text("Still too long")
                                .frame(width: 400)
                                .background(Color.green.opacity(0.2))

                            Text("Last resort - might overflow!")
                                .background(Color.orange.opacity(0.2))
                        }
                        .frame(width: 150)
                        .border(Color.gray)

                        Text("↑ Neither 500pt nor 400pt fit in 150pt → shows last option")
                            .font(.caption2)
                            .foregroundColor(.orange)

                        Text("💡 Always make your LAST option the most compact/fallback")
                            .font(.caption)
                            .foregroundColor(.orange)
                            .padding(.top, 4)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Order Matters!")
                            .font(.headline)

                        Text("Wrong order - tries compact first:")
                            .font(.caption)
                            .foregroundColor(.red)

                        ViewThatFits {
                            // BAD: Compact option first
                            Text("Short")
                                .padding()
                                .background(Color.orange.opacity(0.2))

                            // This will NEVER be used (Short always fits first)
                            Text("This is a much longer detailed description")
                                .padding()
                                .background(Color.blue.opacity(0.2))
                        }
                        .border(Color.gray)

                        Text("↑ Always shows 'Short' because it fits first")
                            .font(.caption2)
                            .foregroundColor(.red)

                        Divider()

                        Text("Correct order - tries full first:")
                            .font(.caption)
                            .foregroundColor(.green)

                        ViewThatFits {
                            // GOOD: Full option first
                            Text("This is a much longer detailed description")
                                .padding()
                                .background(Color.blue.opacity(0.2))

                            // Fallback
                            Text("Short")
                                .padding()
                                .background(Color.orange.opacity(0.2))
                        }
                        .border(Color.gray)

                        Text("↑ Shows full text when it fits, short when it doesn't")
                            .font(.caption2)
                            .foregroundColor(.green)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Vertical Dimension")
                            .font(.headline)

                        Text("ViewThatFits works on BOTH width and height:")
                            .font(.caption)

                        VStack {
                            Text("Container with limited height:")
                                .font(.caption2)

                            ViewThatFits {
                                VStack(spacing: 8) {
                                    Text("Line 1")
                                    Text("Line 2")
                                    Text("Line 3")
                                    Text("Line 4")
                                }
                                .padding()
                                .background(Color.blue.opacity(0.2))

                                VStack(spacing: 8) {
                                    Text("Line 1")
                                    Text("Line 2")
                                }
                                .padding()
                                .background(Color.green.opacity(0.2))

                                Text("Compact")
                                    .padding()
                                    .background(Color.orange.opacity(0.2))
                            }
                            .frame(height: 80)
                            .border(Color.gray)
                        }

                        Text("Adapts based on available height too")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                })
            }
            .padding()
        }
    }
}

// MARK: - Practical Use Cases

struct PracticalUseCasesExample: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Practical Use Cases")
                    .font(.title)
                    .bold()

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("1. Toolbar Buttons")
                            .font(.headline)

                        ViewThatFits {
                            HStack {
                                Button("Export to PDF") { }
                                Button("Share") { }
                                Button("Print") { }
                            }
                            .buttonStyle(.bordered)

                            HStack {
                                Button("Export") { }
                                Button("Share") { }
                                Button("Print") { }
                            }
                            .buttonStyle(.bordered)

                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                Image(systemName: "square.and.arrow.up.on.square")
                                Image(systemName: "printer")
                            }
                        }
                        .border(Color.gray)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("2. Navigation Title")
                            .font(.headline)

                        ViewThatFits {
                            Text("User Profile Settings and Preferences")
                                .font(.largeTitle)
                                .bold()

                            Text("Profile Settings")
                                .font(.title)
                                .bold()

                            Text("Settings")
                                .font(.title2)
                                .bold()
                        }
                        .border(Color.gray)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("3. Form Layout")
                            .font(.headline)

                        ViewThatFits {
                            // Wide: Label and field side-by-side
                            HStack {
                                Text("Email Address:")
                                    .frame(width: 120, alignment: .trailing)
                                TextField("email@example.com", text: .constant(""))
                                    .textFieldStyle(.roundedBorder)
                            }

                            // Narrow: Stacked
                            VStack(alignment: .leading) {
                                Text("Email Address:")
                                TextField("email@example.com", text: .constant(""))
                                    .textFieldStyle(.roundedBorder)
                            }
                        }
                        .border(Color.gray)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Key Takeaways")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 6) {
                            Text("✓ Use for responsive layouts without GeometryReader")
                                .font(.caption)
                            Text("✓ Order from most spacious to most compact")
                                .font(.caption)
                            Text("✓ Last option is the fallback - make it compact")
                                .font(.caption)
                            Text("✓ Great for text truncation, icon-only fallbacks, layout changes")
                                .font(.caption)
                            Text("✗ Don't use for complex logic - keep it simple")
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                })
            }
            .padding()
        }
    }
}

// MARK: - Helper Views

struct ColorBox: View {
    let color: Color
    let label: String

    var body: some View {
        Text(label)
            .frame(width: 80, height: 80)
            .background(color.opacity(0.3))
            .cornerRadius(8)
    }
}

struct DashboardCard: View {
    let title: String
    let value: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .font(.title)
                .bold()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(color.opacity(0.2))
        .cornerRadius(8)
    }
}

// MARK: - Preview

#Preview {
    TabView {
        BasicViewThatFitsExample()
            .tabItem { Label("Basics", systemImage: "1.circle") }

        TextAdaptationExample()
            .tabItem { Label("Text Adaptation", systemImage: "2.circle") }

        ResponsiveLayoutExample()
            .tabItem { Label("Responsive", systemImage: "3.circle") }

        EdgeCasesExample()
            .tabItem { Label("Edge Cases", systemImage: "4.circle") }

        PracticalUseCasesExample()
            .tabItem { Label("Use Cases", systemImage: "5.circle") }
    }
}
