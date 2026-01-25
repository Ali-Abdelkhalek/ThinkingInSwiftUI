//
//  ColorVsRectangle.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Color - Basics
//

import SwiftUI

struct ColorVsRectangleView: View {
    var body: some View {
        HStack(spacing: 0) {
            colorSide
            Divider()
            rectangleSide
        }
    }

    // MARK: - Sections

    private var colorSide: some View {
        VStack {
            Spacer()
            VStack(spacing: 10) {
                Text("Color")
                    .font(.title)
                    .bold()
                Text("BLEEDS")
                    .foregroundColor(.red)
                Text("into non-safe area")
                    .font(.caption)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.red)
    }

    private var rectangleSide: some View {
        VStack {
            Spacer()
            VStack(spacing: 10) {
                Text("Rectangle")
                    .font(.title)
                    .bold()
                Text("NO BLEED")
                    .foregroundColor(.blue)
                Text("Stops at safe area")
                    .font(.caption)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Rectangle().fill(Color.blue))
    }
}

#Preview {
    ColorVsRectangleView()
}
