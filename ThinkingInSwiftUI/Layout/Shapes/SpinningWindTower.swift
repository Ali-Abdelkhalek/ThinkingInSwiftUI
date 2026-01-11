//
//  SpiningWindTower.swift
//  ThinkingInSwiftUI
//
//  Created by Ali Abdelkhalek on 09/02/2025.
//

import SwiftUI

struct SpinningWindTurbine: View {
    @State private var angle: Double = 0 // Rotation angle for blades
    private let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect() // Runs every 50ms

    var body: some View {
        ZStack {
            // 1️⃣ Tower and Rotor Hub (STATIC)
            WindTurbineTower()
            
            // 2️⃣ Rotating Blades
            WindTurbineBlades(angle: $angle)
        }
        .onReceive(timer) { _ in
            angle = Double((3 + Int(angle)) % 360) // Rotate by 3 degrees per tick
        }
    }
}

// MARK: - Tower and Rotor Hub (Static)
struct WindTurbineTower: View {
    var body: some View {
        GeometryReader { geometry in
            Path { p in
                let rect = geometry.frame(in: .local)
                let center = rect[.init(x: 0.5, y: 0.3)]
                let baseCenter = rect[.init(x: 0.5, y: 1.0)]
                let towerWidth = rect.width * 0.05

                // Tower (Vertical Line)
                p.move(to: CGPoint(x: center.x - towerWidth / 2, y: center.y))
                p.addLine(to: CGPoint(x: center.x - towerWidth / 2, y: baseCenter.y))

                p.move(to: CGPoint(x: center.x + towerWidth / 2, y: center.y))
                p.addLine(to: CGPoint(x: center.x + towerWidth / 2, y: baseCenter.y))

                // Rotor Hub (Small Circle)
                p.addEllipse(in: CGRect(x: center.x - 10, y: center.y - 10, width: 20, height: 20))
            }
            .stroke(Color.blue, lineWidth: 3)
        }
    }
}

// MARK: - Blades (Rotating)
struct WindTurbineBlades: View {
    @Binding var angle: Double // Rotation angle in degrees
    
    var body: some View {
        GeometryReader { geometry in
            Path { p in
                let rect = geometry.frame(in: .local)
                let center = rect[.init(x: 0.5, y: 0.3)]
                let bladeLength = rect.height * 0.25

                for baseAngle in [0, 120, 240] {
                    // Convert base angle plus rotation angle to radians
                    let radian = CGFloat(Double(baseAngle) + angle) * .pi / 180
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

                    // Draw disconnected curved blades
                    p.move(to: center)
                    p.addCurve(to: bladeTip, control1: control1, control2: control2)
                }
            }
            .stroke(Color.blue, lineWidth: 3)
        }
    }
}

#Preview {
    SpinningWindTurbine()
        .padding()
}
