import SwiftUI
struct DynamicFrameModifier: ViewModifier {
    let minWidth: CGFloat?
    let maxWidth: CGFloat?

    func body(content: Content) -> some View {
        content
            .frame(
                minWidth: minWidth,
                maxWidth: maxWidth
            )
    }
}
