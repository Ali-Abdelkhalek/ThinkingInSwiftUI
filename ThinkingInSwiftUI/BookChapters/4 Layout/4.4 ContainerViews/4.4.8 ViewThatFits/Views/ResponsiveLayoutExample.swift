//
//  ResponsiveLayoutExample.swift
//  ThinkingInSwiftUI
//
//  ViewThatFits - Responsive Layouts
//

import SwiftUI

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
                            HStack(spacing: 10) {
                                ColorBox(color: .blue, label: "1")
                                ColorBox(color: .green, label: "2")
                                ColorBox(color: .orange, label: "3")
                            }

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
                            HStack(spacing: 15) {
                                DashboardCard(title: "Sales", value: "$1,234", color: .blue)
                                DashboardCard(title: "Users", value: "5,678", color: .green)
                            }

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

#Preview {
    ResponsiveLayoutExample()
}
