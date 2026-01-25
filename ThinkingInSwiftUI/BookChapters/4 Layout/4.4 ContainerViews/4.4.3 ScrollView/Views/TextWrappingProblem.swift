//
//  TextWrappingProblem.swift
//  ThinkingInSwiftUI
//
//  ScrollView - Text Wrapping Issue
//
//  When we have a scroll view with text, sometimes the text might perform word
//  wrapping and become a little less wide than the proposed width. If there are no other
//  views in the scroll view that become the proposed width, this might mean that our
//  scroll view becomes less wide than proposed.
//

import SwiftUI

struct TextWrappingProblem: View {
    var body: some View {
        ScrollView {
            Text("This is a longer text that might wrap and become narrower than the proposed width")
        }
        .border(Color.red)
    }
}

#Preview {
    TextWrappingProblem()
}
