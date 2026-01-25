//
//  DividerSizing.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Divider - Sizing Details
//

import SwiftUI

struct DividerSizingView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Divider Sizing")
                    .font(.title)
                    .bold()

                outsideStacksSection
                proposingNilSection
                axisBehaviorSection
                visualTestSection
            }
            .padding()
        }
    }

    // MARK: - Sections

    private var outsideStacksSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Outside Stacks:")
                .font(.headline)

            Text("Accepts any WIDTH, reports HEIGHT of divider line")

            VStack(spacing: 10) {
                Divider()
                    .frame(width: 300)
                    .background(Color.red.opacity(0.3))

                Text("300pt wide divider")
                    .font(.caption)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
        }
    }

    private var proposingNilSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Proposing nil:")
                .font(.headline)

            Text("Results in default size of 10pt on flexible axis")

            Text("Example: In HStack with no proposed width, divider width ≈ 10pt")
                .font(.caption)
                .padding()
                .background(Color.yellow.opacity(0.3))
                .cornerRadius(5)
        }
    }

    private var axisBehaviorSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Axis Behavior:")
                .font(.headline)

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("VStack:")
                        .bold()
                    Text("Flexible width, fixed height")
                }

                HStack {
                    Text("HStack:")
                        .bold()
                    Text("Fixed width, flexible height")
                }

                HStack {
                    Text("Outside:")
                        .bold()
                    Text("Flexible width, fixed height")
                }
            }
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(8)
        }
    }

    private var visualTestSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Visual Test:")
                .font(.headline)

            HStack(spacing: 20) {
                VStack {
                    Text("VStack")
                        .font(.caption)
                    Divider()
                        .frame(height: 100)
                        .background(Color.red)
                }

                VStack {
                    Text("HStack")
                        .font(.caption)
                    HStack {
                        Divider()
                            .background(Color.blue)
                    }
                    .frame(height: 100)
                }
            }
            .padding()
            .border(Color.gray, width: 1)
        }
    }
}

#Preview {
    DividerSizingView()
}
