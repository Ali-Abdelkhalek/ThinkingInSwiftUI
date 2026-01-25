//
//  ShapeInScrollViewFixed.swift
//  ThinkingInSwiftUI
//
//  ScrollView - Shape Behavior Fixed & Complete Example
//
//  If we want to change this, we can specify an explicit height using .frame(height:)
//  or .frame(idealHeight:), or we could use .aspectRatio.
//

import SwiftUI

struct ShapeInScrollViewFixed: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // MARK: - Simple Shape Fix

                VStack(spacing: 15) {
                    Text("Fixed Shapes")
                        .font(.headline)

                    Rectangle()
                        .fill(Color.blue)
                        .frame(height: 200)

                    Circle()
                        .fill(Color.green)
                        .frame(idealHeight: 150)

                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.orange)
                        .aspectRatio(2, contentMode: .fit)
                }

                Divider()

                // MARK: - Complete Example

                VStack(spacing: 20) {
                    Text("Scroll View Layout Demo")
                        .font(.title)
                        .frame(maxWidth: .infinity)

                    Image(systemName: "folder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 100)

                    Text("This text has maxWidth: .infinity applied so it takes the full proposed width")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.yellow.opacity(0.3))

                    Rectangle()
                        .fill(Color.blue)
                        .frame(height: 150)

                    Text("Without maxWidth, this text might become narrower than the scroll view if it wraps")
                        .padding()
                        .background(Color.green.opacity(0.3))

                    Circle()
                        .fill(Color.purple)
                        .frame(idealHeight: 120)
                }
            }
            .padding()
        }
        .border(Color.red)
    }
}

#Preview {
    ShapeInScrollViewFixed()
}
