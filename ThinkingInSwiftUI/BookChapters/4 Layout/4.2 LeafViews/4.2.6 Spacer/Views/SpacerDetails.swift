//
//  SpacerDetails.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Spacer - Details
//

import SwiftUI

struct SpacerDetailsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Spacer Details")
                    .font(.title)
                    .bold()

                sizingBehaviorSection
                minimumLengthSection
                whenToUseSection
                proposedNilSection
            }
            .padding()
        }
    }

    // MARK: - Sections

    private var sizingBehaviorSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Sizing Behavior:")
                .font(.headline)

            Text("• Outside stacks: accepts any size (width & height)")
            Text("• In VStack: flexible height, zero width")
            Text("• In HStack: flexible width, zero height")
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(8)
    }

    private var minimumLengthSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Minimum Length:")
                .font(.headline)

            Text("Default minimum = default padding (≈16pt)")
                .padding(8)
                .background(Color.yellow.opacity(0.3))
                .cornerRadius(5)

            Text("Can override with minLength parameter:")
                .font(.subheadline)

            Text("Spacer(minLength: 0)")
                .font(.caption)
                .fontDesign(.monospaced)
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)

            HStack {
                Text("Left")
                    .background(Color.blue.opacity(0.3))
                Spacer(minLength: 0)
                    .background(Color.red.opacity(0.2))
                Text("Right")
                    .background(Color.green.opacity(0.3))
            }
            .border(Color.gray, width: 1)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }

    private var whenToUseSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("When to Use Spacer:")
                .font(.headline)

            HStack(alignment: .top) {
                Text("✅")
                Text("In stacks when you want flexible spacing")
            }
            HStack(alignment: .top) {
                Text("✅")
                Text("To push items to edges within stacks")
            }
            HStack(alignment: .top) {
                Text("❌")
                Text("For simple alignment (use .frame instead)")
            }
        }
        .padding()
        .background(Color.green.opacity(0.1))
        .cornerRadius(8)
    }

    private var proposedNilSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Proposed nil behavior:")
                .font(.headline)

            Text("When proposed size is nil (infinity), Spacer expands to fill available space up to its maximum")
                .font(.caption)
        }
        .padding()
        .background(Color.orange.opacity(0.1))
        .cornerRadius(8)
    }
}

#Preview {
    SpacerDetailsView()
}
