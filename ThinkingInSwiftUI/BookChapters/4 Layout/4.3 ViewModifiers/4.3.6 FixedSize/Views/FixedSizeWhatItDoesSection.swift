//
//  FixedSizeWhatItDoesSection.swift
//  ThinkingInSwiftUI
//
//  Explains what fixedSize() does to the proposal chain
//

import SwiftUI

struct FixedSizeWhatItDoesSection: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "The Proposal Flow",
                description: "How fixedSize() changes the proposal chain",
                code: ""
            ) {
                VStack(spacing: 16) {
                    // Without fixedSize
                    VStack(alignment: .leading, spacing: 8) {
                        Text("WITHOUT fixedSize():")
                            .fontWeight(.semibold)
                            .foregroundColor(.red)

                        VStack(alignment: .leading, spacing: 4) {
                            proposalStep("1", "Parent → Text: 100×50", .blue)
                            proposalStep("2", "Text wraps/truncates to fit 100×50", .blue)
                            proposalStep("3", "Text → Parent: 100×30 (wrapped)", .blue)
                        }
                    }
                    .padding()
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(8)

                    // With fixedSize
                    VStack(alignment: .leading, spacing: 8) {
                        Text("WITH fixedSize():")
                            .fontWeight(.semibold)
                            .foregroundColor(.green)

                        VStack(alignment: .leading, spacing: 4) {
                            proposalStep("1", "Parent → fixedSize: 100×50", .green)
                            proposalStep("2", "fixedSize ignores and proposes nil×nil → Text", .green)
                            proposalStep("3", "Text becomes ideal size: 200×17", .green)
                            proposalStep("4", "fixedSize → Parent: 200×17", .green)
                        }
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(8)

                    Text("Key: fixedSize() breaks the constraint chain and lets child be ideal size!")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.orange)
                        .multilineTextAlignment(.center)
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        FixedSizeWhatItDoesSection()
            .padding()
    }
}
