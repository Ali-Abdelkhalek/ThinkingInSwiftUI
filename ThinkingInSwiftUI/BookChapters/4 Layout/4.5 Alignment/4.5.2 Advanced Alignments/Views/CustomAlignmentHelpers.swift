//
//  CustomAlignmentHelpers.swift
//  ThinkingInSwiftUI
//
//  Helper views and custom alignment definitions for Advanced Alignment examples
//

import SwiftUI

// MARK: - Circle Button

struct CircleButton: View {
    let symbol: String

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.blue.opacity(0.3))
            Image(systemName: symbol)
                .foregroundColor(.white)
        }
    }
}

// MARK: - Menu Alignment

struct MenuAlignment: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
        context.width / 2
    }
}

extension HorizontalAlignment {
    static let menu = HorizontalAlignment(MenuAlignment.self)
}

// MARK: - Decimal Point Alignment

struct DecimalAlignment: AlignmentID {
    static func defaultValue(in d: ViewDimensions) -> CGFloat {
        d[.trailing]
    }
}

extension HorizontalAlignment {
    static let decimalPoint = HorizontalAlignment(DecimalAlignment.self)
}

struct PriceText: View {
    let dollars: String
    let cents: String

    var body: some View {
        HStack(spacing: 0) {
            Text("$" + dollars)
            Text(".")
                .alignmentGuide(.decimalPoint) { d in d[.trailing] }
            Text(cents)
        }
        .font(.largeTitle)
    }
}

// MARK: - Message Alignment

struct MessageAlignment: AlignmentID {
    static func defaultValue(in d: ViewDimensions) -> CGFloat {
        d[VerticalAlignment.center]
    }
}

extension VerticalAlignment {
    static let messageAlignment = VerticalAlignment(MessageAlignment.self)
}

struct ChatMessageBad: View {
    let name: String
    let message: String
    let color: Color

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Circle()
                .fill(color.opacity(0.3))
                .frame(width: 30, height: 30)

            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .font(.caption)
                    .bold()
                Text(message)
            }
        }
    }
}

struct ChatMessage: View {
    let name: String
    let message: String
    let color: Color

    var body: some View {
        HStack(alignment: .messageAlignment, spacing: 10) {
            Circle()
                .fill(color.opacity(0.3))
                .frame(width: 30, height: 30)
                .alignmentGuide(.messageAlignment) { d in d[.top] + 15 }

            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .font(.caption)
                    .bold()
                Text(message)
                    .alignmentGuide(.messageAlignment) { d in d[.firstTextBaseline] }
            }
        }
    }
}
