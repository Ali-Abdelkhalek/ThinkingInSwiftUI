//
//  ScrollView.swift
//  ThinkingInSwiftUI
//
//  Created by Ali Abdelkhalek on 07/04/2025.
//
import SwiftUI

// MARK: - Scroll View Layout Behavior
//
// With scroll views, we have to distinguish between the layout behavior of the actual
// scroll view and the layout behavior of the scroll view's contents, which scrolls within
// the visible area of the scroll view.
//
// The scroll view itself accepts the proposed size along the scroll axis, and it becomes
// the size of its content on the other axis. For example, if we place a vertical scroll view
// as the root view, it'll become the height of the entire safe area, and it'll take on the
// width of the scroll content.
//
// Along the scroll axis, a scroll view essentially has unlimited space, and the content
// can grow as large as it wants to within that axis. Therefore, the scroll view proposes
// nil in the scroll axis (or axes), and it proposes the unmodified dimension for the other
// axis.

// MARK: - Basic Example: Image and Text in ScrollView
//
// By default, when we specify multiple views for the contents of the scroll view,
// these subviews are placed inside an implicit VStack, regardless of the scroll direction.
//
// If the scroll view gets proposed a size of 320×480, it'll then propose 320×nil to both
// of its subviews and place them within the scroll container accordingly. The scroll view
// itself will always become the proposed height (480).

struct BasicScrollViewExample: View {
    var body: some View {
        ScrollView {
            Image(systemName: "folder")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("This is a longer text")
        }
        .border(Color.red)
    }
}

// MARK: - Text Wrapping Issue
//
// When we have a scroll view with text, sometimes the text might perform word
// wrapping and become a little less wide than the proposed width. If there are no other
// views in the scroll view that become the proposed width, this might mean that our
// scroll view becomes less wide than proposed.

struct TextWrappingProblem: View {
    var body: some View {
        ScrollView {
            Text("This is a longer text that might wrap and become narrower than the proposed width")
        }
        .border(Color.red)
    }
}

// MARK: - Text Wrapping Fixed
//
// To fix this, we can add a .frame(maxWidth: .infinity) to our text. The same applies
// to views other than Text that don't necessarily accept their proposed width.

struct TextWrappingFixed: View {
    var body: some View {
        ScrollView {
            Text("This is a longer text that might wrap and become narrower than the proposed width")
                .frame(maxWidth: .infinity)
        }
        .border(Color.red)
    }
}

// MARK: - Shape Behavior in ScrollView
//
// When we put a shape into a scroll view, the result might be surprising: the built-in
// shapes in SwiftUI all have an ideal size of 10×10. This is due to the default argument
// of .replacingUnspecifiedDimensions(by:) on ProposedViewSize, which is 10×10.
//
// Since the scroll view proposed nil along the scroll axis, the shape will take on its
// ideal size of 10 points on that axis.

struct ShapeInScrollViewProblem: View {
    var body: some View {
        ScrollView {
            Rectangle()
                .fill(Color.blue)
            Circle()
                .fill(Color.green)
        }
        .border(Color.red)
    }
}

// MARK: - Shape Behavior Fixed
//
// If we want to change this, we can specify an explicit height using .frame(height:)
// or .frame(idealHeight:), or we could use .aspectRatio.

struct ShapeInScrollViewFixed: View {
    var body: some View {
        ScrollView {
            Rectangle()
                .fill(Color.blue)
                .frame(height: 200)

            Circle()
                .fill(Color.green)
                .frame(idealHeight: 150)

            RoundedRectangle(cornerRadius: 20)
                .fill(Color.orange)
                .aspectRatio(2, contentMode: .fit)
        }
        .border(Color.red)
    }
}

// MARK: - Complete Example
//
// This example demonstrates the scroll view's layout behavior with various content types.

struct ComprehensiveScrollViewExample: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Scroll View Layout Demo")
                    .font(.title)
                    .frame(maxWidth: .infinity)

                Image(systemName: "folder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)

                Text("This text has maxWidth: .infinity applied so it takes the full proposed width")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.yellow.opacity(0.3))

                Rectangle()
                    .fill(Color.blue)
                    .frame(height: 150)

                Text("Without maxWidth, this text might become narrower than the scroll view if it wraps")
                    .padding()
                    .background(Color.green.opacity(0.3))

                Circle()
                    .fill(Color.purple)
                    .frame(idealHeight: 120)
            }
            .padding()
        }
        .border(Color.red)
    }
}

// MARK: - Preview

#Preview {
    TabView {
        BasicScrollViewExample()
            .tabItem { Label("Basic", systemImage: "1.circle") }

        TextWrappingProblem()
            .tabItem { Label("Text Problem", systemImage: "2.circle") }

        TextWrappingFixed()
            .tabItem { Label("Text Fixed", systemImage: "3.circle") }

        ShapeInScrollViewProblem()
            .tabItem { Label("Shape Problem", systemImage: "4.circle") }

        ShapeInScrollViewFixed()
            .tabItem { Label("Shape Fixed", systemImage: "5.circle") }

        ComprehensiveScrollViewExample()
            .tabItem { Label("Complete", systemImage: "6.circle") }
    }
}
