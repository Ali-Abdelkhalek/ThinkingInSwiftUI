//
//  VisualComparisonSection.swift
//  ThinkingInSwiftUI
//
//  Visual comparison of three scenarios with aspect ratio
//

import SwiftUI

struct VisualComparisonSection: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("All three examples below have a natural image size of 600×180 in a 200×200 container:")
                .font(.subheadline)
                .foregroundColor(.secondary)

            VStack(spacing: 15) {
                // Scenario 1: No resizable
                HStack(spacing: 12) {
                    ZStack {
                        Rectangle()
                            .stroke(Color.red, lineWidth: 2)
                            .frame(width: 100, height: 100)

                        Rectangle()
                            .fill(Color.blue.opacity(0.3))
                            .overlay(
                                Text("600×180")
                                    .font(.caption2)
                                    .foregroundColor(.black)
                            )
                            .frame(width: 100, height: 30)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Image only")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.red)
                        Text("❌ Overflows container!")
                            .font(.caption2)
                            .foregroundColor(.red)
                        Text("Ignores 200×200 proposal")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .padding()
                .background(Color.red.opacity(0.05))
                .cornerRadius(8)

                // Scenario 2: Resizable only
                HStack(spacing: 12) {
                    Rectangle()
                        .fill(Color.blue.opacity(0.3))
                        .overlay(
                            Text("200×200")
                                .font(.caption2)
                                .foregroundColor(.black)
                        )
                        .frame(width: 100, height: 100)
                        .border(Color.red, width: 2)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(".resizable()")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.orange)
                        Text("⚠️ Distorted!")
                            .font(.caption2)
                            .foregroundColor(.orange)
                        Text("Accepts 200×200 proposal")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .padding()
                .background(Color.orange.opacity(0.05))
                .cornerRadius(8)

                // Scenario 3: Resizable + aspectRatio
                HStack(spacing: 12) {
                    ZStack {
                        Rectangle()
                            .stroke(Color.red, lineWidth: 2)
                            .frame(width: 100, height: 100)

                        Rectangle()
                            .fill(Color.blue.opacity(0.3))
                            .overlay(
                                Text("200×60")
                                    .font(.caption2)
                                    .foregroundColor(.black)
                            )
                            .frame(width: 100, height: 30)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(".resizable()")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                        Text(".aspectRatio(.fit)")
                            .font(.caption2)
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                        Text("✅ Perfect!")
                            .font(.caption2)
                            .foregroundColor(.green)
                        Text("Accepts 200×60 proposal")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .padding()
                .background(Color.green.opacity(0.05))
                .cornerRadius(8)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("What's happening:")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                HStack(alignment: .top, spacing: 10) {
                    Text("❌")
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Without .resizable(): Image ignores ALL proposals")
                            .font(.caption)
                        Text("→ Stays at 600×180, overflows the 200×200 container")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }

                HStack(alignment: .top, spacing: 10) {
                    Text("⚠️")
                    VStack(alignment: .leading, spacing: 2) {
                        Text("With .resizable() only: Image accepts FULL proposal")
                            .font(.caption)
                        Text("→ Becomes 200×200, aspect ratio broken (should be 3.33:1, now 1:1)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }

                HStack(alignment: .top, spacing: 10) {
                    Text("✅")
                    VStack(alignment: .leading, spacing: 2) {
                        Text("With .resizable() + .aspectRatio(): Image accepts FILTERED proposal")
                            .font(.caption)
                        Text("→ aspectRatio proposes 200×60 to maintain 3.33:1 ratio, image accepts it")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding()
            .background(Color.blue.opacity(0.05))
            .cornerRadius(8)
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
}

#Preview {
    ScrollView {
        VisualComparisonSection()
            .padding()
    }
}
