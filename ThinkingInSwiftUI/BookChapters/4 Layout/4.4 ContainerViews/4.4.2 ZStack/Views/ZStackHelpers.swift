//
//  ZStackHelpers.swift
//  ThinkingInSwiftUI
//
//  Helper views for ZStack examples
//

import SwiftUI

// MARK: - Helper Views

struct ComparisonRow: View {
    let title: String
    let behavior: String
    let color: Color

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Circle()
                .fill(color)
                .frame(width: 8, height: 8)
                .padding(.top, 4)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .bold()
                Text(behavior)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct BadgeComparisonPoint: View {
    let emoji: String
    let title: String
    let detail: String
    let color: Color

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text(emoji)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .bold()
                    .foregroundColor(color)
                Text(detail)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct ZStackAlgorithmStep: View {
    let step: String
    let description: String
    let result: String

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text(step)
                .font(.caption)
                .bold()
                .foregroundColor(.white)
                .frame(width: 20, height: 20)
                .background(step == "✓" ? Color.green : Color.blue)
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 2) {
                Text(description)
                Text("→ \(result)")
                    .foregroundColor(.green)
            }
        }
    }
}

struct UnionExample: View {
    let subviews: [(name: String, size: String, color: String)]
    let union: String
    let explanation: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            ForEach(Array(subviews.enumerated()), id: \.offset) { index, subview in
                HStack(spacing: 8) {
                    Circle()
                        .fill(colorFromString(subview.color))
                        .frame(width: 8, height: 8)
                    Text("\(subview.name): \(subview.size)")
                        .font(.caption)
                }
            }

            Divider()

            HStack(spacing: 8) {
                Circle()
                    .fill(Color.green)
                    .frame(width: 8, height: 8)
                Text("Union: \(union)")
                    .font(.caption)
                    .bold()
                    .foregroundColor(.green)
            }

            Text(explanation)
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.leading, 16)
        }
        .padding(8)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(5)
    }

    private func colorFromString(_ string: String) -> Color {
        switch string {
        case "red": return .red
        case "blue": return .blue
        case "green": return .green
        case "orange": return .orange
        default: return .gray
        }
    }
}

struct ProposalComparisonRow: View {
    let container: String
    let behavior: String
    let fair: Bool

    var body: some View {
        HStack(spacing: 10) {
            Text(container + ":")
                .bold()
                .frame(width: 60, alignment: .leading)
            Text(behavior)
                .foregroundColor(.secondary)
            Spacer()
            if fair {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            }
        }
    }
}

struct AlignmentExample: View {
    let alignment: Alignment
    let alignmentName: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(alignmentName)
                .font(.caption)
                .foregroundColor(.secondary)

            ZStack(alignment: alignment) {
                Rectangle()
                    .fill(Color.teal.opacity(0.3))
                    .frame(width: 150, height: 100)

                Circle()
                    .fill(Color.orange)
                    .frame(width: 30, height: 30)
            }
            .border(Color.gray)
        }
    }
}

struct TableHeaderCell: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.caption)
            .bold()
            .frame(maxWidth: .infinity)
            .padding(8)
            .background(Color.gray.opacity(0.2))
    }
}

struct TableCell: View {
    let text: String
    var isRowHeader: Bool = false
    var color: Color = .primary

    var body: some View {
        Text(text)
            .font(.caption)
            .bold(isRowHeader)
            .foregroundColor(isRowHeader ? .primary : .secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)
            .background(isRowHeader ? Color.gray.opacity(0.1) : Color.clear)
    }
}

struct PracticalExample: View {
    let title: String
    let goodApproach: String
    let badApproach: String
    let code: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .bold()

            HStack(alignment: .top, spacing: 5) {
                Text("✅")
                Text(goodApproach)
                    .font(.caption)
                    .foregroundColor(.green)
            }

            HStack(alignment: .top, spacing: 5) {
                Text("❌")
                Text(badApproach)
                    .font(.caption)
                    .foregroundColor(.red)
            }

            Text(code)
                .font(.system(.caption2, design: .monospaced))
                .foregroundColor(.secondary)
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
        }
        .padding(10)
        .background(Color.gray.opacity(0.05))
        .cornerRadius(8)
    }
}

struct ZStackPitfallItem: View {
    let emoji: String
    let title: String
    let description: String
    let fix: String

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Text(emoji)
                .font(.caption)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .bold()

                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)

                HStack(spacing: 4) {
                    Text("Fix:")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.green)
                    Text(fix)
                        .font(.caption)
                        .foregroundColor(.green)
                }
            }
        }
    }
}

struct DecisionTreeItem: View {
    let question: String
    let yes: String
    let no: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("❓ " + question)
                .bold()

            HStack(spacing: 15) {
                HStack(spacing: 5) {
                    Text("✅ Yes →")
                        .foregroundColor(.green)
                    Text(yes)
                        .foregroundColor(.secondary)
                }

                HStack(spacing: 5) {
                    Text("❌ No →")
                        .foregroundColor(.red)
                    Text(no)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(8)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(5)
    }
}

struct ZStackQuickRefItem: View {
    let term: String
    let definition: String

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text(term + ":")
                .bold()
                .frame(minWidth: 80, alignment: .leading)
            Text(definition)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Extension for badge

extension View {
    func badge() -> some View {
        self
            .font(.caption2)
            .padding(4)
            .background(
                Circle()
                    .fill(Color.red)
            )
            .foregroundColor(.white)
    }
}

