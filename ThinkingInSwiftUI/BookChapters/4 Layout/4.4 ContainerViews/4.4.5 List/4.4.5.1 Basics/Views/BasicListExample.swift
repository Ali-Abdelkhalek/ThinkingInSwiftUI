//
//  BasicListExample.swift
//  ThinkingInSwiftUI
//
//  List Basics - Basic List Layout Behavior
//

import SwiftUI

struct BasicListExample: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("List accepts the proposed size")
                .font(.headline)

            List(0..<20, id: \.self) { i in
                Text("Item \(i)")
            }
            .border(Color.red, width: 2)
        }
        .padding()
    }
}

#Preview {
    BasicListExample()
}
