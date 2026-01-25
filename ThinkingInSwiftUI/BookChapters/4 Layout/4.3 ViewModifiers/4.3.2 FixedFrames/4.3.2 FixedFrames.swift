//
//  FixedFrames.swift
//  ThinkingInSwiftUI
//
//  Chapter 4.3.2: Fixed Frames
//

import SwiftUI

struct FixedFramesView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                basicFixedFrameExample
                frameStackingExample
                alignmentExample
            }
            .padding()
        }
    }

    // MARK: - Examples

    private var basicFixedFrameExample: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Basic Fixed Frame")
                .font(.headline)
            Text("Sets exact width and height")
                .font(.caption)
                .foregroundColor(.secondary)

            Color(.blue)
                .frame(width: 200, height: 150)
                .border(Color.black, width: 2)
        }
    }

    private var frameStackingExample: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Frame Stacking")
                .font(.headline)
            Text("Multiple frames wrap each other")
                .font(.caption)
                .foregroundColor(.secondary)

            Text("Hello")
                .background(Color.gray)
                .frame(width: 150)
                .background(Color.green)
                .frame(width: 250)
                .background(Color.blue)
        }
    }

    private var alignmentExample: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Frame with Alignment")
                .font(.headline)
            Text("Control content position within frame")
                .font(.caption)
                .foregroundColor(.secondary)

            HStack(spacing: 15) {
                Text("Leading")
                    .frame(width: 100, height: 60, alignment: .leading)
                    .background(Color.orange)

                Text("Center")
                    .frame(width: 100, height: 60, alignment: .center)
                    .background(Color.purple)

                Text("Trailing")
                    .frame(width: 100, height: 60, alignment: .trailing)
                    .background(Color.pink)
            }
        }
    }
}

#Preview {
    FixedFramesView()
}
