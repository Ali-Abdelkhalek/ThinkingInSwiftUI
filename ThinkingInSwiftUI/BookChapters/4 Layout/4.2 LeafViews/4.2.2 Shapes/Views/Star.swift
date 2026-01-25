//
//  Star.swift
//  ThinkingInSwiftUI
//
//  Created by Ali Abdelkhalek on 09/02/2025.
//

import SwiftUI

struct Star: Shape {
    func path(in rect: CGRect) -> Path {
        Path { p in
            let points: [UnitPoint] = [
                .init(x: 0.5, y: 0.0),  // Top
                .init(x: 0.61, y: 0.35),
                .init(x: 1.0, y: 0.38),
                .init(x: 0.69, y: 0.6),
                .init(x: 0.79, y: 1.0),
                .init(x: 0.5, y: 0.75),  // Bottom Middle
                .init(x: 0.21, y: 1.0),
                .init(x: 0.31, y: 0.6),
                .init(x: 0.0, y: 0.38),
                .init(x: 0.39, y: 0.35)
            ]
            
            p.addLines(points.map { rect[$0] }) // Map relative points to real CGRect positions
            p.closeSubpath()
        }
    }
}

struct StarDemo: View {
    var body: some View {
            VStack(spacing: 20) {
                Text("Star Shape")
                    .font(.title)
                    .bold()
                Spacer()
                
                Star()
                    .fill(Color.yellow)
                    .stroke(Color.orange, lineWidth: 3)
                    .frame(width: 200, height: 200)
                
                Spacer()
                Text("Custom star shape using UnitPoint coordinates")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
    }
}

#Preview {
    StarDemo()
}

