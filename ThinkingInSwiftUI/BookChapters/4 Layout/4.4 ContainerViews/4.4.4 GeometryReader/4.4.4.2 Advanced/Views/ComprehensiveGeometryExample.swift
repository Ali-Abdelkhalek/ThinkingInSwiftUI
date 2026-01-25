//
//  ComprehensiveGeometryExample.swift
//  ThinkingInSwiftUI
//
//  GeometryReader Advanced - Reading Multiple Geometry Values
//

import SwiftUI

struct ComprehensiveGeometryExample: View {
    @State private var size: CGSize = .zero
    @State private var safeAreaInsets: EdgeInsets = EdgeInsets()
    @State private var globalFrame: CGRect = .zero

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    Group {
                        Text("GeometryProxy Information")
                            .font(.title)
                            .bold()

                        Divider()

                        Text("Size:")
                            .font(.headline)
                        Text("Width: \(Int(proxy.size.width))")
                        Text("Height: \(Int(proxy.size.height))")

                        Divider()

                        Text("Safe Area Insets:")
                            .font(.headline)
                        Text("Top: \(Int(proxy.safeAreaInsets.top))")
                        Text("Bottom: \(Int(proxy.safeAreaInsets.bottom))")
                        Text("Leading: \(Int(proxy.safeAreaInsets.leading))")
                        Text("Trailing: \(Int(proxy.safeAreaInsets.trailing))")
                    }

                    Divider()

                    Text("Global Frame:")
                        .font(.headline)
                    Text("Origin: (\(Int(proxy.frame(in: .global).origin.x)), \(Int(proxy.frame(in: .global).origin.y)))")
                    Text("Size: \(Int(proxy.frame(in: .global).width)) × \(Int(proxy.frame(in: .global).height))")
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .border(Color.red, width: 2)
    }
}

#Preview {
    ComprehensiveGeometryExample()
}
