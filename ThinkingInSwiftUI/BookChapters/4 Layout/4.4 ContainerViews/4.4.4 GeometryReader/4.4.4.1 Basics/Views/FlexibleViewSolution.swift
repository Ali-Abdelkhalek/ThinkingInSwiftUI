//
//  FlexibleViewSolution.swift
//  ThinkingInSwiftUI
//
//  GeometryReader Basics - Wrapping Flexible Views
//

import SwiftUI

/// When we wrap a completely flexible view (like ScrollView) inside a GeometryReader,
/// it won't affect the layout because the flexible view accepts the proposed size anyway.
struct FlexibleViewSolution: View {
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 20) {
                    Text("ScrollView Size: \(Int(proxy.size.width)) × \(Int(proxy.size.height))")
                        .font(.headline)
                        .padding()
                        .background(Color.blue.opacity(0.2))

                    ForEach(0..<20) { i in
                        Text("Item \(i)")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                    }
                }
                .padding()
            }
        }
        .border(Color.red, width: 2)
    }
}

#Preview {
    FlexibleViewSolution()
}
