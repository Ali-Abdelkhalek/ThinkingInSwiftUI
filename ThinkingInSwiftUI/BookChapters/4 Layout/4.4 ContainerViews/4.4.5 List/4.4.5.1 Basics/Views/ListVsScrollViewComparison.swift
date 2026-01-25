//
//  ListVsScrollViewComparison.swift
//  ThinkingInSwiftUI
//
//  List Basics - List vs ScrollView Layout Comparison
//

import SwiftUI

struct ListVsScrollViewComparison: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("List vs ScrollView")
                .font(.title2)
                .bold()

            HStack(spacing: 20) {
                // List
                VStack {
                    Text("List")
                        .font(.headline)
                    List(0..<5, id: \.self) { i in
                        Text("Item \(i)")
                    }
                    .border(Color.blue, width: 2)
                    Text("Lazy loading")
                        .font(.caption)
                }

                // ScrollView
                VStack {
                    Text("ScrollView")
                        .font(.headline)
                    ScrollView {
                        VStack {
                            ForEach(0..<5, id: \.self) { i in
                                Text("Item \(i)")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                            }
                        }
                    }
                    .border(Color.red, width: 2)
                    Text("Eager loading")
                        .font(.caption)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ListVsScrollViewComparison()
}
