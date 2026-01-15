//
//  CustomEnvironmentKeys.swift
//  ThinkingInSwiftUI
//
//  Custom Environment Keys & Custom Component Styles
//  How to create your own environment values and styleable components like ButtonStyle
//

import SwiftUI

// MARK: - Custom Environment Keys
//
// Three steps to create a custom environment key:
// 1. Create an EnvironmentKey with a default value
// 2. Add a property on EnvironmentValues for type-safe access
// 3. (Optional) Add a helper method on View for convenience

// MARK: - Tab 1: Basic Custom Environment Key

struct CustomEnvironmentKeyExample: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Custom Environment Keys")
                    .font(.title)
                    .bold()
                
                Text("Creating your own environment values for custom components")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Three-Step Pattern")
                            .font(.headline)
                        
                        Text("Step 1: Define the Key")
                            .font(.caption)
                            .bold()
                        
                        Text("""
                        enum BadgeColorKey: EnvironmentKey {
                            static var defaultValue: Color = .blue
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                        
                        Text("Step 2: Extend EnvironmentValues")
                            .font(.caption)
                            .bold()
                            .padding(.top, 8)
                        
                        Text("""
                        extension EnvironmentValues {
                            var badgeColor: Color {
                                get { self[BadgeColorKey.self] }
                                set { self[BadgeColorKey.self] = newValue }
                            }
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                        
                        Text("Step 3: Add View Helper (Optional)")
                            .font(.caption)
                            .bold()
                            .padding(.top, 8)
                        
                        Text("""
                        extension View {
                            func badgeColor(_ color: Color) -> some View {
                                environment(\\\\.badgeColor, color)
                            }
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
                        Text("Using the Custom Environment Key")
                            .font(.headline)
                        
                        Text("In your custom component:")
                            .font(.caption)
                        
                        Text("""
                        struct Badge: ViewModifier {
                            @Environment(\\\\.badgeColor) private var badgeColor
                        
                            func body(content: Content) -> some View {
                                content
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 2)
                                    .background {
                                        Capsule(style: .continuous)
                                            .fill(badgeColor)
                                    }
                            }
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
                        Text("Example: Default Badge Color")
                            .font(.headline)
                        
                        Text("Inbox")
                            .overlay(
                                Text(3000, format: .number)
                                    .modifier(SimpleBadge())
                                , alignment: .topTrailing)
                            .padding()
                            .background(Color.blue.opacity(0.1))
                        
                        Text("Uses default .blue from BadgeColorKey")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                })
                
                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: Custom Badge Color")
                            .font(.headline)
                        
                        VStack(spacing: 15) {
                            Text("Spam")
                                .overlay(
                                    Text(42, format: .number)
                                        .modifier(SimpleBadge())
                                    , alignment: .topTrailing)
                            
                            Text("Trash")
                                .overlay(
                                    Text(7, format: .number)
                                        .modifier(SimpleBadge())
                                    , alignment: .topTrailing)
                        }
                        .simpleBadgeColor(.orange)
                        .padding()
                        .background(Color.orange.opacity(0.1))
                        
                        Text("Both badges inherit .orange from parent")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                })
                
                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Key Insight")
                            .font(.headline)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("• Environment keys provide TYPE-SAFE custom values")
                                .font(.caption2)
                            Text("• Default value used when not explicitly set")
                                .font(.caption2)
                            Text("• Values propagate DOWN the view tree")
                                .font(.caption2)
                            Text("• Children can override for their subtree")
                                .font(.caption2)
                            Text("• No stringly-typed keys or type casting needed!")
                                .font(.caption2)
                                .foregroundColor(.green)
                        }
                    }
                })
            }
            .padding()
        }
    }
}

// MARK: - Tab 2: Custom Style Protocol

struct CustomStyleProtocolExample: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Custom Style Protocol")
                    .font(.title)
                    .bold()
                
                Text("Creating a BadgeStyle protocol like ButtonStyle")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Style Protocol Pattern")
                            .font(.headline)
                        
                        Text("Step 1: Define the Protocol")
                            .font(.caption)
                            .bold()
                        
                        Text("""
                        protocol BadgeStyle {
                            associatedtype Body: View
                            @ViewBuilder func makeBody(_ label: AnyView) -> Body
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                        
                        Text("Step 2: Create Default Style")
                            .font(.caption)
                            .bold()
                            .padding(.top, 8)
                        
                        Text("""
                        struct DefaultBadgeStyle: BadgeStyle {
                            func makeBody(_ label: AnyView) -> some View {
                                label
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 2)
                                    .background {
                                        Capsule(style: .continuous).fill(.red)
                                    }
                            }
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                        
                        Text("Step 3: Create Environment Key with Existential")
                            .font(.caption)
                            .bold()
                            .padding(.top, 8)
                        
                        Text("""
                        enum BadgeStyleKey: EnvironmentKey {
                            static var defaultValue: any BadgeStyle = DefaultBadgeStyle()
                        }
                        
                        extension EnvironmentValues {
                            var badgeStyle: any BadgeStyle {
                                get { self[BadgeStyleKey.self] }
                                set { self[BadgeStyleKey.self] = newValue }
                            }
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                        
                        Text("💡 'any BadgeStyle' is an existential - hides concrete type")
                            .font(.caption)
                            .foregroundColor(.orange)
                    }
                })
                
                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Using the Style")
                            .font(.headline)
                        
                        Text("""
                        struct OverlayBadge<Label: View>: ViewModifier {
                            var label: Label
                            @Environment(\\\\.badgeStyle) private var badgeStyle
                        
                            func body(content: Content) -> some View {
                                content.overlay(alignment: .topTrailing) {
                                    AnyView(badgeStyle.makeBody(AnyView(label)))
                                        .fixedSize()
                                }
                            }
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
                        Text("Example: Default Badge Style")
                            .font(.headline)
                        
                        Text("Hello")
                            .badge { Text(100, format: .number) }
                            .font(.title2)
                            .padding()
                            .background(Color.blue.opacity(0.1))
                        
                        Text("Uses DefaultBadgeStyle")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                })
                
                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: Custom Fancy Style")
                            .font(.headline)
                        
                        HStack(spacing: 30) {
                            Text("Inbox")
                                .badge { Text(5, format: .number) }
                            Text("Spam")
                                .badge { Text(3000, format: .number) }
                        }
                        .font(.title2)
                        .badgeStyle(.fancy)
                        .padding()
                        .background(Color.purple.opacity(0.1))
                        
                        Text("Uses FancyBadgeStyle with gradient")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        
                        Text("""
                        .badgeStyle(.fancy)
                        
                        // Static property for convenience:
                        extension BadgeStyle where Self == FancyBadgeStyle {
                            static var fancy: FancyBadgeStyle { FancyBadgeStyle() }
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
                        Text("Why Use Existentials?")
                            .font(.headline)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("❌ Can't use: var badgeStyle: DefaultBadgeStyle")
                                .font(.caption2)
                                .foregroundColor(.red)
                            Text("   → Would lock us to one concrete type forever")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            
                            Text("✅ Must use: var badgeStyle: any BadgeStyle")
                                .font(.caption2)
                                .foregroundColor(.green)
                                .padding(.top, 4)
                            Text("   → Allows ANY type conforming to BadgeStyle")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            
                            Text("This is how ButtonStyle, ToggleStyle, etc. work!")
                                .font(.caption)
                                .foregroundColor(.orange)
                                .padding(.top, 8)
                        }
                    }
                })
            }
            .padding()
        }
    }
}

// MARK: - Tab 3: Environment in Custom Styles

struct EnvironmentInStylesExample: View {
    @State private var isDisabled = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Environment in Styles")
                    .font(.title)
                    .bold()
                
                Text("Using @Environment in custom styles with DynamicProperty")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Problem")
                            .font(.headline)
                        
                        Text("""
                        struct MyStyle: BadgeStyle {
                            @Environment(\\\\.isEnabled) var isEnabled  // ❌ Doesn't work!
                        
                            func makeBody(_ label: AnyView) -> some View {
                                label
                                    .opacity(isEnabled ? 1 : 0.5)
                            }
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(5)
                        
                        Text("Runtime warning:")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.red)
                            .padding(.top, 8)
                        
                        Text("\"Accessing Environment's value outside of being installed on a View. This will always read the default value and will not update.\"")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .italic()
                        
                        Text("Styles aren't Views - they can't use @Environment directly!")
                            .font(.caption)
                            .foregroundColor(.orange)
                            .padding(.top, 8)
                    }
                })
                
                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Solution: DynamicProperty + resolve()")
                            .font(.headline)
                        
                        Text("Step 1: Conform to DynamicProperty")
                            .font(.caption)
                            .bold()
                        
                        Text("""
                        protocol BadgeStyle: DynamicProperty {
                            associatedtype Body: View
                            @ViewBuilder func makeBody(_ label: AnyView) -> Body
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                        
                        Text("Step 2: Create Resolver View (generic over concrete style)")
                            .font(.caption)
                            .bold()
                            .padding(.top, 8)
                        
                        Text("""
                        struct ResolvedBadgeStyle<Style: BadgeStyle>: View {
                            var label: AnyView
                            var style: Style  // Concrete type!
                        
                            var body: some View {
                                style.makeBody(label)
                            }
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                        
                        Text("Step 3: Add resolve() on protocol")
                            .font(.caption)
                            .bold()
                            .padding(.top, 8)
                        
                        Text("""
                        extension BadgeStyle {
                            func resolve(label: AnyView) -> some View {
                                ResolvedBadgeStyle(label: label, style: self)
                            }
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                        
                        Text("Step 4: Call resolve() instead of makeBody()")
                            .font(.caption)
                            .bold()
                            .padding(.top, 8)
                        
                        Text("""
                        struct OverlayBadge<Label: View>: ViewModifier {
                            @Environment(\\\\.badgeStyle) private var badgeStyle
                        
                            func body(content: Content) -> some View {
                                content.overlay {
                                    // Call resolve() instead of makeBody()
                                    AnyView(badgeStyle.resolve(label: AnyView(label)))
                                }
                            }
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
                        Text("Why This Works")
                            .font(.headline)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("1️⃣ DynamicProperty tells SwiftUI to update properties")
                                .font(.caption2)
                            Text("2️⃣ ResolvedBadgeStyle is a View (can use @Environment)")
                                .font(.caption2)
                            Text("3️⃣ Generic <Style> gives concrete type (not 'any BadgeStyle')")
                                .font(.caption2)
                            Text("4️⃣ SwiftUI updates @Environment on the concrete style")
                                .font(.caption2)
                            Text("5️⃣ resolve() bridges from existential to concrete")
                                .font(.caption2)
                                .foregroundColor(.green)
                        }
                    }
                })
                
                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: Adaptive Badge Style")
                            .font(.headline)
                        
                        Toggle("Disable badges", isOn: $isDisabled)
                            .padding(.bottom, 8)
                        
                        HStack(spacing: 30) {
                            Text("Inbox")
                                .badge { Text(5, format: .number) }
                            Text("Spam")
                                .badge { Text(42, format: .number) }
                        }
                        .font(.title2)
                        .badgeStyle(.adaptive)
                        .disabled(isDisabled)
                        .padding()
                        .background(Color.green.opacity(0.1))
                        
                        Text("AdaptiveBadgeStyle reads @Environment(\\\\.isEnabled)")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        
                        Text("""
                        struct AdaptiveBadgeStyle: BadgeStyle {
                            @Environment(\\\\.isEnabled) var isEnabled  // ✅ Works now!
                        
                            func makeBody(_ label: AnyView) -> some View {
                                label
                                    .opacity(isEnabled ? 1 : 0.5)
                                    .saturation(isEnabled ? 1 : 0)
                            }
                        }
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

// MARK: - Tab 4: Complete Example

struct CompleteCustomStyleExample: View {
    @State private var isDisabled = false
    @State private var selectedStyle: StyleChoice = .default
    
    enum StyleChoice: String, CaseIterable, Identifiable {
        case `default` = "Default"
        case fancy = "Fancy"
        case adaptive = "Adaptive"
        
        var id: String { rawValue }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Complete Example")
                    .font(.title)
                    .bold()
                
                Text("Putting it all together: custom keys + custom styles + environment")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Summary: What We Built")
                            .font(.headline)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("✅ Custom environment key (badgeColor)")
                                .font(.caption2)
                            Text("✅ Custom style protocol (BadgeStyle)")
                                .font(.caption2)
                            Text("✅ Multiple style implementations")
                                .font(.caption2)
                            Text("✅ Styles can read @Environment")
                                .font(.caption2)
                            Text("✅ Type-safe, discoverable API")
                                .font(.caption2)
                            Text("✅ Works exactly like ButtonStyle!")
                                .font(.caption2)
                                .foregroundColor(.green)
                        }
                    }
                })
                
                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Interactive Demo")
                            .font(.headline)
                        
                        Picker("Badge Style", selection: $selectedStyle) {
                            ForEach(StyleChoice.allCases) { style in
                                Text(style.rawValue).tag(style)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        Toggle("Disable badges", isOn: $isDisabled)
                        
                        Divider()
                        
                        VStack(spacing: 20) {
                            Text("Messages")
                                .font(.title2)
                                .bold()
                            
                            HStack(spacing: 30) {
                                VStack {
                                    Text("📥")
                                        .font(.largeTitle)
                                    Text("Inbox")
                                        .badge { Text(5, format: .number) }
                                }
                                
                                VStack {
                                    Text("⚠️")
                                        .font(.largeTitle)
                                    Text("Spam")
                                        .badge { Text(999, format: .number) }
                                }
                                
                                VStack {
                                    Text("🗑️")
                                        .font(.largeTitle)
                                    Text("Trash")
                                        .badge { Text(42, format: .number) }
                                }
                            }
                        }
                        .appliedBadgeStyle(selectedStyle)
                        .disabled(isDisabled)
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                    }
                })
                
                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Pattern")
                            .font(.headline)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            PatternStep(
                                number: "1",
                                title: "Create environment key",
                                description: "enum MyKey: EnvironmentKey"
                            )
                            
                            PatternStep(
                                number: "2",
                                title: "Extend EnvironmentValues",
                                description: "var myValue: Type { get/set }"
                            )
                            
                            PatternStep(
                                number: "3",
                                title: "Create style protocol",
                                description: "protocol MyStyle: DynamicProperty"
                            )
                            
                            PatternStep(
                                number: "4",
                                title: "Create resolver view",
                                description: "struct Resolved<Style>: View"
                            )
                            
                            PatternStep(
                                number: "5",
                                title: "Add resolve() helper",
                                description: "extension MyStyle { func resolve() }"
                            )
                            
                            PatternStep(
                                number: "6",
                                title: "Use resolve() in modifier",
                                description: "style.resolve(config)"
                            )
                        }
                    }
                })
                
                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Key Takeaways")
                            .font(.headline)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            TakeawayRow(
                                icon: "key.fill",
                                text: "Custom environment keys = type-safe custom values"
                            )
                            
                            TakeawayRow(
                                icon: "paintbrush.fill",
                                text: "Custom styles = reusable component theming"
                            )
                            
                            TakeawayRow(
                                icon: "arrow.down.circle.fill",
                                text: "Environment propagates DOWN the tree"
                            )
                            
                            TakeawayRow(
                                icon: "bolt.fill",
                                text: "DynamicProperty + resolve() = @Environment in styles"
                            )
                            
                            TakeawayRow(
                                icon: "star.fill",
                                text: "Same patterns Apple uses for ButtonStyle, etc."
                            )
                        }
                    }
                })
            }
            .padding()
        }
    }
}

// MARK: - Implementation Details

// Step 1: Custom Environment Key for badge color
enum SimpleBadgeColorKey: EnvironmentKey {
    static var defaultValue: Color = .blue
}

extension EnvironmentValues {
    var simpleBadgeColor: Color {
        get { self[SimpleBadgeColorKey.self] }
        set { self[SimpleBadgeColorKey.self] = newValue }
    }
}

extension View {
    func simpleBadgeColor(_ color: Color) -> some View {
        environment(\.simpleBadgeColor, color)
    }
}

// Simple badge modifier using custom environment key
struct SimpleBadge: ViewModifier {
    @Environment(\.simpleBadgeColor) private var badgeColor
    
    func body(content: Content) -> some View {
        content
            .fixedSize()
            .font(.caption)
            .foregroundColor(.white)
            .padding(.horizontal, 5)
            .padding(.vertical, 2)
            .background {
                Capsule(style: .continuous)
                    .fill(badgeColor)
            }
            .alignmentGuide(.top) { d in return d.height / 2}
            .alignmentGuide(.trailing) { d in return d.width / 2}
    }
}

// Step 2: Badge Style Protocol (like ButtonStyle)
protocol BadgeStyle: DynamicProperty {
    associatedtype Body: View
    @ViewBuilder func makeBody(_ label: AnyView) -> Body
}

// Default badge style
struct DefaultBadgeStyle: BadgeStyle {
    func makeBody(_ label: AnyView) -> some View {
        label
            .font(.caption)
            .foregroundColor(.white)
            .padding(.horizontal, 5)
            .padding(.vertical, 2)
            .background {
                Capsule(style: .continuous)
                    .fill(.red)
            }
    }
}

// Fancy badge style with gradient
struct FancyBadgeStyle: BadgeStyle {
    var background: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(Color.red)
                .overlay {
                    ContainerRelativeShape()
                        .fill(LinearGradient(
                            colors: [.white, .clear],
                            startPoint: .top,
                            endPoint: .center
                        ))
                }
            ContainerRelativeShape()
                .strokeBorder(Color.white, lineWidth: 2)
                .shadow(radius: 2)
        }
    }
    
    func makeBody(_ label: AnyView) -> some View {
        label
            .foregroundColor(.white)
            .font(.caption)
            .padding(.horizontal, 7)
            .padding(.vertical, 4)
            .background(background)
            .containerShape(Capsule(style: .continuous))
    }
}

// Adaptive badge style that reads environment
struct AdaptiveBadgeStyle: BadgeStyle {
    @Environment(\.isEnabled) var isEnabled
    
    func makeBody(_ label: AnyView) -> some View {
        label
            .font(.caption)
            .foregroundColor(.white)
            .padding(.horizontal, 5)
            .padding(.vertical, 2)
            .background {
                Capsule(style: .continuous)
                    .fill(.blue)
            }
            .opacity(isEnabled ? 1 : 0.5)
            .saturation(isEnabled ? 1 : 0)
    }
}

// Environment key for badge style
enum BadgeStyleKey: EnvironmentKey {
    static var defaultValue: any BadgeStyle = DefaultBadgeStyle()
}

extension EnvironmentValues {
    var badgeStyle: any BadgeStyle {
        get { self[BadgeStyleKey.self] }
        set { self[BadgeStyleKey.self] = newValue }
    }
}

// Step 3: Resolver view (generic over concrete style type)
struct ResolvedBadgeStyle<Style: BadgeStyle>: View {
    var label: AnyView
    var style: Style
    
    var body: some View {
        style.makeBody(label)
    }
}

// Step 4: resolve() helper to bridge existential to concrete
extension BadgeStyle {
    func resolve(label: AnyView) -> some View {
        ResolvedBadgeStyle(label: label, style: self)
    }
}

// Badge modifier that uses the style
struct OverlayBadge<Label: View>: ViewModifier {
    var alignment: Alignment = .topTrailing
    var label: Label
    
    @Environment(\.badgeStyle) private var badgeStyle
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: alignment) {
                AnyView(badgeStyle.resolve(label: AnyView(label)))
                    .fixedSize()
                    .alignmentGuide(alignment.horizontal) { $0[HorizontalAlignment.center] }
                    .alignmentGuide(alignment.vertical) { $0[VerticalAlignment.center] }
            }
    }
}

// Convenience View extension
extension View {
    func badge<V: View>(alignment: Alignment = .topTrailing, @ViewBuilder _ content: () -> V) -> some View {
        modifier(OverlayBadge(alignment: alignment, label: content()))
    }
    
    func badgeStyle(_ style: any BadgeStyle) -> some View {
        environment(\.badgeStyle, style)
    }
}

// Static property extensions for nice syntax
extension BadgeStyle where Self == DefaultBadgeStyle {
    static var `default`: DefaultBadgeStyle {
        DefaultBadgeStyle()
    }
}

extension BadgeStyle where Self == FancyBadgeStyle {
    static var fancy: FancyBadgeStyle {
        FancyBadgeStyle()
    }
}

extension BadgeStyle where Self == AdaptiveBadgeStyle {
    static var adaptive: AdaptiveBadgeStyle {
        AdaptiveBadgeStyle()
    }
}

// Helper for demo
extension View {
    func appliedBadgeStyle(_ choice: CompleteCustomStyleExample.StyleChoice) -> some View {
        Group {
            switch choice {
            case .default:
                self.badgeStyle(.default)
            case .fancy:
                self.badgeStyle(.fancy)
            case .adaptive:
                self.badgeStyle(.adaptive)
            }
        }
    }
}

// MARK: - Helper Views

struct PatternStep: View {
    let number: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Text(number)
                .font(.caption)
                .bold()
                .foregroundColor(.white)
                .frame(width: 24, height: 24)
                .background(Circle().fill(Color.blue))
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .bold()
                Text(description)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct TakeawayRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 20)
            Text(text)
                .font(.caption)
        }
    }
}

// MARK: - Preview

#Preview {
    TabView {
        CustomEnvironmentKeyExample()
            .tabItem { Label("Custom Keys", systemImage: "key.fill") }
        
        CustomStyleProtocolExample()
            .tabItem { Label("Style Protocol", systemImage: "paintbrush.fill") }
        
        EnvironmentInStylesExample()
            .tabItem { Label("Environment", systemImage: "bolt.fill") }
        
        CompleteCustomStyleExample()
            .tabItem { Label("Complete", systemImage: "star.fill") }
    }
}
