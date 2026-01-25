import SwiftUI

// MARK: - Bullet Point

func bulletPoint(_ title: String, _ text: String) -> some View {
    HStack(alignment: .top, spacing: 8) {
        Text("•")
            .fontWeight(.bold)
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
            Text(text)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        Spacer()
    }
}

func bulletPoint(_ text: String) -> some View {
    HStack(alignment: .top, spacing: 8) {
        Text("•")
        Text(text)
            .font(.subheadline)
        Spacer()
    }
}

// MARK: - Rule Item

func ruleItem(_ number: String, _ text: String) -> some View {
    HStack(alignment: .top, spacing: 8) {
        Text(number)
            .font(.caption)
            .fontWeight(.bold)
            .foregroundColor(.blue)
            .frame(width: 20)
        Text(text)
            .font(.subheadline)
        Spacer()
    }
}

// MARK: - Constant Card

func constantCard(
    title: String,
    value: String,
    usage: String,
    practical: Bool,
    description: String
) -> some View {
    VStack(alignment: .leading, spacing: 6) {
        HStack {
            Text(title)
                .font(.headline)
                .fontDesign(.monospaced)
            Spacer()
            Text(practical ? "✅ USE" : "⚠️ AVOID")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(practical ? .green : .orange)
        }

        Text("Value: \(value)")
            .font(.caption)
            .foregroundColor(.secondary)

        Text(usage)
            .font(.subheadline)

        Text(description)
            .font(.caption)
            .foregroundColor(.secondary)
    }
    .padding()
    .background(Color.gray.opacity(0.05))
    .cornerRadius(8)
}


// MARK: - Section Header

@ViewBuilder
func sectionHeader(_ title: String) -> some View {
    Text(title)
        .font(.title2)
        .fontWeight(.bold)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top)
}

// MARK: - Example Card

@ViewBuilder
func exampleCard<Content: View>(
    title: String,
    description: String,
    code: String="",
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

/// Creates a numbered layout step
func layoutStep(_ number: String, _ text: String) -> some View {
    HStack(alignment: .top, spacing: 6) {
        Text("\(number).")
            .fontWeight(.semibold)
            .frame(width: 20, alignment: .leading)
        Text(text)
    }
}

/// Creates a layout detail row with label and value
func layoutDetail(_ label: String, _ value: String) -> some View {
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

/// Creates a hierarchy item showing indentation and proposal
func hierarchyItem(level: Int, name: String, proposal: String) -> some View {
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

// MARK: - Concept Box

/// Creates a concept box with title, description, and bullet points
func conceptBox(title: String, description: String, details: [String], color: Color) -> some View {
    VStack(alignment: .leading, spacing: 8) {
        Text(title)
            .fontWeight(.semibold)
            .foregroundColor(color)

        Text(description)
            .font(.caption)
            .foregroundColor(.secondary)

        ForEach(details, id: \.self) { detail in
            HStack(alignment: .top, spacing: 4) {
                Text("•")
                Text(detail)
            }
            .font(.caption)
        }
    }
    .padding()
    .background(color.opacity(0.1))
    .cornerRadius(8)
}

// MARK: - Step Box

/// Creates a numbered step box for processes
func stepBox(number: String, title: String, description: String, example: String, color: Color) -> some View {
    HStack(alignment: .top, spacing: 12) {
        Text(number)
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(width: 40, height: 40)
            .background(color)
            .clipShape(Circle())

        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .fontWeight(.semibold)
                .foregroundColor(color)

            Text(description)
                .font(.caption)
                .foregroundColor(.secondary)

            Text(example)
                .font(.system(.caption, design: .monospaced))
                .padding(6)
                .background(color.opacity(0.1))
                .cornerRadius(4)
        }
    }
    .padding()
    .background(color.opacity(0.05))
    .cornerRadius(8)
}

// MARK: - Concept Box With Icon

/// Creates a concept box with icon, title, description, and bullet points
func conceptBoxWithIcon(icon: String, title: String, description: String, color: Color, details: [String]) -> some View {
    HStack(alignment: .top, spacing: 12) {
        Text(icon)
            .font(.largeTitle)
            .foregroundColor(color)

        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .fontWeight(.semibold)
                .foregroundColor(color)

            Text(description)
                .font(.caption)
                .foregroundColor(.secondary)

            ForEach(details, id: \.self) { detail in
                HStack(alignment: .top, spacing: 4) {
                    Text("•")
                    Text(detail)
                }
                .font(.caption)
            }
        }
    }
    .padding()
    .background(color.opacity(0.1))
    .cornerRadius(8)
}

// MARK: - Proposal Step

/// Creates a numbered proposal step for showing layout flows
func proposalStep(_ number: String, _ text: String, _ color: Color) -> some View {
    HStack(alignment: .top, spacing: 6) {
        Text("\(number).")
            .fontWeight(.semibold)
            .foregroundColor(color)
        Text(text)
            .font(.caption)
    }
}

// MARK: - Legend Item

/// Creates a legend item with colored circle indicator
func legendItem(color: Color, text: String) -> some View {
    HStack(spacing: 6) {
        Circle()
            .fill(color)
            .frame(width: 10, height: 10)
        Text(text)
    }
}

// MARK: - Layout Phase Step

/// Creates a numbered layout phase step
func layoutPhaseStep(_ number: String, _ text: String) -> some View {
    HStack(alignment: .top, spacing: 6) {
        Text("\(number).")
            .fontWeight(.semibold)
            .foregroundColor(.blue)
        Text(text)
    }
}

// MARK: - Render Phase Step

/// Creates a numbered render phase step
func renderPhaseStep(_ number: String, _ text: String) -> some View {
    HStack(alignment: .top, spacing: 6) {
        Text("\(number).")
            .fontWeight(.semibold)
            .foregroundColor(.orange)
        Text(text)
    }
}

// MARK: - Importance Item

/// Creates an importance bullet point with arrow
func importanceItem(_ text: String) -> some View {
    HStack(alignment: .top, spacing: 6) {
        Text("→")
            .foregroundColor(.blue)
        Text(text)
            .font(.caption)
    }
}
