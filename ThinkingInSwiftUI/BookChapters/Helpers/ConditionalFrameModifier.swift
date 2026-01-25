import SwiftUI
struct ConditionalFrameModifier: ViewModifier {
    let width: CGFloat
    let isFixed: Bool
    let color: Color

    func body(content: Content) -> some View {
        if isFixed {
            content
                .frame(width: width)
                .background(color.opacity(0.3))
                .border(color, width: 2)
        } else {
            content
                .frame(maxWidth: .infinity)
                .background(color.opacity(0.3))
                .border(color, width: 2)
        }
    }
}
