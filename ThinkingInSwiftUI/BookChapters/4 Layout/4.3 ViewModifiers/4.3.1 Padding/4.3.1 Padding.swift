//
//  Padding.swift
//  ThinkingInSwiftUI
//
//  Chapter 4.3.1: Padding Modifier
//

import SwiftUI

struct PaddingView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                uniformPaddingExample
                specificEdgePaddingExample
                multipleSidesPaddingExample
                paddingOrderMattersExample
            }
            .padding()
        }
    }

    // MARK: - Examples

    private var uniformPaddingExample: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Uniform Padding")
                .font(.headline)
            Text("Adds equal padding on all sides")
                .font(.caption)
                .foregroundColor(.secondary)

            Color(.blue)
                .frame(height: 100)
                .padding(50)
                .border(Color.black, width: 3)
        }
    }

    private var specificEdgePaddingExample: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Specific Edge Padding")
                .font(.headline)
            Text("Adds padding to one edge only")
                .font(.caption)
                .foregroundColor(.secondary)

            Color(.green)
                .frame(height: 100)
                .padding(.bottom, 50)
                .border(Color.black, width: 3)
        }
    }

    private var multipleSidesPaddingExample: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Horizontal/Vertical Padding")
                .font(.headline)
            Text("Adds padding to multiple edges at once")
                .font(.caption)
                .foregroundColor(.secondary)

            Color(.orange)
                .frame(height: 100)
                .padding(.horizontal, 40)
                .border(Color.black, width: 3)
        }
    }

    private var paddingOrderMattersExample: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Order Matters")
                .font(.headline)
            Text("Padding before vs after border")
                .font(.caption)
                .foregroundColor(.secondary)

            HStack(spacing: 20) {
                VStack(spacing: 5) {
                    Text("Padding → Border")
                        .font(.caption2)

                    Color(.red)
                        .frame(width: 80, height: 80)
                        .padding(10)
                        .border(Color.black, width: 2)
                }

                VStack(spacing: 5) {
                    Text("Border → Padding")
                        .font(.caption2)

                    Color(.red)
                        .frame(width: 80, height: 80)
                        .border(Color.black, width: 2)
                        .padding(10)
                }
            }
        }
    }
}

#Preview {
    PaddingView()
}
