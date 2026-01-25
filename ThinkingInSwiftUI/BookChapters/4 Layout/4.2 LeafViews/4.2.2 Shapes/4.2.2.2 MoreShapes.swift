//
//  4.2.3 MoreShapes.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - More Shapes
//  Wrapper view combining custom shape demos
//

import SwiftUI

struct MoreShapesView: View {
    var body: some View {
        TabView {
            StarDemo()
                .tabItem { Label("Star", systemImage: "1.circle") }

            WindTurbineDemo()
                .tabItem { Label("Wind Turbine", systemImage: "2.circle") }

            SpinningWindTowerDemo()
                .tabItem { Label("Spinning", systemImage: "3.circle") }
        }
    }
}

#Preview {
    MoreShapesView()
}
