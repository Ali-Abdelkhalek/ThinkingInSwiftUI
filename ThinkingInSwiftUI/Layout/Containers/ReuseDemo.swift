//
//  ReuseDemo.swift
//  ThinkingInSwiftUI
//
//  Created by Ali Abdelkhalek on 07/04/2025.
//


import SwiftUI

struct ReuseDemo: View {
    @State private var activeInstances = Set<UUID>()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                // Test cells
                ForEach(0..<10000, id: \.self) { index in
                    Text("Item \(index)")
                        .background(
                            Rectangle()
                                .fill(Color.random)
                                .onAppear { print("Cell for \(index) appeared") }
                        )
                }
            }
        }
    }
}
