import SwiftUI

struct FlexibleFramesIntro: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Flexible frames use min/max/ideal parameters to create adaptive layouts:")
                .font(.subheadline)
                .foregroundColor(.secondary)

            VStack(alignment: .leading, spacing: 8) {
                Text("API Signature:")
                    .font(.headline)

                Text("""
                .frame(
                    minWidth: CGFloat? = nil,
                    idealWidth: CGFloat? = nil,
                    maxWidth: CGFloat? = nil,
                    minHeight: CGFloat? = nil,
                    idealHeight: CGFloat? = nil,
                    maxHeight: CGFloat? = nil,
                    alignment: Alignment = .center
                )
                """)
                    .font(.system(.caption, design: .monospaced))
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Key Concepts:")
                    .font(.headline)

                HStack(alignment: .top, spacing: 8) {
                    Text("•").fontWeight(.bold)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("minWidth/minHeight").font(.subheadline).fontWeight(.semibold)
                        Text("Minimum size the frame can be").font(.caption).foregroundColor(.secondary)
                    }
                    Spacer()
                }

                HStack(alignment: .top, spacing: 8) {
                    Text("•").fontWeight(.bold)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("maxWidth/maxHeight").font(.subheadline).fontWeight(.semibold)
                        Text("Maximum size the frame can be (use .infinity for unlimited)").font(.caption).foregroundColor(.secondary)
                    }
                    Spacer()
                }

                HStack(alignment: .top, spacing: 8) {
                    Text("•").fontWeight(.bold)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("idealWidth/idealHeight").font(.subheadline).fontWeight(.semibold)
                        Text("Preferred size when parent proposes nil").font(.caption).foregroundColor(.secondary)
                    }
                    Spacer()
                }

                HStack(alignment: .top, spacing: 8) {
                    Text("•").fontWeight(.bold)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("alignment").font(.subheadline).fontWeight(.semibold)
                        Text("How subview positions within extra space").font(.caption).foregroundColor(.secondary)
                    }
                    Spacer()
                }
            }

            VStack(alignment: .leading, spacing: 6) {
                Text("Unlike fixed frames:")
                    .font(.headline)

                HStack(alignment: .top, spacing: 8) {
                    Text("•")
                    Text("Flexible frames negotiate with parent's proposal")
                        .font(.subheadline)
                }

                HStack(alignment: .top, spacing: 8) {
                    Text("•")
                    Text("Can grow/shrink within min-max bounds")
                        .font(.subheadline)
                }

                HStack(alignment: .top, spacing: 8) {
                    Text("•")
                    Text("Subview size influences final frame size")
                        .font(.subheadline)
                }
            }

            Text("Example: .frame(minWidth: 100, maxWidth: 300)")
                .font(.headline)

            VStack(spacing: 10) {
                Text("Short")
                    .frame(minWidth: 100, maxWidth: 300)
                    .background(Color.blue.opacity(0.3))
                    .border(Color.blue, width: 2)

                Text("Medium Length Text")
                    .frame(minWidth: 100, maxWidth: 300)
                    .background(Color.blue.opacity(0.3))
                    .border(Color.blue, width: 2)

                Text("Very Long Text That Exceeds Maximum Width")
                    .frame(minWidth: 100, maxWidth: 300)
                    .background(Color.blue.opacity(0.3))
                    .border(Color.blue, width: 2)
            }

            Text("Notice: First text is at least 100pt, second wraps naturally, third caps at 300pt")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(8)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(6)
        }
        .padding()
        .background(Color.blue.opacity(0.05))
        .cornerRadius(12)
    }
}

#Preview {
    FlexibleFramesIntro()
}
