import SwiftUI

/// Demonstrates Image sizing behavior: default vs resizable
struct ImageBehaviorDemo: View {
    var body: some View {
        TabView {
            DefaultImage()
                .tabItem { Label("Default", systemImage: "1.circle") }

            ResizableImage()
                .tabItem { Label("Resizable", systemImage: "2.circle") }

            AspectRatio()
                .tabItem { Label("Aspect", systemImage: "3.circle") }

            ResizingModes()
                .tabItem { Label("Modes", systemImage: "4.circle") }
        }
    }
}

// TAB 1: Default Image - reports fixed size
struct DefaultImage: View {
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

// TAB 2: Resizable Image - accepts any size (can distort)
struct ResizableImage: View {
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

// TAB 3: AspectRatio - prevents distortion
struct AspectRatio: View {
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

// TAB 4: Resizing modes - stretch vs tile
struct ResizingModes: View {
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
    ImageBehaviorDemo()
}
