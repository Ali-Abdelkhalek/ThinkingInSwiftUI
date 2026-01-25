//
//  BasicGeometryReaderExample.swift
//  ThinkingInSwiftUI
//
//  GeometryReader Basics - Showing Proposed Size
//

import SwiftUI

struct BasicGeometryReaderExample: View {
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading, spacing: 8) {
                Text("Size: \(Int(proxy.size.width)) × \(Int(proxy.size.height))")
                    .font(.headline)

                Text("Notice: Text is at top-leading (0, 0)")
                    .font(.caption)

                Text("GeometryReader accepts ALL proposed space")
                    .font(.caption)
            }
            .padding()
            .background(Color.blue.opacity(0.2))
        }
        .border(Color.red, width: 2)
    }
}

#Preview {
    BasicGeometryReaderExample()
}
