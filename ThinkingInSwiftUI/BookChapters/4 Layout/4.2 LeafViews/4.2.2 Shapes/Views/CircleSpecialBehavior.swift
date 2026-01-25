//
//  CircleSpecialBehavior.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Shapes - Circle Special Case
//

import SwiftUI

struct CircleSpecialBehaviorView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Circle Special Case")
                    .font(.title)
                    .bold()

                circleDifferenceSection
                examplesSection
                whyItMattersSection
            }
            .padding()
        }
    }

    // MARK: - Sections

    private var circleDifferenceSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("Circle is Different!")
                    .font(.headline)

                Text("""
                Unlike other shapes, Circle tries to become a SQUARE.

                When proposed a non-square size:
                • Takes the SMALLER dimension
                • Reports a square size
                • Draws a circle inscribed in that square

                Example:
                Proposed: 200×100
                Circle reports: 100×100 (uses smaller dimension)
                """)
                .font(.caption)
                .padding(8)
                .background(Color.orange.opacity(0.2))
                .cornerRadius(5)
            }
        }
    }

    private var examplesSection: some View {
        GroupBox("Examples: Circle vs Ellipse") {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Proposed: 200×100")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    HStack(spacing: 20) {
                        VStack {
                            Circle()
                                .fill(Color.red.opacity(0.7))
                                .frame(width: 200, height: 100)
                                .border(Color.black, width: 2)

                            Text("Circle\n100×100")
                                .font(.caption2)
                                .multilineTextAlignment(.center)
                        }

                        VStack {
                            Ellipse()
                                .fill(Color.blue.opacity(0.7))
                                .frame(width: 200, height: 100)
                                .border(Color.black, width: 2)

                            Text("Ellipse\n200×100")
                                .font(.caption2)
                                .multilineTextAlignment(.center)
                        }
                    }

                    Text("Circle takes smaller dimension (100), Ellipse takes all (200×100)")
                        .font(.caption2)
                        .foregroundColor(.green)
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Proposed: 100×200")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    HStack(spacing: 20) {
                        VStack {
                            Circle()
                                .fill(Color.red.opacity(0.7))
                                .frame(width: 100, height: 200)
                                .border(Color.black, width: 2)

                            Text("Circle\n100×100")
                                .font(.caption2)
                                .multilineTextAlignment(.center)
                        }

                        VStack {
                            Ellipse()
                                .fill(Color.blue.opacity(0.7))
                                .frame(width: 100, height: 200)
                                .border(Color.black, width: 2)

                            Text("Ellipse\n100×200")
                                .font(.caption2)
                                .multilineTextAlignment(.center)
                        }
                    }

                    Text("Circle takes smaller dimension (100), Ellipse stretches")
                        .font(.caption2)
                        .foregroundColor(.green)
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Proposed: 150×150")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    HStack(spacing: 20) {
                        VStack {
                            Circle()
                                .fill(Color.red.opacity(0.7))
                                .frame(width: 150, height: 150)
                                .border(Color.black, width: 2)

                            Text("Circle\n150×150")
                                .font(.caption2)
                                .multilineTextAlignment(.center)
                        }

                        VStack {
                            Ellipse()
                                .fill(Color.blue.opacity(0.7))
                                .frame(width: 150, height: 150)
                                .border(Color.black, width: 2)

                            Text("Ellipse\n150×150")
                                .font(.caption2)
                                .multilineTextAlignment(.center)
                        }
                    }

                    Text("When square, both are identical")
                        .font(.caption2)
                        .foregroundColor(.green)
                }
            }
            .padding()
        }
    }

    private var whyItMattersSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("Why This Matters")
                    .font(.headline)

                Text("""
                Understanding Circle's behavior helps with:

                • Avatar images in non-square frames
                • Icons in rectangular buttons
                • Profile pictures in list rows

                If you WANT an oval, use Ellipse!
                If you want a perfect circle, use Circle (it ensures square sizing).
                """)
                .font(.caption)
                .padding(8)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }
}

#Preview {
    CircleSpecialBehaviorView()
}
