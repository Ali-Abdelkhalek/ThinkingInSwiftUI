//
//  AspectRatioExplained.swift
//  ThinkingInSwiftUI
//
//  Understanding the aspectRatio modifier and why resizable images
//  don't just stretch to fill the entire proposed size
//

import SwiftUI

struct AspectRatioExplained: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                sectionHeader("Understanding aspectRatio Modifier")

                keyInsightSection

                sectionHeader("Visual Comparison: Why .resizable() is Critical")

                visualComparisonSection

                sectionHeader("1. The Problem: Distorted Images")

                distortedImageExample

                sectionHeader("2. The Solution: aspectRatio Modifier")

                aspectRatioSolution

                sectionHeader("3. Layout Process Breakdown")

                layoutProcessBreakdown

                sectionHeader("4. contentMode: .fit vs .fill")

                fitVsFillComparison

                sectionHeader("5. With Specific Aspect Ratio")

                specificAspectRatio

                sectionHeader("6. Interactive Demo")

                interactiveDemo
            }
            .padding()
        }
    }

    // MARK: - Key Insight

    private var keyInsightSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("⚠️ The Critical Insight - WHY .resizable() Matters:")
                .font(.headline)

            Text("By default, Images are NOT resizable - they IGNORE all proposals and stay at their natural size. You MUST use .resizable() to make the image accept proposals!")
                .font(.subheadline)
                .foregroundColor(.red)
                .padding()
                .background(Color.red.opacity(0.1))
                .cornerRadius(8)

            VStack(alignment: .leading, spacing: 12) {
                Text("Three Scenarios:")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                // Scenario 1: No resizable
                VStack(alignment: .leading, spacing: 4) {
                    Text("1️⃣ Image (natural: 600×180)")
                        .font(.caption)
                        .bold()
                    Text("   Container proposes: 200×200")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("   ❌ Image IGNORES proposal → stays 600×180 (OVERFLOWS!)")
                        .font(.caption)
                        .foregroundColor(.red)
                    Text("   Code: Image(\"header\")")
                        .font(.system(.caption2, design: .monospaced))
                        .foregroundColor(.secondary)
                }
                .padding(8)
                .background(Color.red.opacity(0.05))
                .cornerRadius(6)

                // Scenario 2: Resizable only
                VStack(alignment: .leading, spacing: 4) {
                    Text("2️⃣ Image.resizable() (natural: 600×180)")
                        .font(.caption)
                        .bold()
                    Text("   Container proposes: 200×200")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("   ⚠️ Image ACCEPTS full proposal → becomes 200×200 (DISTORTED!)")
                        .font(.caption)
                        .foregroundColor(.orange)
                    Text("   Code: Image(\"header\").resizable()")
                        .font(.system(.caption2, design: .monospaced))
                        .foregroundColor(.secondary)
                }
                .padding(8)
                .background(Color.orange.opacity(0.05))
                .cornerRadius(6)

                // Scenario 3: Resizable + aspectRatio
                VStack(alignment: .leading, spacing: 4) {
                    Text("3️⃣ Image.resizable().aspectRatio(.fit) (natural: 600×180)")
                        .font(.caption)
                        .bold()
                    Text("   Container proposes to aspectRatio: 200×200")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("   aspectRatio calculates & proposes to image: 200×60")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("   ✅ Image ACCEPTS filtered proposal → becomes 200×60 (PERFECT!)")
                        .font(.caption)
                        .foregroundColor(.green)
                    Text("   Code: Image(\"header\").resizable().aspectRatio(contentMode: .fit)")
                        .font(.system(.caption2, design: .monospaced))
                        .foregroundColor(.secondary)
                }
                .padding(8)
                .background(Color.green.opacity(0.05))
                .cornerRadius(6)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Hierarchy (Scenario 3):")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                hierarchyItem(level: 0, name: "Container", proposal: "→ 200×200")
                hierarchyItem(level: 1, name: "aspectRatio modifier", proposal: "→ 200×60 (calculated!)")
                hierarchyItem(level: 2, name: "resizable Image", proposal: "✓ accepts 200×60")
            }
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(8)

            Text("🎯 Bottom line: .resizable() makes the image ACCEPT proposals. .aspectRatio() FILTERS the proposal to maintain the ratio. You need BOTH!")
                .font(.subheadline)
                .foregroundColor(.blue)
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(8)
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }

    // MARK: - Visual Comparison

    private var visualComparisonSection: some View {
        VStack(spacing: 20) {
            Text("All three examples below have a natural image size of 600×180 in a 200×200 container:")
                .font(.subheadline)
                .foregroundColor(.secondary)

            VStack(spacing: 15) {
                // Scenario 1: No resizable
                HStack(spacing: 12) {
                    ZStack {
                        Rectangle()
                            .stroke(Color.red, lineWidth: 2)
                            .frame(width: 100, height: 100)

                        Rectangle()
                            .fill(Color.blue.opacity(0.3))
                            .overlay(
                                Text("600×180")
                                    .font(.caption2)
                                    .foregroundColor(.black)
                            )
                            .frame(width: 100, height: 30)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Image only")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.red)
                        Text("❌ Overflows container!")
                            .font(.caption2)
                            .foregroundColor(.red)
                        Text("Ignores 200×200 proposal")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .padding()
                .background(Color.red.opacity(0.05))
                .cornerRadius(8)

                // Scenario 2: Resizable only
                HStack(spacing: 12) {
                    Rectangle()
                        .fill(Color.blue.opacity(0.3))
                        .overlay(
                            Text("200×200")
                                .font(.caption2)
                                .foregroundColor(.black)
                        )
                        .frame(width: 100, height: 100)
                        .border(Color.red, width: 2)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(".resizable()")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.orange)
                        Text("⚠️ Distorted!")
                            .font(.caption2)
                            .foregroundColor(.orange)
                        Text("Accepts 200×200 proposal")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .padding()
                .background(Color.orange.opacity(0.05))
                .cornerRadius(8)

                // Scenario 3: Resizable + aspectRatio
                HStack(spacing: 12) {
                    ZStack {
                        Rectangle()
                            .stroke(Color.red, lineWidth: 2)
                            .frame(width: 100, height: 100)

                        Rectangle()
                            .fill(Color.blue.opacity(0.3))
                            .overlay(
                                Text("200×60")
                                    .font(.caption2)
                                    .foregroundColor(.black)
                            )
                            .frame(width: 100, height: 30)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(".resizable()")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                        Text(".aspectRatio(.fit)")
                            .font(.caption2)
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                        Text("✅ Perfect!")
                            .font(.caption2)
                            .foregroundColor(.green)
                        Text("Accepts 200×60 proposal")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .padding()
                .background(Color.green.opacity(0.05))
                .cornerRadius(8)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("What's happening:")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                HStack(alignment: .top, spacing: 10) {
                    Text("❌")
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Without .resizable(): Image ignores ALL proposals")
                            .font(.caption)
                        Text("→ Stays at 600×180, overflows the 200×200 container")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }

                HStack(alignment: .top, spacing: 10) {
                    Text("⚠️")
                    VStack(alignment: .leading, spacing: 2) {
                        Text("With .resizable() only: Image accepts FULL proposal")
                            .font(.caption)
                        Text("→ Becomes 200×200, aspect ratio broken (should be 3.33:1, now 1:1)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }

                HStack(alignment: .top, spacing: 10) {
                    Text("✅")
                    VStack(alignment: .leading, spacing: 2) {
                        Text("With .resizable() + .aspectRatio(): Image accepts FILTERED proposal")
                            .font(.caption)
                        Text("→ aspectRatio proposes 200×60 to maintain 3.33:1 ratio, image accepts it")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding()
            .background(Color.blue.opacity(0.05))
            .cornerRadius(8)
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }

    // MARK: - 1. Distorted Image Example

    private var distortedImageExample: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "WITHOUT aspectRatio - Image Gets Distorted",
                description: "Resizable image accepts proposal directly",
                code: "Color.blue.resizable()"
            ) {
                VStack(spacing: 12) {
                    // Simulating an image with Color
                    Color.blue
                        .overlay(
                            Text("Original: 100×30\nProposed: 200×200\nResult: 200×200")
                                .font(.caption)
                                .foregroundColor(.white)
                        )
                        .frame(width: 200, height: 200)
                        .border(Color.red, width: 2)

                    Text("Container proposes 200×200 → Image accepts 200×200 → DISTORTED!")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }

            exampleCard(
                title: "Layout Steps (Without aspectRatio)",
                description: "Direct proposal to resizable image",
                code: ""
            ) {
                VStack(alignment: .leading, spacing: 6) {
                    layoutStep("1", "Container proposes 200×200 to resizable image")
                    layoutStep("2", "Resizable image accepts 200×200")
                    layoutStep("3", "Image is stretched/squashed to fit → DISTORTED")
                }
                .font(.system(.caption, design: .monospaced))
            }
        }
    }

    // MARK: - 2. AspectRatio Solution

    private var aspectRatioSolution: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "WITH aspectRatio - Image Maintains Proportions",
                description: "aspectRatio modifier filters the proposal",
                code: "Color.blue.aspectRatio(contentMode: .fit)"
            ) {
                VStack(spacing: 12) {
                    // Simulating aspect ratio behavior
                    Color.blue
                        .overlay(
                            Text("Original: 100×30\nProposed to modifier: 200×200\nProposed to image: 200×60\nResult: 200×60")
                                .font(.caption)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        )
                        .frame(width: 200, height: 60)
                        .frame(width: 200, height: 200)
                        .border(Color.red, width: 2)

                    Text("aspectRatio modifier sits between container and image, proposing 200×60 instead!")
                        .font(.caption)
                        .foregroundColor(.green)
                }
            }

            exampleCard(
                title: "Why 200×60?",
                description: "Aspect ratio calculation",
                code: ""
            ) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Given:")
                        .fontWeight(.semibold)
                    Text("• Original image: 100×30")
                    Text("• Aspect ratio: 100/30 = 3.33:1")
                    Text("• Proposed size: 200×200")

                    Divider()

                    Text("Calculation (.fit mode):")
                        .fontWeight(.semibold)
                    Text("• Option 1: Use full width (200)")
                    Text("  → Height = 200 / 3.33 = 60 ✅")
                    Text("• Option 2: Use full height (200)")
                    Text("  → Width = 200 × 3.33 = 666.67 ❌ (too wide!)")

                    Divider()

                    Text("Result: 200×60")
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                }
                .font(.caption)
            }
        }
    }

    // MARK: - 3. Layout Process Breakdown

    private var layoutProcessBreakdown: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Complete Layout Process",
                description: "Step-by-step with aspectRatio modifier",
                code: "Image(\"header\").resizable().aspectRatio(contentMode: .fit)"
            ) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Step 1: Initial Proposal")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                    layoutDetail("Container → aspectRatio", "200×200")

                    Divider()

                    Text("Step 2: Probe for Ideal Size")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                    layoutDetail("aspectRatio → Image", "nil×nil (What's your ideal size?)")
                    layoutDetail("Image → aspectRatio", "100×30 (my ideal size)")

                    Divider()

                    Text("Step 3: Calculate Constrained Size")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                    layoutDetail("aspectRatio calculates", "Aspect ratio = 100/30")
                    layoutDetail("aspectRatio calculates", "Fit 100:30 ratio into 200×200 = 200×60")

                    Divider()

                    Text("Step 4: Propose Constrained Size")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                    layoutDetail("aspectRatio → Image", "200×60")
                    layoutDetail("Image → aspectRatio", "200×60 (accepted!)")

                    Divider()

                    Text("Step 5: Report Final Size")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                    layoutDetail("aspectRatio → Container", "200×60")
                }
                .padding()
                .background(Color.blue.opacity(0.05))
                .cornerRadius(8)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Key Takeaway:")
                    .font(.headline)

                Text("The resizable image DOES accept the proposed size - it's just that the aspectRatio modifier proposes a different (smaller) size than what it received from the container!")
                    .font(.subheadline)
                    .foregroundColor(.orange)
            }
            .padding()
            .background(Color.orange.opacity(0.1))
            .cornerRadius(8)
        }
    }

    // MARK: - 4. Fit vs Fill

    private var fitVsFillComparison: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: ".fit - Largest That Fits Inside",
                description: "Entire image visible, may leave empty space",
                code: ".aspectRatio(contentMode: .fit)"
            ) {
                VStack(spacing: 12) {
                    Color.blue
                        .overlay(
                            Text("200×60")
                                .font(.caption)
                                .foregroundColor(.white)
                        )
                        .frame(width: 200, height: 60)
                        .frame(width: 200, height: 200, alignment: .center)
                        .border(Color.red, width: 2)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Given: 200×200 container, 100×30 image")
                        Text("Result: 200×60 (fits inside, empty space above/below)")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: ".fill - Smallest That Covers Entire Area",
                description: "Fills container, image may be cropped",
                code: ".aspectRatio(contentMode: .fill)"
            ) {
                VStack(spacing: 12) {
                    Color.blue
                        .overlay(
                            Text("666×200")
                                .font(.caption)
                                .foregroundColor(.white)
                        )
                        .frame(width: 666, height: 200)
                        .frame(width: 200, height: 200)
                        .clipped()
                        .border(Color.red, width: 2)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Given: 200×200 container, 100×30 image")
                        Text("Result: 666×200 (covers area, sides cropped)")
                        Text("Note: Image is actually 666 wide but clipped to 200")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }

            VStack(alignment: .leading, spacing: 12) {
                Text("Calculation Comparison:")
                    .font(.headline)

                HStack(alignment: .top, spacing: 20) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(".fit")
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                        Text("Width: 200 → H = 60 ✅")
                        Text("Height: 200 → W = 666 ❌")
                        Text("Picks: 200×60")
                    }
                    .font(.caption)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(".fill")
                            .fontWeight(.semibold)
                            .foregroundColor(.orange)
                        Text("Width: 200 → H = 60 ❌")
                        Text("Height: 200 → W = 666 ✅")
                        Text("Picks: 666×200")
                    }
                    .font(.caption)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
        }
    }

    // MARK: - 5. Specific Aspect Ratio

    private var specificAspectRatio: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Specifying Aspect Ratio Explicitly",
                description: "Force a specific ratio regardless of image's natural ratio",
                code: ".aspectRatio(4/3, contentMode: .fit)"
            ) {
                VStack(spacing: 12) {
                    Color.blue
                        .overlay(
                            Text("200×150")
                                .font(.caption)
                                .foregroundColor(.white)
                        )
                        .frame(width: 200, height: 150)
                        .frame(width: 200, height: 200)
                        .border(Color.red, width: 2)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Given: 200×200 container")
                        Text("Forced ratio: 4:3")
                        Text("Result: 200×150")
                        Text("\nNo probing for ideal size - uses specified ratio!")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Layout Steps (Specified Ratio)",
                description: "Simpler process - no probing needed",
                code: ""
            ) {
                VStack(alignment: .leading, spacing: 6) {
                    layoutStep("1", "aspectRatio receives proposal: 200×200")
                    layoutStep("2", "aspectRatio calculates: Fit 4:3 into 200×200 = 200×150")
                    layoutStep("3", "aspectRatio proposes 200×150 to Color")
                    layoutStep("4", "Color accepts and reports 200×150")
                    layoutStep("5", "aspectRatio reports 200×150")

                    Text("\nNo nil×nil proposal needed - ratio is explicitly given!")
                        .font(.caption)
                        .foregroundColor(.orange)
                }
                .font(.system(.caption, design: .monospaced))
            }
        }
    }

    // MARK: - 6. Interactive Demo

    private var interactiveDemo: some View {
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

    // MARK: - Helper Views

    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.title2)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top)
    }

    private func exampleCard<Content: View>(
        title: String,
        description: String,
        code: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)

            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary)

            if !code.isEmpty {
                Text(code)
                    .font(.system(.caption, design: .monospaced))
                    .padding(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(4)
            }

            content()
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }

    private func layoutStep(_ number: String, _ text: String) -> some View {
        HStack(alignment: .top, spacing: 6) {
            Text("\(number).")
                .fontWeight(.semibold)
                .frame(width: 20, alignment: .leading)
            Text(text)
        }
    }

    private func layoutDetail(_ label: String, _ value: String) -> some View {
        HStack {
            Text(label)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
                .font(.system(.caption, design: .monospaced))
        }
        .font(.caption)
    }

    private func hierarchyItem(level: Int, name: String, proposal: String) -> some View {
        HStack(spacing: 4) {
            Text(String(repeating: "  ", count: level) + "└─")
                .foregroundColor(.secondary)
            Text(name)
                .fontWeight(.medium)
            Spacer()
            Text(proposal)
                .foregroundColor(.secondary)
        }
        .font(.system(.caption, design: .monospaced))
    }
}

// MARK: - Interactive Sandbox

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

// MARK: - Preview

#Preview("Explanation") {
    AspectRatioExplained()
}

#Preview("Sandbox") {
    AspectRatioSandbox()
}

/*
 ASPECT RATIO KEY CONCEPTS:

 ## Why Do We Need BOTH .resizable() AND .aspectRatio()?

 By default, Images are NOT flexible - they IGNORE all proposals!
 .resizable() makes them flexible - they ACCEPT proposals!
 .aspectRatio() FILTERS proposals to maintain the correct ratio!

 Three Scenarios (600×180 image in 200×200 container):

 1. Image only:
    Container (200×200) → Image ← IGNORES proposal, stays 600×180 (OVERFLOWS!)

 2. .resizable() only:
    Container (200×200) → Resizable Image ← ACCEPTS 200×200 (DISTORTED!)

 3. .resizable() + .aspectRatio():
    Container (200×200) → aspectRatio (calculates 200×60) → Resizable Image ← ACCEPTS 200×60 (PERFECT!)

 ## The Layout Flow:

 1. aspectRatio receives proposal from container (200×200)
 2. aspectRatio probes image with nil×nil to get ideal size (100×30)
 3. aspectRatio calculates: "What size maintains 100:30 ratio and fits in 200×200?"
 4. aspectRatio proposes calculated size (200×60) to image
 5. Resizable image accepts 200×60 (NOT 200×200!)
 6. aspectRatio reports image's size (200×60) to container

 ## Content Modes:

 .fit  - Largest size that fits INSIDE proposed size
       - Entire image visible, may have empty space
       - For 100:30 image in 200×200: picks 200×60

 .fill - Smallest size that COVERS entire proposed size
       - Container filled, image may be cropped
       - For 100:30 image in 200×200: picks 666×200

 ## Key Insight:

 Modifiers are LAYERS that wrap views. The aspectRatio modifier sits between
 the container and the image, controlling what size gets proposed to the image.

 The resizable image DOES accept the proposed size - it's just that the proposal
 comes from aspectRatio (200×60), not from the container (200×200)!
 */
