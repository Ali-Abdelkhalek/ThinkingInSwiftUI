//
//  EdgeCasesExample.swift
//  ThinkingInSwiftUI
//
//  ViewThatFits - Edge Cases & Gotchas
//

import SwiftUI

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
                            Text("Short")
                                .padding()
                                .background(Color.orange.opacity(0.2))

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
                            Text("This is a much longer detailed description")
                                .padding()
                                .background(Color.blue.opacity(0.2))

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

#Preview {
    EdgeCasesExample()
}
