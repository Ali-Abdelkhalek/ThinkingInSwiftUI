//
//  Text.swift
//  ThinkingInSwiftUI
//
//  Created by Ali Abdelkhalek on 11/08/2025.
//

import SwiftUI

struct TextWithCircle: View {
    @State private var width: CGFloat? = nil
    var body: some View {
        Text("Hello, world")
            .background(GeometryReader { proxy in
                Color.clear.preference(key: WidthKey.self, value: proxy.size.width)
            })
            .onPreferenceChange(WidthKey.self) {
                self.width = $0
            }
            .frame(width: width, height: width)
            .background(Circle().fill(Color.blue))
    }
}

#Preview {
    ZStack {
        Color.gray
        TextWithCircle()
    }
}



struct WidthKey: PreferenceKey {
    static let defaultValue: CGFloat? = nil
    static func reduce(value: inout CGFloat?,
                       nextValue: () -> CGFloat?) {
        value = value ?? nextValue()
    }
}
