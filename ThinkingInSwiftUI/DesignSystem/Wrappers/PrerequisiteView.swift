//
//  PrerequisiteView.swift
//  ThinkingInSwiftUI
//
//  Design System - Shows chapter prerequisites
//

import SwiftUI

struct PrerequisiteView: View {
    let requiredChapters: [Int]
    let message: String

    init(requiredChapters: [Int], message: String? = nil) {
        self.requiredChapters = requiredChapters
        self.message = message ?? "This chapter requires completion of previous chapters."
    }

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "info.circle.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)

            Text("Prerequisites")
                .font(.title2)
                .fontWeight(.bold)

            VStack(alignment: .leading, spacing: 12) {
                Text(message)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)

                if !requiredChapters.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Required Chapters:")
                            .font(.headline)

                        ForEach(requiredChapters, id: \.self) { chapter in
                            HStack {
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.green)
                                Text("Chapter \(chapter)")
                            }
                            .font(.body)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }
            }
            .padding(.horizontal, 40)

            Spacer()
        }
        .padding()
    }
}

// MARK: - Preview

#Preview("Prerequisite View") {
    PrerequisiteView(
        requiredChapters: [4, 5],
        message: "This chapter builds on Layout fundamentals and Preference Keys. Make sure you've completed Chapters 4 and 5 before continuing."
    )
}
