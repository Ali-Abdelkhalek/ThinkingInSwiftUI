import SwiftUI

struct ZStackExplained: View {
    var body: some View {
        TabView {
            ZStackBasics()
                .tabItem { Label("Basics", systemImage: "square.stack.3d.up") }
            
            ZStackComparison()
                .tabItem { Label("Comparison", systemImage: "list.bullet.rectangle") }
            
            ZStackPractical()
                .tabItem { Label("Practical", systemImage: "hammer") }
        }
    }
}

#Preview {
    ZStackExplained()
}
