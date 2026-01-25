//
//  ListWidthProposalExample.swift
//  ThinkingInSwiftUI
//
//  List Basics - Width Proposal Behavior
//

import SwiftUI

struct ListWidthProposalExample: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("List proposes its width to children")
                .font(.headline)

            List {
                // Text accepts the proposed width
                Text("Short")
                    .background(Color.blue.opacity(0.2))

                // This also gets the full width
                Text("This is a much longer text that demonstrates width")
                    .background(Color.green.opacity(0.2))

                // Even shapes get the proposed width (but need explicit height)
                Rectangle()
                    .fill(Color.orange.opacity(0.3))
                    .frame(height: 50)
            }
            .frame(height: 300)
        }
        .padding()
    }
}

#Preview {
    ListWidthProposalExample()
}
