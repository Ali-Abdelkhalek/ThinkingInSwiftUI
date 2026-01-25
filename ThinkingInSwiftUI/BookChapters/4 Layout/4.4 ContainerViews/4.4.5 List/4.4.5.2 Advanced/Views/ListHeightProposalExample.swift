//
//  ListHeightProposalExample.swift
//  ThinkingInSwiftUI
//
//  List Advanced - Height Proposal Behavior (nil = unlimited)
//

import SwiftUI

struct ListHeightProposalExample: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("List proposes nil (unlimited) for height")
                .font(.headline)

            List {
                // Different height content - each determines its own height
                VStack(alignment: .leading, spacing: 8) {
                    Text("Small Item")
                        .font(.caption)
                }
                .padding(8)
                .background(Color.blue.opacity(0.2))

                VStack(alignment: .leading, spacing: 8) {
                    Text("Medium Item")
                        .font(.body)
                    Text("With subtitle")
                        .font(.caption)
                }
                .padding()
                .background(Color.green.opacity(0.2))

                VStack(alignment: .leading, spacing: 8) {
                    Text("Large Item")
                        .font(.title)
                    Text("With more content")
                    Text("And even more")
                    Text("Taking up space")
                }
                .padding()
                .background(Color.orange.opacity(0.2))
            }
            .frame(height: 400)
        }
        .padding()
    }
}

#Preview {
    ListHeightProposalExample()
}
