//
//  AspectRatioSandbox.swift
//  ThinkingInSwiftUI
//
//  Interactive sandbox for experimenting with aspectRatio modifier
//

import SwiftUI

struct AspectRatioSandbox: View {
    @State private var containerWidth: CGFloat = 200
    @State private var containerHeight: CGFloat = 200
    @State private var imageWidth: CGFloat = 100
    @State private var imageHeight: CGFloat = 30
    @State private var useAspectRatio = true
    @State private var contentMode: ContentMode = .fit

    enum ContentMode: String, CaseIterable {
        case fit = "Fit"
        case fill = "Fill"
    }

    var aspectRatio: CGFloat {
        imageWidth / imageHeight
    }

    var calculatedSize: (width: CGFloat, height: CGFloat) {
        if !useAspectRatio {
            return (containerWidth, containerHeight)
        }

        let ratio = imageWidth / imageHeight

        if contentMode == .fit {
            // Fit inside
            let widthBasedHeight = containerWidth / ratio
            let heightBasedWidth = containerHeight * ratio

            if widthBasedHeight <= containerHeight {
                return (containerWidth, widthBasedHeight)
            } else {
                return (heightBasedWidth, containerHeight)
            }
        } else {
            // Fill
            let widthBasedHeight = containerWidth / ratio
            let heightBasedWidth = containerHeight * ratio

            if widthBasedHeight >= containerHeight {
                return (containerWidth, widthBasedHeight)
            } else {
                return (heightBasedWidth, containerHeight)
            }
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("AspectRatio Interactive Sandbox")
                    .font(.title2)
                    .fontWeight(.bold)

                // Controls
                VStack(alignment: .leading, spacing: 16) {
                    Text("Container Size:")
                        .font(.headline)

                    HStack {
                        Text("Width: \(Int(containerWidth))")
                            .frame(width: 100)
                        Slider(value: $containerWidth, in: 100...300)
                    }

                    HStack {
                        Text("Height: \(Int(containerHeight))")
                            .frame(width: 100)
                        Slider(value: $containerHeight, in: 100...300)
                    }

                    Divider()

                    Text("Image Natural Size:")
                        .font(.headline)

                    HStack {
                        Text("Width: \(Int(imageWidth))")
                            .frame(width: 100)
                        Slider(value: $imageWidth, in: 50...200)
                    }

                    HStack {
                        Text("Height: \(Int(imageHeight))")
                            .frame(width: 100)
                        Slider(value: $imageHeight, in: 20...150)
                    }

                    Text("Aspect Ratio: \(String(format: "%.2f", aspectRatio)):1")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Divider()

                    Toggle("Use aspectRatio modifier", isOn: $useAspectRatio)

                    if useAspectRatio {
                        Picker("Content Mode", selection: $contentMode) {
                            ForEach(ContentMode.allCases, id: \.self) { mode in
                                Text(mode.rawValue).tag(mode)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)

                // Visual Result
                VStack(spacing: 12) {
                    Text("Result:")
                        .font(.headline)

                    ZStack {
                        Rectangle()
                            .stroke(Color.red, lineWidth: 2)
                            .frame(width: containerWidth, height: containerHeight)

                        Rectangle()
                            .fill(Color.blue)
                            .overlay(
                                Text("\(Int(calculatedSize.width))×\(Int(calculatedSize.height))")
                                    .foregroundColor(.white)
                                    .font(.caption)
                            )
                            .frame(width: calculatedSize.width, height: calculatedSize.height)
                            .clipped()
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Container: \(Int(containerWidth))×\(Int(containerHeight)) (red border)")
                        Text("Image natural: \(Int(imageWidth))×\(Int(imageHeight))")
                        Text("Result: \(Int(calculatedSize.width))×\(Int(calculatedSize.height)) (blue)")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }

                // Explanation
                VStack(alignment: .leading, spacing: 8) {
                    Text("What's Happening:")
                        .font(.headline)

                    if !useAspectRatio {
                        Text("Without aspectRatio: Image stretched to fill container (\(Int(containerWidth))×\(Int(containerHeight)))")
                    } else if contentMode == .fit {
                        Text("With .fit: Image scaled to fit inside while maintaining \(String(format: "%.2f", aspectRatio)):1 ratio")
                    } else {
                        Text("With .fill: Image scaled to cover container while maintaining \(String(format: "%.2f", aspectRatio)):1 ratio")
                    }
                }
                .font(.caption)
                .padding()
                .background(Color.yellow.opacity(0.1))
                .cornerRadius(8)
            }
            .padding()
        }
    }
}

#Preview {
    AspectRatioSandbox()
}
