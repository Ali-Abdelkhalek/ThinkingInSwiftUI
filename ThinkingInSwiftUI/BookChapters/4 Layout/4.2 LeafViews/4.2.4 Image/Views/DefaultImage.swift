//
//  DefaultImage.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Image - Default Behavior
//

import SwiftUI

struct DefaultImageView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Default Image")
                .font(.title)
                .bold()

            Text("Reports FIXED size (actual image dimensions)")
                .multilineTextAlignment(.center)
                .padding()
                .background(Color.yellow.opacity(0.3))
                .cornerRadius(8)

            // Default image in different containers
            VStack(alignment: .leading, spacing: 15) {
                Text("In 100x100 frame:")
                    .font(.headline)

                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .frame(width: 100, height: 100)
                    .border(Color.red, width: 2)

                Text("Image keeps its intrinsic size\n(ignores proposed 100x100)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)

            VStack(alignment: .leading, spacing: 15) {
                Text("In 200x50 frame:")
                    .font(.headline)

                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .frame(width: 200, height: 50)
                    .border(Color.red, width: 2)

                Text("Still keeps intrinsic size\n(doesn't stretch or distort)")
                    .font(.caption)
                    .foregroundColor(.gray)
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
    DefaultImageView()
}
