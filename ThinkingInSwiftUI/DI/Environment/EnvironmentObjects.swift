//
//  EnvironmentObjects.swift
//  ThinkingInSwiftUI
//
//  Environment Objects: Passing Observable Objects Through the View Hierarchy
//  iOS 17+ uses @Observable + @Environment, earlier versions use ObservableObject + @EnvironmentObject
//

import SwiftUI

// MARK: - Tab 1: iOS 17+ Environment Objects (@Observable)

struct ModernEnvironmentObjectsExample: View {
    @State private var userModel = UserModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Environment Objects (iOS 17+)")
                    .font(.title)
                    .bold()

                Text("Pass observable objects through the view hierarchy without manual prop drilling")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox(label: EmptyView()) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Modern Approach")
                            .font(.headline)

                        Text("With iOS 17+, environment objects use the @Observable macro and the same @Environment property wrapper used for values.")
                            .font(.caption)

                        Text("""
                        // 1. Define the model with @Observable
                        @Observable final class UserModel {
                            var name: String = "Guest"
                            var isLoggedIn: Bool = false
                        }

                        // 2. Read from environment using type as key
                        struct ProfileView: View {
                            @Environment(UserModel.self) var user: UserModel?

                            var body: some View {
                                Text(user?.name ?? "Not logged in")
                            }
                        }

                        // 3. Inject into environment
                        ContentView()
                            .environment(UserModel())
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox(label: EmptyView()) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Live Example: User Session")
                            .font(.headline)

                        Text("The UserModel is set in the environment and accessed by nested views")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        VStack(spacing: 15) {
                            // Parent controls
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Parent View Controls:")
                                    .font(.caption)
                                    .bold()

                                TextField("User name", text: $userModel.name)
                                    .textFieldStyle(.roundedBorder)

                                Toggle("Logged In", isOn: $userModel.isLoggedIn)
                            }
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)

                            Image(systemName: "arrow.down")
                                .foregroundColor(.secondary)

                            // Nested view reading from environment
                            UserProfileCard()
                                .environment(userModel)
                        }
                    }
                }

                GroupBox(label: EmptyView()) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Optional vs Non-Optional")
                            .font(.headline)

                        Text("""
                        // Optional - safe, returns nil if not in environment
                        @Environment(UserModel.self) var user: UserModel?

                        // Non-optional - CRASHES if not in environment!
                        @Environment(UserModel.self) var user: UserModel
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(5)

                        HStack(spacing: 8) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.orange)
                            Text("Use optional types when the object might not be present")
                                .font(.caption2)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Tab 2: Real-Life Example - Shopping Cart

@Observable final class ShoppingCart {
    var items: [CartItem] = []

    var totalPrice: Double {
        items.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
    }

    var itemCount: Int {
        items.reduce(0) { $0 + $1.quantity }
    }

    func addItem(_ item: CartItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].quantity += 1
        } else {
            items.append(item)
        }
    }

    func removeItem(_ item: CartItem) {
        items.removeAll { $0.id == item.id }
    }

    func clear() {
        items.removeAll()
    }
}

struct CartItem: Identifiable {
    let id: String
    let name: String
    let price: Double
    var quantity: Int
}

struct ShoppingCartExample: View {
    @State private var cart = ShoppingCart()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Real-Life: Shopping Cart")
                    .font(.title)
                    .bold()

                Text("E-commerce apps need cart state accessible from product listings, detail views, and checkout")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox(label: EmptyView()) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Why Environment Objects?")
                            .font(.headline)

                        FeatureRow(icon: "cart.fill", title: "Global Access",
                                   description: "Any view can read/modify the cart without prop drilling")

                        FeatureRow(icon: "arrow.triangle.branch", title: "Deep Nesting",
                                   description: "Product cards in grids in tabs can access cart directly")

                        FeatureRow(icon: "bell.fill", title: "Automatic Updates",
                                   description: "All views update when cart changes")
                    }
                }

                // Simulated app structure
                GroupBox(label: EmptyView()) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Live Demo: Product Catalog")
                            .font(.headline)

                        // Cart badge in header
                        HStack {
                            Text("Store")
                                .font(.headline)
                            Spacer()
                            CartBadgeView()
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)

                        // Product grid
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                            ProductCard(item: CartItem(id: "1", name: "SwiftUI Book", price: 49.99, quantity: 1))
                            ProductCard(item: CartItem(id: "2", name: "Xcode Stickers", price: 9.99, quantity: 1))
                            ProductCard(item: CartItem(id: "3", name: "WWDC Shirt", price: 29.99, quantity: 1))
                            ProductCard(item: CartItem(id: "4", name: "Swift Pin", price: 4.99, quantity: 1))
                        }

                        // Cart summary
                        if !cart.items.isEmpty {
                            Divider()
                            CartSummaryView()
                        }
                    }
                    .environment(cart)
                }

                GroupBox(label: EmptyView()) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Implementation Pattern")
                            .font(.headline)

                        Text("""
                        // App root injects the cart
                        @main
                        struct StoreApp: App {
                            @State private var cart = ShoppingCart()

                            var body: some Scene {
                                WindowGroup {
                                    ContentView()
                                        .environment(cart)
                                }
                            }
                        }

                        // Any nested view can access it
                        struct ProductCard: View {
                            @Environment(ShoppingCart.self) var cart
                            let product: Product

                            var body: some View {
                                Button("Add to Cart") {
                                    cart.addItem(product)
                                }
                            }
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Tab 3: Real-Life Example - App Settings

@Observable final class AppSettings {
    var isDarkMode: Bool = false
    var fontSize: Double = 14
    var notificationsEnabled: Bool = true
    var language: String = "English"

    enum FontSize: String, CaseIterable {
        case small = "Small"
        case medium = "Medium"
        case large = "Large"

        var value: Double {
            switch self {
            case .small: return 12
            case .medium: return 14
            case .large: return 18
            }
        }
    }
}

struct AppSettingsExample: View {
    @State private var settings = AppSettings()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Real-Life: App Settings")
                    .font(.title)
                    .bold()

                Text("User preferences that affect the entire app's appearance and behavior")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox(label: EmptyView()) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Settings Panel")
                            .font(.headline)

                        Toggle("Dark Mode", isOn: $settings.isDarkMode)

                        VStack(alignment: .leading) {
                            Text("Font Size: \(Int(settings.fontSize))pt")
                                .font(.caption)
                            Slider(value: $settings.fontSize, in: 10...24, step: 2)
                        }

                        Toggle("Notifications", isOn: $settings.notificationsEnabled)
                    }
                    .padding(.vertical, 8)
                }

                GroupBox(label: EmptyView()) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Preview: Settings Applied")
                            .font(.headline)

                        SettingsPreviewCard()
                            .environment(settings)
                    }
                }

                GroupBox(label: EmptyView()) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Why Environment Over @AppStorage?")
                            .font(.headline)

                        EnvironmentComparisonRow(
                            leftTitle: "@AppStorage",
                            leftPoints: ["Simple key-value pairs", "Persisted to UserDefaults", "No computed properties"],
                            rightTitle: "Environment Object",
                            rightPoints: ["Complex objects with methods", "In-memory (persist manually)", "Computed properties & logic"]
                        )

                        Text("Use environment objects when you need shared state with business logic, computed properties, or methods.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Tab 4: Legacy Approach (Pre-iOS 17)

// ObservableObject for pre-iOS 17
class LegacyUserModel: ObservableObject {
    @Published var name: String = "Guest"
    @Published var isLoggedIn: Bool = false
}

struct LegacyEnvironmentObjectsExample: View {
    @StateObject private var userModel = LegacyUserModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Legacy: Pre-iOS 17")
                    .font(.title)
                    .bold()

                Text("For apps targeting iOS 16 and earlier")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox(label: EmptyView()) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Legacy Approach")
                            .font(.headline)

                        Text("""
                        // 1. Model conforms to ObservableObject
                        class UserModel: ObservableObject {
                            @Published var name: String = "Guest"
                            @Published var isLoggedIn: Bool = false
                        }

                        // 2. Read with @EnvironmentObject (NOT @Environment)
                        struct ProfileView: View {
                            @EnvironmentObject var user: UserModel

                            var body: some View {
                                Text(user.name)
                            }
                        }

                        // 3. Inject with .environmentObject() (NOT .environment())
                        ContentView()
                            .environmentObject(UserModel())
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox(label: EmptyView()) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Key Differences")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 12) {
                            DifferenceRow(
                                aspect: "Property Wrapper",
                                modern: "@Environment(Type.self)",
                                legacy: "@EnvironmentObject"
                            )
                            DifferenceRow(
                                aspect: "View Modifier",
                                modern: ".environment(object)",
                                legacy: ".environmentObject(object)"
                            )
                            DifferenceRow(
                                aspect: "Model Protocol",
                                modern: "@Observable macro",
                                legacy: "ObservableObject protocol"
                            )
                            DifferenceRow(
                                aspect: "Optional Support",
                                modern: "Yes (Type?)",
                                legacy: "No - crashes if missing"
                            )
                        }
                    }
                }

                GroupBox(label: EmptyView()) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Live Example (Legacy)")
                            .font(.headline)

                        VStack(spacing: 15) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Parent View Controls:")
                                    .font(.caption)
                                    .bold()

                                TextField("User name", text: $userModel.name)
                                    .textFieldStyle(.roundedBorder)

                                Toggle("Logged In", isOn: $userModel.isLoggedIn)
                            }
                            .padding()
                            .background(Color.purple.opacity(0.1))
                            .cornerRadius(8)

                            Image(systemName: "arrow.down")
                                .foregroundColor(.secondary)

                            LegacyUserProfileCard()
                                .environmentObject(userModel)
                        }
                    }
                }

                GroupBox(label: EmptyView()) {
                    VStack(alignment: .leading, spacing: 15) {
                        HStack(spacing: 8) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.orange)
                            Text("Critical Warning")
                                .font(.headline)
                        }

                        Text("@EnvironmentObject does NOT support optional types. If the object is missing from the environment and you access the property, your app WILL crash.")
                            .font(.caption)

                        Text("""
                        // This will CRASH if UserModel not in environment!
                        struct ProfileView: View {
                            @EnvironmentObject var user: UserModel // Not optional!

                            var body: some View {
                                Text(user.name) // Crash here
                            }
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(5)
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Tab 5: Dependency Injection Helper Pattern

struct DependencyInjectionPatternExample: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Dependency Injection Helper")
                    .font(.title)
                    .bold()

                Text("Bundle all environment object setters into a single reusable method")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox(label: EmptyView()) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Problem")
                            .font(.headline)

                        Text("Real apps often have multiple environment objects. Without organization, injection becomes messy:")
                            .font(.caption)

                        Text("""
                        // Messy - dependencies scattered everywhere
                        ContentView()
                            .environmentObject(UserModel())
                            .environmentObject(ShoppingCart())
                            .environmentObject(AppSettings())
                            .environmentObject(NetworkMonitor())
                            .environmentObject(AnalyticsTracker())
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox(label: EmptyView()) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Solution: Helper Extension")
                            .font(.headline)

                        Text("""
                        // Clean - all dependencies in one place
                        extension View {
                            func injectDependencies() -> some View {
                                self
                                    .environmentObject(UserModel())
                                    .environmentObject(ShoppingCart())
                                    .environmentObject(AppSettings())
                                    .environmentObject(NetworkMonitor())
                                    .environmentObject(AnalyticsTracker())
                            }
                        }

                        // Usage - simple and clean
                        @main
                        struct MyApp: App {
                            var body: some Scene {
                                WindowGroup {
                                    ContentView()
                                        .injectDependencies()
                                }
                            }
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox(label: EmptyView()) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Preview Benefits")
                            .font(.headline)

                        Text("The helper shines in previews where you can override specific dependencies:")
                            .font(.caption)

                        Text("""
                        #Preview {
                            ProfileView()
                                // Override with mock user for this preview
                                .environmentObject(UserModel.mock())
                                // Get all other dependencies from helper
                                .injectDependencies()
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)

                        HStack(spacing: 8) {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(.blue)
                            Text("Modifiers applied first take precedence - your mock overrides the helper's default")
                                .font(.caption2)
                        }
                    }
                }

                GroupBox(label: EmptyView()) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Subclassing Works!")
                            .font(.headline)

                        Text("Environment objects support subclassing - great for mocks:")
                            .font(.caption)

                        Text("""
                        class UserModel: ObservableObject {
                            @Published var name: String = ""

                            static func mock() -> UserModel {
                                MockUserModel() // Returns subclass
                            }
                        }

                        class MockUserModel: UserModel {
                            override init() {
                                super.init()
                                self.name = "Test User"
                            }
                        }

                        // The nested view still reads correctly
                        // even though mock() returns a subclass
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox(label: EmptyView()) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("iOS 17+ Version")
                            .font(.headline)

                        Text("""
                        extension View {
                            func injectDependencies(
                                user: UserModel = UserModel(),
                                cart: ShoppingCart = ShoppingCart(),
                                settings: AppSettings = AppSettings()
                            ) -> some View {
                                self
                                    .environment(user)
                                    .environment(cart)
                                    .environment(settings)
                            }
                        }

                        // Override specific dependencies easily
                        #Preview {
                            CheckoutView()
                                .injectDependencies(
                                    cart: .previewWithItems
                                )
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Tab 6: Best Practices & Patterns

struct EnvironmentObjectsBestPracticesExample: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Best Practices")
                    .font(.title)
                    .bold()

                Text("Guidelines for using environment objects effectively")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox(label: EmptyView()) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("When to Use Environment Objects")
                            .font(.headline)

                        BestPracticeRow(
                            icon: "checkmark.circle.fill",
                            iconColor: .green,
                            title: "Shared App State",
                            description: "User session, shopping cart, app settings"
                        )

                        BestPracticeRow(
                            icon: "checkmark.circle.fill",
                            iconColor: .green,
                            title: "Deep View Hierarchies",
                            description: "When data needs to skip multiple levels"
                        )

                        BestPracticeRow(
                            icon: "checkmark.circle.fill",
                            iconColor: .green,
                            title: "Cross-Feature Communication",
                            description: "When sibling features need shared state"
                        )
                    }
                }

                GroupBox(label: EmptyView()) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("When NOT to Use Environment Objects")
                            .font(.headline)

                        BestPracticeRow(
                            icon: "xmark.circle.fill",
                            iconColor: .red,
                            title: "Simple Parent-Child",
                            description: "Just pass data directly as parameters"
                        )

                        BestPracticeRow(
                            icon: "xmark.circle.fill",
                            iconColor: .red,
                            title: "View-Specific State",
                            description: "Use @State for local component state"
                        )

                        BestPracticeRow(
                            icon: "xmark.circle.fill",
                            iconColor: .red,
                            title: "Persisted Settings",
                            description: "Consider @AppStorage for simple persisted values"
                        )
                    }
                }

                GroupBox(label: EmptyView()) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Common Patterns")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 12) {
                            PatternItem(
                                number: "1",
                                title: "Single Source of Truth",
                                description: "Create environment objects at the app root and inject once"
                            )

                            PatternItem(
                                number: "2",
                                title: "Protocol Abstractions",
                                description: "Define protocols for testability and swap implementations"
                            )

                            PatternItem(
                                number: "3",
                                title: "Feature Scoping",
                                description: "Inject feature-specific objects at feature root, not app root"
                            )

                            PatternItem(
                                number: "4",
                                title: "Preview Factories",
                                description: "Create static factory methods for common preview states"
                            )
                        }
                    }
                }

                GroupBox(label: EmptyView()) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Migration Path: iOS 16 -> iOS 17+")
                            .font(.headline)

                        Text("""
                        // Step 1: Add @Observable alongside ObservableObject
                        @Observable
                        class UserModel: ObservableObject {
                            @Published var name: String = ""
                        }

                        // Step 2: Use availability checks
                        struct ProfileView: View {
                            // iOS 17+
                            @Environment(UserModel.self) var newUser: UserModel?
                            // iOS 16
                            @EnvironmentObject var legacyUser: UserModel

                            var user: UserModel {
                                if #available(iOS 17, *) {
                                    return newUser ?? legacyUser
                                }
                                return legacyUser
                            }
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox(label: EmptyView()) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Key Takeaways")
                            .font(.headline)

                        TakeawayItem(icon: "1.circle.fill", text: "iOS 17+: @Observable + @Environment + .environment()")
                        TakeawayItem(icon: "2.circle.fill", text: "Pre-iOS 17: ObservableObject + @EnvironmentObject + .environmentObject()")
                        TakeawayItem(icon: "3.circle.fill", text: "Type serves as the environment key - no EnvironmentKey needed")
                        TakeawayItem(icon: "4.circle.fill", text: "Use helper extensions to organize dependency injection")
                        TakeawayItem(icon: "5.circle.fill", text: "Environment objects propagate down only, not up or sideways")
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Supporting Models

@Observable final class UserModel {
    var name: String = "John Doe"
    var email: String = "john@example.com"
    var isLoggedIn: Bool = true
    var avatarColor: Color = .blue

    static func mock() -> UserModel {
        let user = UserModel()
        user.name = "Test User"
        user.email = "test@mock.com"
        return user
    }
}

// MARK: - Helper Views

struct UserProfileCard: View {
    @Environment(UserModel.self) var user: UserModel?

    var body: some View {
        VStack(spacing: 12) {
            Text("Nested View (reads from environment)")
                .font(.caption)
                .foregroundColor(.secondary)

            if let user = user {
                HStack(spacing: 12) {
                    Circle()
                        .fill(user.avatarColor)
                        .frame(width: 40, height: 40)
                        .overlay(
                            Text(String(user.name.prefix(1)))
                                .foregroundColor(.white)
                                .bold()
                        )

                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)
                        Text(user.isLoggedIn ? "Logged In" : "Logged Out")
                            .font(.caption)
                            .foregroundColor(user.isLoggedIn ? .green : .red)
                    }
                }
            } else {
                Text("No user in environment")
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.green.opacity(0.1))
        .cornerRadius(8)
    }
}

struct LegacyUserProfileCard: View {
    @EnvironmentObject var user: LegacyUserModel

    var body: some View {
        VStack(spacing: 12) {
            Text("Nested View (reads from environment)")
                .font(.caption)
                .foregroundColor(.secondary)

            HStack(spacing: 12) {
                Circle()
                    .fill(Color.purple)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Text(String(user.name.prefix(1)))
                            .foregroundColor(.white)
                            .bold()
                    )

                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.headline)
                    Text(user.isLoggedIn ? "Logged In" : "Logged Out")
                        .font(.caption)
                        .foregroundColor(user.isLoggedIn ? .green : .red)
                }
            }
        }
        .padding()
        .background(Color.purple.opacity(0.1))
        .cornerRadius(8)
    }
}

struct CartBadgeView: View {
    @Environment(ShoppingCart.self) var cart: ShoppingCart?

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(systemName: "cart.fill")
                .font(.title2)

            if let cart = cart, cart.itemCount > 0 {
                Text("\(cart.itemCount)")
                    .font(.caption2)
                    .bold()
                    .foregroundColor(.white)
                    .padding(4)
                    .background(Color.red)
                    .clipShape(Circle())
                    .offset(x: 8, y: -8)
            }
        }
    }
}

struct ProductCard: View {
    @Environment(ShoppingCart.self) var cart: ShoppingCart?
    let item: CartItem

    var body: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.2))
                .frame(height: 60)
                .overlay(
                    Image(systemName: "shippingbox.fill")
                        .foregroundColor(.gray)
                )

            Text(item.name)
                .font(.caption)
                .lineLimit(1)

            Text("$\(item.price, specifier: "%.2f")")
                .font(.caption2)
                .foregroundColor(.secondary)

            Button(action: { cart?.addItem(item) }) {
                Text("Add")
                    .font(.caption2)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(4)
            }
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.1), radius: 2)
    }
}

struct CartSummaryView: View {
    @Environment(ShoppingCart.self) var cart: ShoppingCart?

    var body: some View {
        if let cart = cart {
            VStack(alignment: .leading, spacing: 8) {
                Text("Cart Summary")
                    .font(.headline)

                ForEach(cart.items) { item in
                    HStack {
                        Text(item.name)
                            .font(.caption)
                        Spacer()
                        Text("x\(item.quantity)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("$\(item.price * Double(item.quantity), specifier: "%.2f")")
                            .font(.caption)
                    }
                }

                Divider()

                HStack {
                    Text("Total")
                        .font(.headline)
                    Spacer()
                    Text("$\(cart.totalPrice, specifier: "%.2f")")
                        .font(.headline)
                        .foregroundColor(.blue)
                }

                Button("Clear Cart") {
                    cart.clear()
                }
                .font(.caption)
                .foregroundColor(.red)
            }
            .padding()
            .background(Color.blue.opacity(0.05))
            .cornerRadius(8)
        }
    }
}

struct SettingsPreviewCard: View {
    @Environment(AppSettings.self) var settings: AppSettings?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Preview Text")
                .font(.system(size: settings?.fontSize ?? 14))

            HStack {
                Circle()
                    .fill(settings?.isDarkMode == true ? Color.black : Color.white)
                    .frame(width: 30, height: 30)
                    .overlay(Circle().stroke(Color.gray))

                Text(settings?.isDarkMode == true ? "Dark Mode" : "Light Mode")
                    .font(.caption)
            }

            HStack {
                Image(systemName: settings?.notificationsEnabled == true ? "bell.fill" : "bell.slash.fill")
                    .foregroundColor(settings?.notificationsEnabled == true ? .blue : .gray)
                Text(settings?.notificationsEnabled == true ? "Notifications On" : "Notifications Off")
                    .font(.caption)
            }
        }
        .padding()
        .background(settings?.isDarkMode == true ? Color.black.opacity(0.8) : Color.white)
        .foregroundColor(settings?.isDarkMode == true ? .white : .primary)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.3))
        )
    }
}

struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 24)

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

struct DifferenceRow: View {
    let aspect: String
    let modern: String
    let legacy: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(aspect)
                .font(.caption)
                .bold()
            HStack {
                VStack(alignment: .leading) {
                    Text("iOS 17+")
                        .font(.system(.caption2))
                        .foregroundColor(.green)
                    Text(modern)
                        .font(.system(.caption2, design: .monospaced))
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                VStack(alignment: .leading) {
                    Text("Pre-iOS 17")
                        .font(.system(.caption2))
                        .foregroundColor(.purple)
                    Text(legacy)
                        .font(.system(.caption2, design: .monospaced))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(8)
        .background(Color.gray.opacity(0.05))
        .cornerRadius(4)
    }
}

struct EnvironmentComparisonRow: View {
    let leftTitle: String
    let leftPoints: [String]
    let rightTitle: String
    let rightPoints: [String]

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(leftTitle)
                    .font(.caption)
                    .bold()
                ForEach(leftPoints, id: \.self) { point in
                    Text("• \(point)")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack(alignment: .leading, spacing: 4) {
                Text(rightTitle)
                    .font(.caption)
                    .bold()
                ForEach(rightPoints, id: \.self) { point in
                    Text("• \(point)")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct BestPracticeRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(iconColor)
                .frame(width: 20)

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

struct PatternItem: View {
    let number: String
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text(number)
                .font(.caption)
                .bold()
                .foregroundColor(.white)
                .frame(width: 20, height: 20)
                .background(Color.blue)
                .clipShape(Circle())

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

struct TakeawayItem: View {
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
        ModernEnvironmentObjectsExample()
            .tabItem { Label("Modern", systemImage: "sparkles") }

        ShoppingCartExample()
            .tabItem { Label("Shopping Cart", systemImage: "cart.fill") }

        AppSettingsExample()
            .tabItem { Label("Settings", systemImage: "gearshape.fill") }

        LegacyEnvironmentObjectsExample()
            .tabItem { Label("Legacy", systemImage: "clock.arrow.circlepath") }

        DependencyInjectionPatternExample()
            .tabItem { Label("DI Helper", systemImage: "syringe.fill") }

        EnvironmentObjectsBestPracticesExample()
            .tabItem { Label("Best Practices", systemImage: "star.fill") }
    }
}
