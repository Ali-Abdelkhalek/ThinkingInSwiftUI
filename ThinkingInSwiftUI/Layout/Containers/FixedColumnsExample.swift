//
//  FixedColumnsExample.swift
//  ThinkingInSwiftUI
//
//  Created by Ali Abdelkhalek on 08/04/2025.
//


import SwiftUI

struct FixedColumnsExample: View {
    let columns = [
        GridItem(.fixed(400)), // Fixed width column
        GridItem(.fixed(150)), // Another fixed width column
        GridItem(.fixed(50))   // Narrow fixed column
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(0..<20) { index in
                    Text("Item \(index)")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.blue.opacity(0.3))
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .border(Color.red)
    }
}

#Preview {
    FixedColumnsExample()
}
