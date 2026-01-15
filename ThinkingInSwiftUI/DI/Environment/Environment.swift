//
//  Environment.swift
//  ThinkingInSwiftUI
//
//  Environment: The Foundation of SwiftUI's Architecture
//  Built-in Dependency Injection + How Apple uses it across the entire framework
//

import SwiftUI

// MARK: - Environment as Foundation
//
// Environment is THE FOUNDATIONAL mechanism in SwiftUI - not just a feature!
// Apple uses environment to propagate values across ALL these areas:
//
// 1. Accessibility - reduce motion, differentiate without color, voice over
// 2. Actions - dismiss, open URL, refresh, purchase
// 3. Display - color scheme, size class, display scale
// 4. Text & Typography - font, line limit, text case
// 5. State - edit mode, focus, presentation state
// 6. Global Objects - calendar, locale, timezone, Core Data context
// 7. Controls - button size, menu order, keyboard shortcuts
// 8. Scrolling - scroll indicators, bounce behavior
//
// This shows environment is how SwiftUI propagates system settings, user preferences,
// and global state throughout the app without manual prop drilling.

// MARK: - Fundamentals

struct EnvironmentFundamentalsExample: View {
    @Environment(\.font) var font
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Environment Fundamentals")
                    .font(.title)
                    .bold()

                Text("Built-in dependency injection - the foundation of SwiftUI")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("What is Environment?")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("• Built-in dependency injection mechanism")
                                .font(.caption)
                            Text("• Dictionary of key-value pairs flowing down the view tree")
                                .font(.caption)
                            Text("• Values propagate from parent → children (not sideways/up)")
                                .font(.caption)
                            Text("• Any view can override values for its subtree")
                                .font(.caption)
                            Text("• Eliminates prop drilling - values available everywhere")
                                .font(.caption)
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: Font Propagation")
                            .font(.headline)

                        VStack {
                            Text("Item 1")
                            Text("Item 2")
                        }
                        .font(.title)
                        .padding()
                        .border(Color.blue, width: 2)

                        Text("View Tree:")
                            .font(.caption)
                            .bold()
                            .padding(.top, 8)

                        Text("""
                        EnvironmentKeyWritingModifier(Font: .title)
                        └── VStack
                            ├── Text("Item 1")  ← receives .title from environment
                            └── Text("Item 2")  ← receives .title from environment
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)

                        Text("How it works:")
                            .font(.caption)
                            .padding(.top, 8)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("1. .font(.title) creates EnvironmentKeyWritingModifier")
                                .font(.caption2)
                            Text("2. Modifier updates environment dictionary: {font: .title}")
                                .font(.caption2)
                            Text("3. VStack receives modified environment")
                                .font(.caption2)
                            Text("4. VStack passes environment to children")
                                .font(.caption2)
                            Text("5. Both Text views read \\.font from environment")
                                .font(.caption2)
                                .foregroundColor(.green)
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Modifier Syntax = Syntactic Sugar")
                            .font(.headline)

                        Text("These are IDENTICAL:")
                            .font(.caption)

                        VStack(alignment: .leading, spacing: 10) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Convenient modifier:")
                                    .font(.caption)
                                    .bold()
                                Text(".font(.title)")
                                    .font(.system(.caption2, design: .monospaced))
                            }
                            .padding(8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(5)

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Explicit environment API:")
                                    .font(.caption)
                                    .bold()
                                Text(".environment(\\\\.font, .title)")
                                    .font(.system(.caption2, design: .monospaced))
                            }
                            .padding(8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(5)
                        }

                        Text("💡 Many modifiers are just .environment under the hood!")
                            .font(.caption)
                            .foregroundColor(.orange)
                            .padding(.top, 8)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Propagation Direction")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("✓ Parent → Children (DOWN)")
                                .font(.caption)
                                .foregroundColor(.green)
                            Text("✓ Ancestor → All Descendants (DOWN)")
                                .font(.caption)
                                .foregroundColor(.green)
                            Text("✗ Sibling → Sibling (SIDEWAYS)")
                                .font(.caption)
                                .foregroundColor(.red)
                            Text("✗ Child → Parent (UP)")
                                .font(.caption)
                                .foregroundColor(.red)
                        }

                        Text("Example: Siblings Don't Share")
                            .font(.caption)
                            .bold()
                            .padding(.top, 8)

                        HStack(alignment: .top, spacing: 20) {
                            VStack(spacing: 5) {
                                Text("Item 1")
                                Text("Item 2")
                            }
                            .font(.title)
                            .padding()
                            .background(Color.blue.opacity(0.1))

                            Text("Hello!")
                                .padding()
                                .background(Color.orange.opacity(0.1))
                        }
                        .border(Color.gray)

                        Text("'Hello!' is a SIBLING - doesn't receive .title font")
                            .font(.caption2)
                            .foregroundColor(.orange)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Environment as Dictionary")
                            .font(.headline)

                        Text("Mental Model:")
                            .font(.caption)
                            .bold()

                        Text("""
                        [
                            \\.font: .body,
                            \\.colorScheme: .light,
                            \\.locale: Locale.current,
                            \\.calendar: Calendar.current,
                            // ... 100+ values
                        ]
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)

                        Text("When you modify:")
                            .font(.caption)
                            .bold()
                            .padding(.top, 8)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("1. View receives environment from parent")
                                .font(.caption2)
                            Text("2. View makes a COPY")
                                .font(.caption2)
                            Text("3. View modifies copy (e.g., font = .title)")
                                .font(.caption2)
                            Text("4. View passes modified copy to children")
                                .font(.caption2)
                            Text("5. Siblings get original (unmodified) environment")
                                .font(.caption2)
                                .foregroundColor(.orange)
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Reading Environment Values")
                            .font(.headline)

                        Text("Use @Environment property wrapper:")
                            .font(.caption)

                        Text("""
                        struct MyView: View {
                            @Environment(\\\\.colorScheme) var colorScheme
                            @Environment(\\\\.font) var font

                            var body: some View {
                                Text("Mode: \\(colorScheme == .dark ? "Dark" : "Light")")
                            }
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)

                        Text("Current values in THIS view:")
                            .font(.caption)
                            .padding(.top, 8)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Color Scheme: \(colorScheme == .dark ? "Dark" : "Light")")
                                .font(.caption2)
                            Text("Font: \(font.map { String(describing: $0) } ?? "nil")")
                                .font(.caption2)
                        }
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                })
            }
            .padding()
        }
    }
}

// MARK: - System Integration

struct SystemIntegrationExample: View {
    // Accessibility
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    // Display
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.colorSchemeContrast) var contrast
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.displayScale) var displayScale

    // Global Objects
    @Environment(\.calendar) var calendar
    @Environment(\.locale) var locale
    @Environment(\.timeZone) var timeZone

    @State private var isAnimating = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("System Integration")
                    .font(.title)
                    .bold()

                Text("How Apple propagates system settings, display properties, and global objects via environment")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                // ACCESSIBILITY SECTION

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("🔹 Accessibility Settings")
                            .font(.headline)

                        Text("User preferences automatically available:")
                            .font(.caption)
                            .bold()

                        VStack(alignment: .leading, spacing: 8) {
                            Text("• accessibilityReduceMotion - disable animations")
                                .font(.caption2)
                            Text("• accessibilityDifferentiateWithoutColor - add icons/shapes")
                                .font(.caption2)
                            Text("• accessibilityVoiceOverEnabled - screen reader active")
                                .font(.caption2)
                            Text("• dynamicTypeSize - text size preference")
                                .font(.caption2)
                            Text("• accessibilityShowButtonShapes - add button outlines")
                                .font(.caption2)
                            Text("... 20+ accessibility values")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: Reduce Motion")
                            .font(.headline)

                        Text("Current: \(reduceMotion ? "ON" : "OFF")")
                            .font(.caption)
                            .foregroundColor(.orange)

                        Button("Animate") {
                            isAnimating.toggle()
                        }
                        .buttonStyle(.borderedProminent)

                        Circle()
                            .fill(Color.blue)
                            .frame(width: 50, height: 50)
                            .offset(x: isAnimating ? 100 : 0)
                            .animation(
                                reduceMotion ? .none : .spring(),
                                value: isAnimating
                            )

                        Text("""
                        @Environment(\\\\.accessibilityReduceMotion) var reduceMotion

                        Circle()
                            .animation(
                                reduceMotion ? .none : .spring(),
                                value: isAnimating
                            )
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: Differentiate Without Color")
                            .font(.headline)

                        Text("Current: \(differentiateWithoutColor ? "ON" : "OFF")")
                            .font(.caption)
                            .foregroundColor(.orange)

                        HStack(spacing: 20) {
                            StatusIndicator(label: "Success", color: .green, usesColorOnly: true)
                            StatusIndicator(label: "Error", color: .red, usesColorOnly: true)
                        }

                        Text("When ON, icons appear. When OFF, color only.")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                })

                // DISPLAY SECTION

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("🔹 Display Characteristics")
                            .font(.headline)

                        Text("Device and screen properties:")
                            .font(.caption)
                            .bold()

                        VStack(alignment: .leading, spacing: 8) {
                            Text("• colorScheme - light/dark mode")
                                .font(.caption2)
                            Text("• colorSchemeContrast - standard/increased")
                                .font(.caption2)
                            Text("• horizontalSizeClass - compact/regular")
                                .font(.caption2)
                            Text("• verticalSizeClass - compact/regular")
                                .font(.caption2)
                            Text("• displayScale - @2x, @3x retina")
                                .font(.caption2)
                            Text("• pixelLength - size of one pixel")
                                .font(.caption2)
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Current Display Settings")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 6) {
                            InfoRow(label: "Color Scheme", value: colorScheme == .dark ? "Dark" : "Light")
                            InfoRow(label: "Contrast", value: contrast == .increased ? "Increased" : "Standard")
                            InfoRow(label: "H Size Class", value: horizontalSizeClass?.description ?? "nil")
                            InfoRow(label: "V Size Class", value: verticalSizeClass?.description ?? "nil")
                            InfoRow(label: "Display Scale", value: String(format: "%.1fx", displayScale))
                        }
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: Adaptive Layout by Size Class")
                            .font(.headline)

                        if horizontalSizeClass == .compact {
                            VStack(spacing: 10) {
                                EnvironmentColorBox(color: .blue, label: "1")
                                EnvironmentColorBox(color: .green, label: "2")
                                EnvironmentColorBox(color: .orange, label: "3")
                            }
                        } else {
                            HStack(spacing: 10) {
                                EnvironmentColorBox(color: .blue, label: "1")
                                EnvironmentColorBox(color: .green, label: "2")
                                EnvironmentColorBox(color: .orange, label: "3")
                            }
                        }

                        Text("""
                        @Environment(\\\\.horizontalSizeClass) var sizeClass

                        if sizeClass == .compact {
                            VStack { /* iPhone portrait */ }
                        } else {
                            HStack { /* iPad / iPhone landscape */ }
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: Dark Mode Adaptation")
                            .font(.headline)

                        RoundedRectangle(cornerRadius: 10)
                            .fill(colorScheme == .dark ? Color.white : Color.black)
                            .frame(height: 80)
                            .overlay {
                                Text("Adapts to color scheme")
                                    .foregroundStyle(colorScheme == .dark ? .black : .white)
                            }
                    }
                })

                // GLOBAL OBJECTS SECTION

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("🔹 Global Objects")
                            .font(.headline)

                        Text("System objects available everywhere:")
                            .font(.caption)
                            .bold()

                        VStack(alignment: .leading, spacing: 8) {
                            Text("• calendar - user's calendar system")
                                .font(.caption2)
                            Text("• locale - language and region")
                                .font(.caption2)
                            Text("• timeZone - user's timezone")
                                .font(.caption2)
                            Text("• managedObjectContext - Core Data")
                                .font(.caption2)
                            Text("• modelContext - SwiftData")
                                .font(.caption2)
                            Text("• undoManager - undo/redo system")
                                .font(.caption2)
                        }

                        Text("No singletons or manual passing required!")
                            .font(.caption)
                            .foregroundColor(.green)
                            .padding(.top, 8)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Current Global Settings")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 6) {
                            InfoRow(label: "Calendar", value: String(describing: calendar.identifier))
                            InfoRow(label: "Locale", value: locale.identifier)
                            InfoRow(label: "Language", value: locale.language.languageCode?.identifier ?? "unknown")
                            InfoRow(label: "Region", value: locale.region?.identifier ?? "unknown")
                            InfoRow(label: "TimeZone", value: timeZone.identifier)
                            InfoRow(label: "TZ Offset", value: "\(timeZone.secondsFromGMT() / 3600)h")
                        }
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: Date Formatting")
                            .font(.headline)

                        Text("Text automatically uses locale and calendar from environment:")
                            .font(.caption)

                        let now = Date()
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Full: \(now, style: .date)")
                                .font(.caption2)
                            Text("Time: \(now, style: .time)")
                                .font(.caption2)
                            Text("Relative: \(now, style: .relative)")
                                .font(.caption2)
                        }
                        .padding(8)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(5)

                        Text("""
                        @Environment(\\\\.calendar) var calendar

                        let tomorrow = calendar.date(
                            byAdding: .day, value: 1, to: Date()
                        )
                        // Respects Gregorian, Islamic, Hebrew, etc.
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                })
            }
            .padding()
        }
    }
}

// MARK: - UI Features

struct UIFeaturesExample: View {
    // Actions
    @Environment(\.dismiss) var dismiss
    @Environment(\.openURL) var openURL

    // State
    @Environment(\.isEnabled) var isEnabled
    @Environment(\.isFocused) var isFocused

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("UI Features")
                    .font(.title)
                    .bold()

                Text("How environment provides actions, controls text styling, and manages UI state")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                // ACTIONS SECTION

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("🔹 Actions via Environment")
                            .font(.headline)

                        Text("Common actions available everywhere:")
                            .font(.caption)
                            .bold()

                        VStack(alignment: .leading, spacing: 8) {
                            Text("• dismiss - close sheet/navigation")
                                .font(.caption2)
                            Text("• openURL - open web links")
                                .font(.caption2)
                            Text("• refresh - pull to refresh action")
                                .font(.caption2)
                            Text("• openWindow - open new window (macOS)")
                                .font(.caption2)
                            Text("• purchase - trigger in-app purchase")
                                .font(.caption2)
                            Text("• dismissSearch - end search mode")
                                .font(.caption2)
                            Text("• rename - activate rename interaction")
                                .font(.caption2)
                            Text("... 15+ actions")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: Dismiss Action")
                            .font(.headline)

                        Text("No need to pass @Binding down the tree:")
                            .font(.caption)

                        Button("Dismiss This View") {
                            dismiss()
                        }
                        .buttonStyle(.borderedProminent)

                        Text("""
                        @Environment(\\\\.dismiss) var dismiss

                        Button("Close") {
                            dismiss()
                        }
                        // Works in sheets, NavigationStack, etc.
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: Open URL")
                            .font(.headline)

                        Button("Open Apple.com") {
                            if let url = URL(string: "https://www.apple.com") {
                                openURL(url)
                            }
                        }
                        .buttonStyle(.bordered)

                        Text("""
                        @Environment(\\\\.openURL) var openURL

                        Button("Open Link") {
                            openURL(URL(string: "https://...")!)
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                })

                // TEXT & TYPOGRAPHY SECTION

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("🔹 Text & Typography")
                            .font(.headline)

                        Text("All text styling propagates through environment:")
                            .font(.caption)
                            .bold()

                        VStack(alignment: .leading, spacing: 8) {
                            Text("• font - text font")
                                .font(.caption2)
                            Text("• lineLimit - max lines")
                                .font(.caption2)
                            Text("• lineSpacing - space between lines")
                                .font(.caption2)
                            Text("• textCase - uppercase/lowercase")
                                .font(.caption2)
                            Text("• truncationMode - head/tail/middle")
                                .font(.caption2)
                            Text("• multilineTextAlignment - alignment")
                                .font(.caption2)
                            Text("... 15+ text values")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: Font & Style Propagation")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 5) {
                            Text("Line 1")
                            Text("Line 2")
                            Text("Line 3")
                        }
                        .font(.title)
                        .bold()
                        .foregroundStyle(.blue)
                        .padding()
                        .background(Color.blue.opacity(0.1))

                        Text("All modifiers propagate to children:")
                            .font(.caption)
                            .padding(.top, 8)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("• .font(.title) → all children")
                                .font(.caption2)
                            Text("• .bold() → all children")
                                .font(.caption2)
                            Text("• .foregroundStyle(.blue) → all children")
                                .font(.caption2)
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: Line Limit")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 10) {
                            Text("This is a very long text that will wrap to multiple lines and demonstrate the line limit functionality in SwiftUI")
                            Text("This is another very long text that will also wrap to multiple lines and show the same line limit")
                        }
                        .lineLimit(2)
                        .padding()
                        .background(Color.green.opacity(0.1))

                        Text("Both texts limited to 2 lines via environment")
                            .font(.caption2)
                            .foregroundColor(.green)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: Text Case")
                            .font(.headline)

                        VStack(spacing: 10) {
                            Text("This text is uppercase")
                            Text("So is this text")
                            Text("And this one too")
                        }
                        .textCase(.uppercase)
                        .padding()
                        .background(Color.orange.opacity(0.1))

                        Text("All transformed via environment!")
                            .font(.caption2)
                            .foregroundColor(.orange)
                    }
                })

                // STATE SECTION

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("🔹 UI State")
                            .font(.headline)

                        Text("UI state propagates automatically:")
                            .font(.caption)
                            .bold()

                        VStack(alignment: .leading, spacing: 8) {
                            Text("• isEnabled - view allows interaction")
                                .font(.caption2)
                            Text("• isFocused - view or ancestor has focus")
                                .font(.caption2)
                            Text("• isPresented - view is presented")
                                .font(.caption2)
                            Text("• editMode - list editing mode")
                                .font(.caption2)
                            Text("• isSearching - search is active")
                                .font(.caption2)
                            Text("• scenePhase - active/inactive/background")
                                .font(.caption2)
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Current State")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 6) {
                            InfoRow(label: "Is Enabled", value: isEnabled ? "Yes" : "No")
                            InfoRow(label: "Is Focused", value: isFocused ? "Yes" : "No")
                        }
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: Disabled State Propagation")
                            .font(.headline)

                        VStack(spacing: 10) {
                            Button("Button 1") { }
                            Button("Button 2") { }
                            Button("Button 3") { }
                        }
                        .disabled(true)
                        .padding()
                        .background(Color.gray.opacity(0.1))

                        Text("All buttons disabled via environment")
                            .font(.caption2)
                            .foregroundColor(.secondary)

                        Text("""
                        VStack {
                            Button("1") { }
                            Button("2") { }
                        }
                        .disabled(true)
                        // .disabled() sets isEnabled in environment
                        // All children automatically disabled
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                })
            }
            .padding()
        }
    }
}

// MARK: - Summary

struct EnvironmentSummaryExample: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Environment: The Foundation")
                    .font(.title)
                    .bold()

                Text("Why environment is THE core mechanism in SwiftUI")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Environment Categories")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            CategoryRow(
                                icon: "eye",
                                title: "Accessibility",
                                count: "20+",
                                examples: "reduce motion, differentiate without color, voice over"
                            )

                            CategoryRow(
                                icon: "bolt.fill",
                                title: "Actions",
                                count: "15+",
                                examples: "dismiss, openURL, refresh, purchase"
                            )

                            CategoryRow(
                                icon: "display",
                                title: "Display",
                                count: "10+",
                                examples: "color scheme, size class, display scale"
                            )

                            CategoryRow(
                                icon: "textformat",
                                title: "Text & Typography",
                                count: "15+",
                                examples: "font, line limit, text case"
                            )

                            CategoryRow(
                                icon: "circle.grid.3x3",
                                title: "State",
                                count: "10+",
                                examples: "edit mode, focus, presentation state"
                            )

                            CategoryRow(
                                icon: "globe",
                                title: "Global Objects",
                                count: "8+",
                                examples: "calendar, locale, timezone, Core Data"
                            )

                            CategoryRow(
                                icon: "switch.2",
                                title: "Controls",
                                count: "10+",
                                examples: "button size, menu order, keyboard shortcuts"
                            )

                            CategoryRow(
                                icon: "scroll",
                                title: "Scrolling",
                                count: "6+",
                                examples: "scroll indicators, bounce behavior"
                            )
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Why Environment Matters")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("🏗️ Foundation of SwiftUI Architecture")
                                .font(.caption)
                                .bold()
                            Text("Environment is not a feature - it's how SwiftUI works")
                                .font(.caption2)
                                .foregroundColor(.secondary)

                            Text("🌊 Automatic Propagation")
                                .font(.caption)
                                .bold()
                                .padding(.top, 4)
                            Text("Values flow down automatically - no manual passing")
                                .font(.caption2)
                                .foregroundColor(.secondary)

                            Text("♿️ Accessibility Built-in")
                                .font(.caption)
                                .bold()
                                .padding(.top, 4)
                            Text("User preferences available everywhere via environment")
                                .font(.caption2)
                                .foregroundColor(.secondary)

                            Text("🌍 Global Settings")
                                .font(.caption)
                                .bold()
                                .padding(.top, 4)
                            Text("Locale, timezone, calendar - no singletons needed")
                                .font(.caption2)
                                .foregroundColor(.secondary)

                            Text("🎨 Consistent Theming")
                                .font(.caption)
                                .bold()
                                .padding(.top, 4)
                            Text("Set font/color once, affects entire subtree")
                                .font(.caption2)
                                .foregroundColor(.secondary)

                            Text("🔌 Built-in Dependency Injection")
                                .font(.caption)
                                .bold()
                                .padding(.top, 4)
                            Text("No need for manual DI - SwiftUI does it for you")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Key Patterns")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 10) {
                            PatternRow(
                                title: "Read",
                                code: "@Environment(\\\\.colorScheme) var colorScheme"
                            )

                            PatternRow(
                                title: "Write",
                                code: ".environment(\\\\.font, .title)"
                            )

                            PatternRow(
                                title: "Modifier Sugar",
                                code: ".font(.title) // same as .environment(\\.font, .title)"
                            )

                            PatternRow(
                                title: "Propagation",
                                code: "Parent sets → All descendants receive"
                            )

                            PatternRow(
                                title: "Override",
                                code: "Child can override parent's values"
                            )
                        }
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Big Picture")
                            .font(.headline)

                        Text("Environment is THE mechanism Apple uses to:")
                            .font(.caption)

                        VStack(alignment: .leading, spacing: 6) {
                            Text("✓ Propagate system settings (locale, timezone, calendar)")
                                .font(.caption2)
                            Text("✓ Handle accessibility (reduce motion, voice over, etc.)")
                                .font(.caption2)
                            Text("✓ Provide actions (dismiss, openURL, refresh)")
                                .font(.caption2)
                            Text("✓ Adapt to display (color scheme, size class)")
                                .font(.caption2)
                            Text("✓ Style text and UI (font, colors, shapes)")
                                .font(.caption2)
                            Text("✓ Share global objects (Core Data, SwiftData)")
                                .font(.caption2)
                            Text("✓ Enable custom dependency injection")
                                .font(.caption2)
                        }

                        Text("This is why SwiftUI code is so compact - environment handles what would be hundreds of lines of prop drilling in other frameworks!")
                            .font(.caption)
                            .foregroundColor(.green)
                            .padding(.top, 8)
                    }
                })
            }
            .padding()
        }
    }
}

// MARK: - Helper Views

struct StatusIndicator: View {
    let label: String
    let color: Color
    let usesColorOnly: Bool

    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor

    var body: some View {
        VStack {
            Circle()
                .fill(color)
                .frame(width: 40, height: 40)
                .overlay {
                    if differentiateWithoutColor && usesColorOnly {
                        Image(systemName: label == "Success" ? "checkmark" : "xmark")
                            .foregroundStyle(.white)
                    }
                }
            Text(label)
                .font(.caption2)
        }
    }
}

struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label + ":")
                .font(.caption2)
                .bold()
                .frame(width: 100, alignment: .leading)
            Text(value)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}

struct EnvironmentColorBox: View {
    let color: Color
    let label: String

    var body: some View {
        Text(label)
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background(color.opacity(0.3))
            .cornerRadius(8)
    }
}

extension UserInterfaceSizeClass {
    var description: String {
        switch self {
        case .compact: return "Compact"
        case .regular: return "Regular"
        @unknown default: return "Unknown"
        }
    }
}

struct CategoryRow: View {
    let icon: String
    let title: String
    let count: String
    let examples: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(.blue)
                .frame(width: 30)

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(title)
                        .font(.caption)
                        .bold()
                    Text(count)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                Text(examples)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

struct PatternRow: View {
    let title: String
    let code: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .bold()
            Text(code)
                .font(.system(.caption2, design: .monospaced))
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Preview

#Preview {
    TabView {
        EnvironmentFundamentalsExample()
            .tabItem { Label("Fundamentals", systemImage: "book.fill") }

        SystemIntegrationExample()
            .tabItem { Label("System", systemImage: "gear") }

        UIFeaturesExample()
            .tabItem { Label("UI Features", systemImage: "paintbrush.fill") }

        EnvironmentSummaryExample()
            .tabItem { Label("Summary", systemImage: "star.fill") }
    }
}
