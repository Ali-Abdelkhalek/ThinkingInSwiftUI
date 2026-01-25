import SwiftUI

struct FlexibleFramesConflictsResolution: View {
        var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("SwiftUI Resolution Priority:")
                .font(.headline)

            VStack(alignment: .leading, spacing: 8) {
                ruleItem("1", "Fixed sizes (width/height) always win")
                ruleItem("2", "When min > max, min wins")
                ruleItem("3", "Child can overflow parent if needed")
                ruleItem("4", "Outer frames wrap inner frames")
                ruleItem("5", "Flexible frames try to satisfy both parent and child")
                ruleItem("6", "minWidth/maxWidth act as boundaries, not guarantees")
            }
        }
        .padding()
        .background(Color.blue.opacity(0.05))
        .cornerRadius(12)
    }
}

#Preview {
    FlexibleFramesConflictsResolution()
}
