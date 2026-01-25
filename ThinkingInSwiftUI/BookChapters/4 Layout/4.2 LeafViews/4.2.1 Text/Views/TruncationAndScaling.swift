//
//  TruncationAndScaling.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Text - truncationMode & minimumScaleFactor
//

import SwiftUI

struct TruncationAndScalingView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("truncationMode & minimumScaleFactor")
                    .font(.title)
                    .bold()

                truncationModeBasicsSection
                truncationModeExamplesSection
                minimumScaleFactorBasicsSection
                minimumScaleFactorExamplesSection
            }
            .padding()
        }
    }

    // MARK: - Sections

    private var truncationModeBasicsSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text(".truncationMode(_ mode:)")
                    .font(.headline)

                Text("""
                Controls WHERE truncation happens:

                .head → ...ld!
                .middle → Hel...ld! (default)
                .tail → Hello...
                """)
                .font(.caption)
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }

    private var truncationModeExamplesSection: some View {
        GroupBox("truncationMode Examples") {
            VStack(spacing: 15) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(".truncationMode(.head)")
                        .font(.caption)
                        .bold()

                    Text("SwiftUI is radically different from UIKit. In this short book, we will help you build a mental model.")
                        .lineLimit(1)
                        .truncationMode(.head)
                        .padding()
                        .border(Color.red, width: 2)
                }

                VStack(alignment: .leading, spacing: 5) {
                    Text(".truncationMode(.middle)")
                        .font(.caption)
                        .bold()

                    Text("SwiftUI is radically different from UIKit. In this short book, we will help you build a mental model.")
                        .lineLimit(1)
                        .truncationMode(.middle)
                        .padding()
                        .border(Color.orange, width: 2)
                }

                VStack(alignment: .leading, spacing: 5) {
                    Text(".truncationMode(.tail)")
                        .font(.caption)
                        .bold()

                    Text("SwiftUI is radically different from UIKit. In this short book, we will help you build a mental model.")
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .padding()
                        .border(Color.blue, width: 2)
                }
            }
            .padding()
        }
    }

    private var minimumScaleFactorBasicsSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text(".minimumScaleFactor(_ factor:)")
                    .font(.headline)

                Text("""
                Allows Text to scale font size DOWN to fit into proposed size.

                Factor range: 0.0 to 1.0
                • 1.0 = No scaling (default)
                • 0.5 = Can scale down to 50% of original size
                • 0.1 = Can scale down to 10% (very small!)

                Text tries to fit by scaling before truncating.
                """)
                .font(.caption)
                .padding(8)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }

    private var minimumScaleFactorExamplesSection: some View {
        GroupBox("minimumScaleFactor Example") {
            VStack(spacing: 15) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Without minimumScaleFactor")
                        .font(.caption)
                        .bold()

                    Text("SwiftUI is radically different from UIKit. In this short book, we will help you build a mental model of how SwiftUI works.")
                        .lineLimit(3)
                        .padding()
                        .border(Color.black, width: 2)

                    Text("Normal size, might truncate")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }

                VStack(alignment: .leading, spacing: 5) {
                    Text(".minimumScaleFactor(0.4)")
                        .font(.caption)
                        .bold()

                    Text("SwiftUI is radically different from UIKit. In this short book, we will help you build a mental model of how SwiftUI works.")
                        .lineLimit(3)
                        .minimumScaleFactor(0.4)
                        .padding()
                        .border(Color.black, width: 2)
                        .background(Color.cyan.opacity(0.2))

                    Text("Scales down to fit more text!")
                        .font(.caption2)
                        .foregroundColor(.green)
                }
            }
            .padding()
        }
    }
}

#Preview {
    TruncationAndScalingView()
}
