//
//  List.swift
//  ThinkingInSwiftUI
//
//  Created by Ali Abdelkhalek on 07/04/2025.
//

import SwiftUI

struct ListExample: View {
    var body: some View {
        List(0..<10000, id: \.self) { i in
            Text("Item \(i)")
                .background(
                    Rectangle()
                        .fill(Color.random)
                        .onAppear { print("Cell for \(i) appeared") }
                )
        }
    }
}

#Preview {
    ListExample()
}

// Add this extension for testing (not production code!)
extension Color {
    static var random: Color {
        Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }
}
