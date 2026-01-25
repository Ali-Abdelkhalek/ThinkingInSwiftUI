//
//  FixedSizeBadgeProblemSection.swift
//  ThinkingInSwiftUI
//
//  Shows the badge problem and how fixedSize() solves it
//

import SwiftUI

struct FixedSizeBadgeProblemSection: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "The Badge Problem",
                description: "overlay proposes primary's size to secondary",
                code: ""
            ) {
                VStack(spacing: 16) {
                    Text("The Problem:")
                        .font(.headline)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Without fixedSize in badge:")
                            .font(.caption)
                            .fontWeight(.semibold)

                        Text("Hi")
                            .badgeBroken {
                                Text("2023").font(.caption)
                            }

                        VStack(alignment: .leading, spacing: 4) {
                            Text("What happens:")
                                .fontWeight(.semibold)
                            Text("1. Text \"Hi\" size: ~16×17")
                            Text("2. overlay proposes 16×17 to badge")
                            Text("3. Badge \"2023\" forced into 16×17")
                            Text("4. Badge truncates: \"2...\"")
                        }
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(8)

                    Divider()

                    Text("The Solution:")
                        .font(.headline)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("With fixedSize in badge:")
                            .font(.caption)
                            .fontWeight(.semibold)

                        Text("Hi")
                            .badge {
                                Text("2023").font(.caption)
                            }

                        VStack(alignment: .leading, spacing: 4) {
                            Text("What happens:")
                                .fontWeight(.semibold)
                            Text("1. Text \"Hi\" size: ~16×17")
                            Text("2. overlay proposes 16×17 to badge")
                            Text("3. fixedSize() proposes nil×nil to \"2023\"")
                            Text("4. Badge becomes ideal size: ~35×15")
                            Text("5. Badge displays fully: \"2023\" ✓")
                        }
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(8)
                }
            }

            exampleCard(
                title: "Implementation Comparison",
                description: "The fix is just one line!",
                code: ""
            ) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("❌ Broken (badge truncates):")
                        .fontWeight(.semibold)
                        .foregroundColor(.red)

                    Text("""
                    func badgeBroken<Badge: View>(@ViewBuilder contents: () -> Badge) -> some View {
                        self.overlay(alignment: .topTrailing) {
                            contents()
                                .padding(3)
                                .background(RoundedRectangle(cornerRadius: 5).fill(.teal))
                        }
                    }
                    """)
                    .font(.system(.caption, design: .monospaced))
                    .padding(8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(4)

                    Divider()

                    Text("✅ Fixed (badge at ideal size):")
                        .fontWeight(.semibold)
                        .foregroundColor(.green)

                    Text("""
                    func badge<Badge: View>(@ViewBuilder contents: () -> Badge) -> some View {
                        self.overlay(alignment: .topTrailing) {
                            contents()
                                .padding(3)
                                .background(RoundedRectangle(cornerRadius: 5).fill(.teal))
                                .fixedSize()  // ← This is the fix!
                        }
                    }
                    """)
                    .font(.system(.caption, design: .monospaced))
                    .padding(8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(4)
                }
            }

            exampleCard(
                title: "Badge Works on Any View",
                description: "Now it sizes correctly on small and large views",
                code: ""
            ) {
                VStack(spacing: 16) {
                    VStack(spacing: 8) {
                        Text("Small view:")
                            .font(.caption)

                        Text("Hi")
                            .badge {
                                Text("2023").font(.caption)
                            }
                    }

                    VStack(spacing: 8) {
                        Text("Large view:")
                            .font(.caption)

                        Text("Messages")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .badge {
                                Text("99+").font(.caption)
                            }
                    }

                    Text("Badge is always its ideal size, regardless of view it's applied to!")
                        .font(.caption)
                        .foregroundColor(.green)
                        .multilineTextAlignment(.center)
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        FixedSizeBadgeProblemSection()
            .padding()
    }
}
