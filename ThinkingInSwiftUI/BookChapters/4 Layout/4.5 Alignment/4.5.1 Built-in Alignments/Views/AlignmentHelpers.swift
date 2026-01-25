//
//  AlignmentHelpers.swift
//  ThinkingInSwiftUI
//
//  Helper views for Built-in Alignment examples
//

import SwiftUI

// MARK: - Frame Alignment Demo

struct FrameAlignmentDemo: View {
    let alignment: Alignment
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            Text("Hello")
                .font(.caption2)
                .background(Color.blue.opacity(0.2))
                .frame(width: 80, height: 60, alignment: alignment)
                .border(Color.gray)

            Text(label)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - ZStack Alignment Demo

struct ZStackAlignmentDemo: View {
    let alignment: Alignment
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            ZStack(alignment: alignment) {
                Rectangle()
                    .fill(Color.teal.opacity(0.3))
                    .frame(width: 40, height: 40)
                Text("Hi")
                    .font(.caption2)
                    .background(Color.yellow.opacity(0.5))
            }
            .frame(width: 80, height: 60)
            .border(Color.gray)

            Text(label)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}
