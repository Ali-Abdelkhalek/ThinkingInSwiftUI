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
                                .fill(Color(
                                    red: Double(index % 256) / 255.0,
                                    green: Double((index * 7) % 256) / 255.0,
                                    blue: Double((index * 13) % 256) / 255.0
                                ))
                                .onAppear { print("Cell for \(index) appeared") }
                        )
                }
            }
        }
    }
}

#Preview {
    ReuseDemo()
}
