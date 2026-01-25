//
//  KeyInsightSection.swift
//  ThinkingInSwiftUI
//
//  Explains the critical insight about why .resizable() is necessary
//

import SwiftUI

struct KeyInsightSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("⚠️ The Critical Insight - WHY .resizable() Matters:")
                .font(.headline)

            Text("By default, Images are NOT resizable - they IGNORE all proposals and stay at their natural size. You MUST use .resizable() to make the image accept proposals!")
                .font(.subheadline)
                .foregroundColor(.red)
                .padding()
                .background(Color.red.opacity(0.1))
                .cornerRadius(8)

            VStack(alignment: .leading, spacing: 12) {
                Text("Three Scenarios:")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                // Scenario 1: No resizable
                VStack(alignment: .leading, spacing: 4) {
                    Text("1️⃣ Image (natural: 600×180)")
                        .font(.caption)
                        .bold()
                    Text("   Container proposes: 200×200")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("   ❌ Image IGNORES proposal → stays 600×180 (OVERFLOWS!)")
                        .font(.caption)
                        .foregroundColor(.red)
                    Text("   Code: Image(\"header\")")
                        .font(.system(.caption2, design: .monospaced))
                        .foregroundColor(.secondary)
                }
                .padding(8)
                .background(Color.red.opacity(0.05))
                .cornerRadius(6)

                // Scenario 2: Resizable only
                VStack(alignment: .leading, spacing: 4) {
                    Text("2️⃣ Image.resizable() (natural: 600×180)")
                        .font(.caption)
                        .bold()
                    Text("   Container proposes: 200×200")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("   ⚠️ Image ACCEPTS full proposal → becomes 200×200 (DISTORTED!)")
                        .font(.caption)
                        .foregroundColor(.orange)
                    Text("   Code: Image(\"header\").resizable()")
                        .font(.system(.caption2, design: .monospaced))
                        .foregroundColor(.secondary)
                }
                .padding(8)
                .background(Color.orange.opacity(0.05))
                .cornerRadius(6)

                // Scenario 3: Resizable + aspectRatio
                VStack(alignment: .leading, spacing: 4) {
                    Text("3️⃣ Image.resizable().aspectRatio(.fit) (natural: 600×180)")
                        .font(.caption)
                        .bold()
                    Text("   Container proposes to aspectRatio: 200×200")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("   aspectRatio calculates & proposes to image: 200×60")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("   ✅ Image ACCEPTS filtered proposal → becomes 200×60 (PERFECT!)")
                        .font(.caption)
                        .foregroundColor(.green)
                    Text("   Code: Image(\"header\").resizable().aspectRatio(contentMode: .fit)")
                        .font(.system(.caption2, design: .monospaced))
                        .foregroundColor(.secondary)
                }
                .padding(8)
                .background(Color.green.opacity(0.05))
                .cornerRadius(6)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Hierarchy (Scenario 3):")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                hierarchyItem(level: 0, name: "Container", proposal: "→ 200×200")
                hierarchyItem(level: 1, name: "aspectRatio modifier", proposal: "→ 200×60 (calculated!)")
                hierarchyItem(level: 2, name: "resizable Image", proposal: "✓ accepts 200×60")
            }
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(8)

            Text("🎯 Bottom line: .resizable() makes the image ACCEPT proposals. .aspectRatio() FILTERS the proposal to maintain the ratio. You need BOTH!")
                .font(.subheadline)
                .foregroundColor(.blue)
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(8)
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
}

#Preview {
    ScrollView {
        KeyInsightSection()
            .padding()
    }
}
