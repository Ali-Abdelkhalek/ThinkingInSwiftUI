//
//  Shapes.swift
//  ThinkingInSwiftUI
//
//  Created by Ali Abdelkhalek on 09/02/2025.
//

import SwiftUI

struct shapes: View {
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.red)
                .padding()
            RoundedRectangle(cornerSize: CGSize(width: 15, height: 15))
                .fill(Color.green)
                .padding()
            Capsule(style: .continuous)
                .fill(Color.blue)
                .padding()
            Ellipse()
                .fill(Color.yellow)
                .padding()
        }
        
    }
}

#Preview {
    shapes()
}
