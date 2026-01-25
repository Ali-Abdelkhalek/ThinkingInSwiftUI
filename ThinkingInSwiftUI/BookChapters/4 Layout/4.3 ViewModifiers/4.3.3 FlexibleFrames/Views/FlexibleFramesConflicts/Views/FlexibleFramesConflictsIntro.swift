import SwiftUI

struct FlexibleFramesConflictsIntro: View {
        var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Key Principle:")
                .font(.headline)

            Text("SwiftUI's layout system follows strict rules when frames conflict. Understanding these rules is crucial for predictable layouts.")
                .foregroundColor(.secondary)

            VStack(alignment: .leading, spacing: 8) {
                ruleItem("1", "Frames wrap views - each frame is a PARENT")
                ruleItem("2", "Inner frames receive proposals from outer frames")
                ruleItem("3", "Fixed frames IGNORE proposals")
                ruleItem("4", "Views can report size different from proposed")
                ruleItem("5", "Parents can't force children - only propose")
            }
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview {
    FlexibleFramesConflictsIntro()
}
