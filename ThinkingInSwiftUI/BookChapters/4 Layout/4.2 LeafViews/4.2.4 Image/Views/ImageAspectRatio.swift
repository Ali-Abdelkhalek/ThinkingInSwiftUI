//
//  AspectRatio.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Image - Aspect Ratio
//

import SwiftUI

struct ImageAspectRatioView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Aspect Ratio")
                    .font(.title)
                    .bold()

                Text("Prevents distortion by maintaining proportions")
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.green.opacity(0.3))
                    .cornerRadius(8)

                // .fit mode
                VStack(alignment: .leading, spacing: 15) {
                    Text(".aspectRatio(contentMode: .fit)")
                        .font(.headline)
                        .fontDesign(.monospaced)

                    Image(systemName: "star.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.yellow)
                        .frame(width: 200, height: 100)
                        .border(Color.red, width: 2)

                    Text("Fits inside frame, maintains aspect ratio")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)

                // .fill mode
                VStack(alignment: .leading, spacing: 15) {
                    Text(".aspectRatio(contentMode: .fill)")
                        .font(.headline)
                        .fontDesign(.monospaced)

                    Image(systemName: "star.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .foregroundColor(.yellow)
                        .frame(width: 200, height: 100)
                        .clipped()
                        .border(Color.red, width: 2)

                    Text("Fills entire frame, maintains aspect ratio\n(may clip)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)

                // .scaledToFit() shorthand
                VStack(alignment: .leading, spacing: 15) {
                    Text(".scaledToFit() - shorthand for .fit")
                        .font(.headline)
                        .fontDesign(.monospaced)

                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.yellow)
                        .frame(width: 150, height: 150)
                        .border(Color.red, width: 2)

                    Text("Commonly used shorthand")
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
    ImageAspectRatioView()
}
