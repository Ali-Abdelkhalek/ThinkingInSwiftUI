//
//  BasicScrollViewExample.swift
//  ThinkingInSwiftUI
//
//  ScrollView Basics
//

import SwiftUI

struct BasicScrollViewExample: View {
    var body: some View {
        ScrollView {
            Image(systemName: "folder")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("This is a longer text")
        }
        .border(Color.red)
    }
}

#Preview {
    BasicScrollViewExample()
}
