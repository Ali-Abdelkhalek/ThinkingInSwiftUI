//
//  LayoutProcessBreakdown.swift
//  ThinkingInSwiftUI
//
//  Step-by-step breakdown of the layout process with aspectRatio
//

import SwiftUI

struct LayoutProcessBreakdown: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Complete Layout Process",
                description: "Step-by-step with aspectRatio modifier",
                code: "Image(\"header\").resizable().aspectRatio(contentMode: .fit)"
            ) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Step 1: Initial Proposal")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                    layoutDetail("Container → aspectRatio", "200×200")

                    Divider()

                    Text("Step 2: Probe for Ideal Size")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                    layoutDetail("aspectRatio → Image", "nil×nil (What's your ideal size?)")
                    layoutDetail("Image → aspectRatio", "100×30 (my ideal size)")

                    Divider()

                    Text("Step 3: Calculate Constrained Size")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                    layoutDetail("aspectRatio calculates", "Aspect ratio = 100/30")
                    layoutDetail("aspectRatio calculates", "Fit 100:30 ratio into 200×200 = 200×60")

                    Divider()

                    Text("Step 4: Propose Constrained Size")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                    layoutDetail("aspectRatio → Image", "200×60")
                    layoutDetail("Image → aspectRatio", "200×60 (accepted!)")

                    Divider()

                    Text("Step 5: Report Final Size")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                    layoutDetail("aspectRatio → Container", "200×60")
                }
                .padding()
                .background(Color.blue.opacity(0.05))
                .cornerRadius(8)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Key Takeaway:")
                    .font(.headline)

                Text("The resizable image DOES accept the proposed size - it's just that the aspectRatio modifier proposes a different (smaller) size than what it received from the container!")
                    .font(.subheadline)
                    .foregroundColor(.orange)
            }
            .padding()
            .background(Color.orange.opacity(0.1))
            .cornerRadius(8)
        }
    }
}

#Preview {
    ScrollView {
        LayoutProcessBreakdown()
            .padding()
    }
}
