//
//  ViewThatFitsHelpers.swift
//  ThinkingInSwiftUI
//
//  Helper views for ViewThatFits examples
//

import SwiftUI

struct ColorBox: View {
    let color: Color
    let label: String

    var body: some View {
        Text(label)
            .frame(width: 80, height: 80)
            .background(color.opacity(0.3))
            .cornerRadius(8)
    }
}

struct DashboardCard: View {
    let title: String
    let value: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .font(.title)
                .bold()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(color.opacity(0.2))
        .cornerRadius(8)
    }
}
