//
//  FitVsFillComparison.swift
//  ThinkingInSwiftUI
//
//  Compares .fit and .fill content modes
//

import SwiftUI

struct FitVsFillComparison: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: ".fit - Largest That Fits Inside",
                description: "Entire image visible, may leave empty space",
                code: ".aspectRatio(contentMode: .fit)"
            ) {
                VStack(spacing: 12) {
                    Color.blue
                        .overlay(
                            Text("200×60")
                                .font(.caption)
                                .foregroundColor(.white)
                        )
                        .frame(width: 200, height: 60)
                        .frame(width: 200, height: 200, alignment: .center)
                        .border(Color.red, width: 2)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Given: 200×200 container, 100×30 image")
                        Text("Result: 200×60 (fits inside, empty space above/below)")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: ".fill - Smallest That Covers Entire Area",
                description: "Fills container, image may be cropped",
                code: ".aspectRatio(contentMode: .fill)"
            ) {
                VStack(spacing: 12) {
                    Color.blue
                        .overlay(
                            Text("666×200")
                                .font(.caption)
                                .foregroundColor(.white)
                        )
                        .frame(width: 666, height: 200)
                        .frame(width: 200, height: 200)
                        .clipped()
                        .border(Color.red, width: 2)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Given: 200×200 container, 100×30 image")
                        Text("Result: 666×200 (covers area, sides cropped)")
                        Text("Note: Image is actually 666 wide but clipped to 200")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }

            VStack(alignment: .leading, spacing: 12) {
                Text("Calculation Comparison:")
                    .font(.headline)

                HStack(alignment: .top, spacing: 20) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(".fit")
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                        Text("Width: 200 → H = 60 ✅")
                        Text("Height: 200 → W = 666 ❌")
                        Text("Picks: 200×60")
                    }
                    .font(.caption)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(".fill")
                            .fontWeight(.semibold)
                            .foregroundColor(.orange)
                        Text("Width: 200 → H = 60 ❌")
                        Text("Height: 200 → W = 666 ✅")
                        Text("Picks: 666×200")
                    }
                    .font(.caption)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
        }
    }
}

#Preview {
    ScrollView {
        FitVsFillComparison()
            .padding()
    }
}
