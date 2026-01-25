//
//  ResizingModes.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Image - Resizing Modes
//

import SwiftUI

struct ResizingModesView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Resizing Modes")
                    .font(.title)
                    .bold()

                Text("How the image fills the space")
                    .padding()
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(8)

                // Stretch mode (default)
                VStack(alignment: .leading, spacing: 15) {
                    Text(".resizable(resizingMode: .stretch)")
                        .font(.headline)
                        .fontDesign(.monospaced)

                    Image(systemName: "arrow.right")
                        .resizable(resizingMode: .stretch)
                        .foregroundColor(.blue)
                        .frame(width: 250, height: 100)
                        .border(Color.red, width: 2)

                    Text("Stretches to fill (default behavior)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)

                // Tile mode
                VStack(alignment: .leading, spacing: 15) {
                    Text(".resizable(resizingMode: .tile)")
                        .font(.headline)
                        .fontDesign(.monospaced)

                    Image(systemName: "arrow.right")
                        .resizable(resizingMode: .tile)
                        .foregroundColor(.blue)
                        .frame(width: 250, height: 100)
                        .border(Color.red, width: 2)

                    Text("Tiles/repeats the image at original size")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)

                // Cap insets example
                VStack(alignment: .leading, spacing: 15) {
                    Text("Cap Insets")
                        .font(.headline)

                    Text("Specify edges that shouldn't resize")
                        .font(.caption)

                    Text("Image(\"button\")\n  .resizable(capInsets: EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))")
                        .font(.caption)
                        .fontDesign(.monospaced)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)

                    Text("Useful for 9-slice scaling (e.g., button backgrounds)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
            }
            .padding()
        }
    }
}

#Preview {
    ResizingModesView()
}
