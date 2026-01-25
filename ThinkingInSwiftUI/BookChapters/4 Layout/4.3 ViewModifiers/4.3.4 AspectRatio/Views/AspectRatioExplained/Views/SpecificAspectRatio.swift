//
//  SpecificAspectRatio.swift
//  ThinkingInSwiftUI
//
//  Demonstrates specifying an explicit aspect ratio
//

import SwiftUI

struct SpecificAspectRatio: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Specifying Aspect Ratio Explicitly",
                description: "Force a specific ratio regardless of image's natural ratio",
                code: ".aspectRatio(4/3, contentMode: .fit)"
            ) {
                VStack(spacing: 12) {
                    Color.blue
                        .overlay(
                            Text("200×150")
                                .font(.caption)
                                .foregroundColor(.white)
                        )
                        .frame(width: 200, height: 150)
                        .frame(width: 200, height: 200)
                        .border(Color.red, width: 2)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Given: 200×200 container")
                        Text("Forced ratio: 4:3")
                        Text("Result: 200×150")
                        Text("\nNo probing for ideal size - uses specified ratio!")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Layout Steps (Specified Ratio)",
                description: "Simpler process - no probing needed",
                code: ""
            ) {
                VStack(alignment: .leading, spacing: 6) {
                    layoutStep("1", "aspectRatio receives proposal: 200×200")
                    layoutStep("2", "aspectRatio calculates: Fit 4:3 into 200×200 = 200×150")
                    layoutStep("3", "aspectRatio proposes 200×150 to Color")
                    layoutStep("4", "Color accepts and reports 200×150")
                    layoutStep("5", "aspectRatio reports 200×150")

                    Text("\nNo nil×nil proposal needed - ratio is explicitly given!")
                        .font(.caption)
                        .foregroundColor(.orange)
                }
                .font(.system(.caption, design: .monospaced))
            }
        }
    }
}

#Preview {
    ScrollView {
        SpecificAspectRatio()
            .padding()
    }
}
