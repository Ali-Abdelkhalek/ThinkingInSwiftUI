//
//  DemoBorder.swift
//  ThinkingInSwiftUI
//
//  Design System - Demo Border Component
//  Adds a consistent border around demo views
//

import SwiftUI

struct DemoBorder: ViewModifier {
    let color: Color
    let width: CGFloat
    let showLabel: Bool
    let label: String?

    init(color: Color = .blue, width: CGFloat = 2, showLabel: Bool = false, label: String? = nil) {
        self.color = color
        self.width = width
        self.showLabel = showLabel
        self.label = label
    }

    func body(content: Content) -> some View {
        content
            .border(color, width: width)
            .overlay(alignment: .topTrailing) {
                if showLabel, let label = label {
                    Text(label)
                        .font(.caption2)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(color)
                        .foregroundColor(.white)
                        .cornerRadius(4)
                        .offset(x: -4, y: 4)
                }
            }
    }
}

extension View {
    func demoBorder(
        color: Color = .blue,
        width: CGFloat = 2,
        showLabel: Bool = false,
        label: String? = nil
    ) -> some View {
        modifier(DemoBorder(color: color, width: width, showLabel: showLabel, label: label))
    }
}

// MARK: - Preview

#Preview("Demo Border") {
    VStack(spacing: 20) {
        Text("Simple Demo")
            .frame(width: 200, height: 100)
            .background(Color.blue.opacity(0.1))
            .demoBorder()

        Text("Labeled Demo")
            .frame(width: 200, height: 100)
            .background(Color.green.opacity(0.1))
            .demoBorder(color: .green, showLabel: true, label: "200×100")

        Text("Red Debug Border")
            .frame(width: 150, height: 80)
            .background(Color.red.opacity(0.1))
            .demoBorder(color: .red, width: 3, showLabel: true, label: "150×80")
    }
    .padding()
}
