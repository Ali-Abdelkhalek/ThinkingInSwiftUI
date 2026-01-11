//
//  TextView.swift
//  ThinkingInSwiftUI
//
//  Created by Ali Abdelkhalek on 09/02/2025.
//
import SwiftUI

struct TextView: View {
    
    var body: some View {
        ScrollView {
            Text("Thinking in SwiftUI")
                .padding()
                .border(Color.black, width: 3)
            Text("SwiftUI is radically different from UIKit. In this short book, we will help you build a mental model of how SwiftUI works. We explain the most important concepts in detail and help you build a solid foundation for understanding SwiftUI.")
                .padding()
                .border(Color.black, width: 3)
            Text("SwiftUI is radically different from UIKit. In this short book, we will help you build a mental model of how SwiftUI works. We explain the most important concepts in detail and help you build a solid foundation for understanding SwiftUI.")
                .padding()
                .border(Color.black, width: 3)
                .lineLimit(3)
            Text("SwiftUI is radically different from UIKit. In this short book, we will help you build a mental model of how SwiftUI works. We explain the most important concepts in detail and help you build a solid foundation for understanding SwiftUI.")
                .padding()
                .border(Color.black, width: 3)
                .background(Color.gray)
                .lineLimit(7, reservesSpace: true)
            Text("SwiftUI is radically different from UIKit. In this short book, we will help you build a mental model of how SwiftUI works. We explain the most important concepts in detail and help you build a solid foundation for understanding SwiftUI.")
                .padding()
                .border(Color.black, width: 3)
                .lineLimit(1)
                .truncationMode(.middle)
            Text("SwiftUI is radically different from UIKit. In this short book, we will help you build a mental model of how SwiftUI works. We explain the most important concepts in detail and help you build a solid foundation for understanding SwiftUI. ")
                .padding()
                .border(Color.black, width: 3)
                .background(Color.cyan)
                .lineLimit(3)
                .minimumScaleFactor(0.4)
            
            Text("SwiftUI is radically different from UIKit. In this short book, we will help you build a mental model of how SwiftUI works. We explain the most important concepts in detail and help you build a solid foundation for understanding SwiftUI.")
                .padding()
                .border(Color.black, width: 3)
                .fixedSize(horizontal: false, vertical: true)
            
        }
    }
}

#Preview {
    TextView()
}
