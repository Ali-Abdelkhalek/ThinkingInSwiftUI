//
//  HStack.swift
//  ThinkingInSwiftUI
//
//  Created by Ali Abdelkhalek on 17/02/2025.
//
import SwiftUI
struct HStackView: View {
    var body: some View {
        HStack(spacing: 0) {
            Color.cyan
            Text("Hello, World!")
                .layoutPriority(1)
            Color.teal
        }
        .frame(width: 60)
    }
}

#Preview {
    HStackView()
}
