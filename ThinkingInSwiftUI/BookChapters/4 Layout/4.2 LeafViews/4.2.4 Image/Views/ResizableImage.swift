//
//  ResizableImage.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Image - Resizable
//

import SwiftUI

struct ResizableImageView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Resizable Image")
                .font(.title)
                .bold()

            Text("Accepts ANY size and fills it\n(can distort!)")
                .multilineTextAlignment(.center)
                .padding()
                .background(Color.orange.opacity(0.3))
                .cornerRadius(8)

            VStack(alignment: .leading, spacing: 15) {
                Text("In 100x100 frame:")
                    .font(.headline)

                Image(systemName: "star.fill")
                    .resizable()
                    .foregroundColor(.yellow)
                    .frame(width: 100, height: 100)
                    .border(Color.red, width: 2)

                Text("✓ Fills entire frame (square)")
                    .font(.caption)
                    .foregroundColor(.green)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)

            VStack(alignment: .leading, spacing: 15) {
                Text("In 200x50 frame:")
                    .font(.headline)

                Image(systemName: "star.fill")
                    .resizable()
                    .foregroundColor(.yellow)
                    .frame(width: 200, height: 50)
                    .border(Color.red, width: 2)

                Text("⚠️ DISTORTED (stretched wide)")
                    .font(.caption)
                    .foregroundColor(.red)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    ResizableImageView()
}
