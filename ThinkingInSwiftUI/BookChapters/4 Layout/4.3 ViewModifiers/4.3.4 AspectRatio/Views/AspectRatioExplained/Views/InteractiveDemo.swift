//
//  InteractiveDemo.swift
//  ThinkingInSwiftUI
//
//  Interactive demonstration comparing with and without aspectRatio
//

import SwiftUI

struct InteractiveDemo: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Try It Out:")
                .font(.headline)

            HStack(spacing: 20) {
                VStack(spacing: 8) {
                    Text("Without aspectRatio")
                        .font(.caption)
                        .fontWeight(.semibold)

                    Rectangle()
                        .fill(Color.blue)
                        .overlay(Text("Distorted").foregroundColor(.white))
                        .frame(width: 150, height: 150)
                        .border(Color.red, width: 2)

                    Text("150×150")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                VStack(spacing: 8) {
                    Text("With .fit")
                        .font(.caption)
                        .fontWeight(.semibold)

                    Rectangle()
                        .fill(Color.blue)
                        .overlay(Text("Perfect!").foregroundColor(.white))
                        .aspectRatio(3.33, contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .border(Color.red, width: 2)

                    Text("150×45")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Text("Both are proposed 150×150, but aspectRatio modifier changes what the inner view receives!")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding()
                .background(Color.yellow.opacity(0.1))
                .cornerRadius(8)
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
}

#Preview {
    InteractiveDemo()
}
