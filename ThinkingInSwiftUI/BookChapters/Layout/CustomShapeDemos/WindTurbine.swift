//
//  X.swift
//  ThinkingInSwiftUI
//
//  Created by Ali Abdelkhalek on 09/02/2025.
//

import SwiftUI

import SwiftUI

struct WindTurbine: Shape {
    func path(in rect: CGRect) -> Path {
        Path { p in
            let center = rect[.init(x: 0.5, y: 0.3)]
            let baseCenter = rect[.init(x: 0.5, y: 1.0)]
            let towerWidth = rect.width * 0.05

            // 1️⃣ Draw Tower (Vertical Line)
            p.move(to: CGPoint(x: center.x - towerWidth / 2, y: center.y))
            p.addLine(to: CGPoint(x: center.x - towerWidth / 2, y: baseCenter.y))
            
            p.move(to: CGPoint(x: center.x + towerWidth / 2, y: center.y))
            p.addLine(to: CGPoint(x: center.x + towerWidth / 2, y: baseCenter.y))
            
            // 2️⃣ Draw Rotor Hub (Small Circle)
            p.addEllipse(in: CGRect(x: center.x - 10, y: center.y - 10, width: 20, height: 20))

            // 3️⃣ Draw Three Blades (Curved Lines)
            let bladeLength = rect.height * 0.25
            
            for angle in [0, 120, 240] {
                let radian = CGFloat(angle) * .pi / 180
                let bladeTip = CGPoint(
                    x: center.x + cos(radian) * bladeLength,
                    y: center.y + sin(radian) * bladeLength
                )
                
                let control1 = CGPoint(
                    x: center.x + cos(radian - 0.3) * (bladeLength * 0.6),
                    y: center.y + sin(radian - 0.3) * (bladeLength * 0.6)
                )
                
                let control2 = CGPoint(
                    x: center.x + cos(radian + 0.3) * (bladeLength * 0.6),
                    y: center.y + sin(radian + 0.3) * (bladeLength * 0.6)
                )

                // Disconnected Blades
                p.move(to: center)
                p.addCurve(to: bladeTip, control1: control1, control2: control2)
            }
        }
    }
}

#Preview {
    WindTurbine()
        .stroke(Color.blue, lineWidth: 3)
        .padding()
}
