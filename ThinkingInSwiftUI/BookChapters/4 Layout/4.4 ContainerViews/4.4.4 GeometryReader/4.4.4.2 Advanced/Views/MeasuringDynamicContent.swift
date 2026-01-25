//
//  MeasuringDynamicContent.swift
//  ThinkingInSwiftUI
//
//  GeometryReader Advanced - Measuring Dynamic Content with PreferenceKeys
//

import SwiftUI

struct MeasuringDynamicContent: View {
    @State private var text = "Short"
    @State private var measuredSize: CGSize = .zero

    var body: some View {
        VStack(spacing: 20) {
            Text(text)
                .font(.title)
                .padding()
                .background(Color.blue.opacity(0.2))
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .preference(key: SizePreferenceKey.self, value: proxy.size)
                    }
                )
                .onPreferenceChange(SizePreferenceKey.self) { newSize in
                    measuredSize = newSize
                }

            Text("Measured Size: \(Int(measuredSize.width)) × \(Int(measuredSize.height))")
                .font(.caption)

            HStack {
                Button("Short") { text = "Short" }
                Button("Medium Length") { text = "Medium Length" }
                Button("Very Long Text Here") { text = "Very Long Text Here" }
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

// MARK: - Supporting Types

fileprivate struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

#Preview {
    MeasuringDynamicContent()
}
