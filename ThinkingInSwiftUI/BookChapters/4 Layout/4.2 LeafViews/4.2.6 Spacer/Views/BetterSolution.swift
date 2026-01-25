//
//  BetterSolution.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Spacer - Better Solution
//

import SwiftUI

struct BetterSolutionView: View {
    let longText = "This is some very long text that should wrap to multiple lines if given enough space to do so properly without truncation"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Better Solution")
                    .font(.title)
                    .bold()

                recommendedApproachSection
                comparisonSection
                allAlignmentsSection
            }
            .padding()
        }
    }

    // MARK: - Sections

    private var recommendedApproachSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("✅ RECOMMENDED approach:")
                .font(.headline)
                .foregroundColor(.green)

            Text("Code:")
                .font(.subheadline)
                .bold()

            Text("Text(\"...\")\n  .frame(maxWidth: .infinity,\n         alignment: .trailing)")
                .font(.caption)
                .fontDesign(.monospaced)
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)

            Text("Result:")
                .font(.subheadline)
                .bold()

            Text(longText)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .background(Color.green.opacity(0.3))
                .border(Color.green, width: 2)

            Text("✅ BENEFITS:")
                .font(.subheadline)
                .bold()
                .foregroundColor(.green)

            Text("No wasted space\nText uses ALL available width\nMore efficient layout")
                .font(.caption)
                .foregroundColor(.green)
                .padding(8)
                .background(Color.green.opacity(0.1))
                .cornerRadius(5)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }

    private var comparisonSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Side-by-side comparison:")
                .font(.headline)

            Group {
                Text("❌ HStack + Spacer:")
                    .font(.caption)
                    .bold()
                HStack {
                    Spacer()
                    Text(longText)
                }
                .border(Color.red, width: 2)
            }

            Group {
                Text("✅ .frame(maxWidth:alignment:):")
                    .font(.caption)
                    .bold()
                Text(longText)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .border(Color.green, width: 2)
            }

            Text("Notice: Green solution uses more width,\nwraps less, more efficient!")
                .font(.caption)
                .foregroundColor(.blue)
                .padding(8)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(5)
        }
        .padding()
        .background(Color.cyan.opacity(0.1))
        .cornerRadius(10)
    }

    private var allAlignmentsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Works for all alignments:")
                .font(.headline)

            Text("Leading (left):")
                .font(.caption)
            Text("Short text")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
                .background(Color.blue.opacity(0.2))

            Text("Center:")
                .font(.caption)
            Text("Short text")
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(8)
                .background(Color.yellow.opacity(0.2))

            Text("Trailing (right):")
                .font(.caption)
            Text("Short text")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(8)
                .background(Color.green.opacity(0.2))
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}

#Preview {
    BetterSolutionView()
}
