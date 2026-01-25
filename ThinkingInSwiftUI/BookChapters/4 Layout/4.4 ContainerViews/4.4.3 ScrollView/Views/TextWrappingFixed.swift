//
//  TextWrappingFixed.swift
//  ThinkingInSwiftUI
//
//  ScrollView - Text Wrapping Fixed
//
//  To fix this, we can add a .frame(maxWidth: .infinity) to our text. The same applies
//  to views other than Text that don't necessarily accept their proposed width.
//

import SwiftUI

struct TextWrappingFixed: View {
    var body: some View {
        ScrollView {
            Text("This is a longer text that might wrap and become narrower than the proposed width")
                .frame(maxWidth: .infinity)
        }
        .border(Color.red)
    }
}

#Preview {
    TextWrappingFixed()
}
