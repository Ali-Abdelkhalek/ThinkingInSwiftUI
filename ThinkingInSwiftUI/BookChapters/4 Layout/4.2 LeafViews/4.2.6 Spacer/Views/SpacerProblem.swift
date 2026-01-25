//
//  SpacerProblem.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Spacer - Common Problem
//

import SwiftUI

struct SpacerProblemView: View {
    let longText = "This is some very long text that should wrap to multiple lines if given enough space to do so properly without truncation"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Spacer Alignment Problem")
                    .font(.title)
                    .bold()

                problematicApproachSection
                whyItHappensSection
            }
            .padding()
        }
    }

    // MARK: - Sections

    private var problematicApproachSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("⚠️ Common but PROBLEMATIC approach:")
                .font(.headline)
                .foregroundColor(.red)

            Text("Code:")
                .font(.subheadline)
                .bold()

            Text("HStack {\n  Spacer()\n  Text(\"...\")\n}")
                .font(.caption)
                .fontDesign(.monospaced)
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)

            Text("Result:")
                .font(.subheadline)
                .bold()

            HStack {
                Spacer()
                    .background(Color.red.opacity(0.2))
                Text(longText)
                    .background(Color.yellow.opacity(0.3))
            }
            .border(Color.red, width: 2)

            Text("❌ THE PROBLEM:")
                .font(.subheadline)
                .bold()
                .foregroundColor(.red)

            Text("Spacer has minimum length (≈16pt)\nText starts wrapping/truncating TOO SOON\nSpacer wastes valuable space!")
                .font(.caption)
                .foregroundColor(.red)
                .padding(8)
                .background(Color.red.opacity(0.1))
                .cornerRadius(5)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }

    private var whyItHappensSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Why this happens:")
                .font(.headline)

            Text("1. HStack proposes width to children")
            Text("2. Spacer takes minimum length (≈16pt)")
            Text("3. Text gets LESS space than available")
            Text("4. Text wraps earlier than necessary")

            HStack(spacing: 0) {
                Spacer(minLength: 0)
                    .background(Color.red.opacity(0.3))
                    .overlay(
                        Text("Spacer\nwastes\nspace")
                            .font(.caption)
                            .foregroundColor(.white)
                    )
                Text(longText)
                    .background(Color.yellow.opacity(0.3))
            }
            .border(Color.gray, width: 1)
        }
        .padding()
        .background(Color.orange.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    SpacerProblemView()
}
