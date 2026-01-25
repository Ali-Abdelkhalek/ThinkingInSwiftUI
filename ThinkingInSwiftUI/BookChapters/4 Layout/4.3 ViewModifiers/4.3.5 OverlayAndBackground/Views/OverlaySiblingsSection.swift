//
//  OverlaySiblingsSection.swift
//  ThinkingInSwiftUI
//
//  Demonstrates that siblings don't move when background/overlay changes
//

import SwiftUI

struct OverlaySiblingsSection: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Siblings Don't Move When Background Changes",
                description: "Reported size is ALWAYS primary's size",
                code: ""
            ) {
                SiblingsDemo()
            }

            exampleCard(
                title: "Why Siblings Don't Move",
                description: "Understanding the layout contract",
                code: ""
            ) {
                VStack(alignment: .leading, spacing: 12) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("The Contract:")
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)

                        Text("• background/overlay ALWAYS reports primary's size")
                        Text("• Secondary size is completely ignored")
                        Text("• Parent sees: \"This view is X×Y\"")
                        Text("• Even if secondary is larger/smaller")
                    }
                    .font(.caption)

                    Divider()

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Example:")
                            .fontWeight(.semibold)
                            .foregroundColor(.orange)

                        Text("Text(\"Hi\").background(Color.orange.padding(-10))")
                            .font(.system(.caption, design: .monospaced))

                        Text("• Text: 20×17")
                        Text("• Background with padding(-10): 40×37")
                        Text("• Reported to parent: 20×17 (text's size!)")
                        Text("• Sibling positioned at 20pt mark")
                    }
                    .font(.caption)

                    Text("This is why the .highlight() modifier doesn't affect layout!")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                        .padding(.top, 4)
                }
            }
        }
    }
}

// MARK: - Siblings Demo

struct SiblingsDemo: View {
    @State private var highlightEnabled = false

    var body: some View {
        VStack(spacing: 16) {
            Toggle("Enable Highlight", isOn: $highlightEnabled)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)

            VStack(spacing: 12) {
                Text("Watch the siblings:")
                    .font(.caption)
                    .fontWeight(.semibold)

                HStack(spacing: 0) {
                    Text("Before")
                        .padding(8)
                        .background(Color.gray.opacity(0.2))

                    Text("Target")
                        .padding(8)
                        .highlight(enabled: highlightEnabled)
                        .background(Color.gray.opacity(0.2))

                    Text("After")
                        .padding(8)
                        .background(Color.gray.opacity(0.2))
                }
                .border(Color.blue, width: 2)

                Text(highlightEnabled ?
                    "Orange background bleeds out, but siblings stay put!" :
                    "Toggle to see - siblings won't move!"
                )
                .font(.caption)
                .foregroundColor(highlightEnabled ? .orange : .secondary)
                .multilineTextAlignment(.center)
            }
        }
    }
}

#Preview {
    ScrollView {
        OverlaySiblingsSection()
            .padding()
    }
}
