//
//  GeometryReader.swift
//  ThinkingInSwiftUI
//
//  Created by Ali Abdelkhalek on 07/04/2025.
//

import SwiftUI

struct GeometryReaderExample: View {
    var body: some View {
        GeometryReader {_ in 
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .background(Color.red)
        }
    }
}

#Preview {
    GeometryReaderExample()
}
