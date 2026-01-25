//
//  FixedSizeHorizontalVsVerticalSection.swift
//  ThinkingInSwiftUI
//
//  Shows the difference between horizontal and vertical fixedSize
//

import SwiftUI

struct FixedSizeHorizontalVsVerticalSection: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "fixedSize(horizontal:vertical:)",
                description: "Control which dimension becomes ideal size",
                code: ""
            ) {
                VStack(spacing: 16) {
                    // Both
                    VStack(alignment: .leading, spacing: 8) {
                        Text("fixedSize() - Both dimensions")
                            .font(.caption)
                            .fontWeight(.semibold)

                        Text("This is a longer text that will wrap normally")
                            .fixedSize()
                            .frame(width: 100, height: 50)
                            .background(Color.blue.opacity(0.2))
                            .border(Color.blue, width: 2)

                        Text("• Width: ideal (~250pt, overflows)")
                            .font(.caption)
                        Text("• Height: ideal (~17pt, one line)")
                            .font(.caption)
                    }

                    // Horizontal only
                    VStack(alignment: .leading, spacing: 8) {
                        Text("fixedSize(horizontal: true, vertical: false)")
                            .font(.caption)
                            .fontWeight(.semibold)

                        Text("This is a longer text that will wrap normally")
                            .fixedSize(horizontal: true, vertical: false)
                            .frame(width: 100, height: 50)
                            .background(Color.green.opacity(0.2))
                            .border(Color.green, width: 2)

                        Text("• Width: ideal (~250pt, overflows)")
                            .font(.caption)
                        Text("• Height: constrained (fits in 50pt)")
                            .font(.caption)
                    }

                    // Vertical only
                    VStack(alignment: .leading, spacing: 8) {
                        Text("fixedSize(horizontal: false, vertical: true)")
                            .font(.caption)
                            .fontWeight(.semibold)

                        Text("This is a longer text that will wrap normally")
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(width: 100, height: 50)
                            .background(Color.orange.opacity(0.2))
                            .border(Color.orange, width: 2)

                        Text("• Width: constrained (wraps at 100pt)")
                            .font(.caption)
                        Text("• Height: ideal (grows beyond 50pt!)")
                            .font(.caption)
                    }

                    Text("Use horizontal/vertical to control which dimension breaks free of constraints!")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.purple)
                        .multilineTextAlignment(.center)
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        FixedSizeHorizontalVsVerticalSection()
            .padding()
    }
}
