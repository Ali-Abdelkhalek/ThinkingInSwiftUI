//
//  FixedFrames.swift
//  ThinkingInSwiftUI
//
//  Created by Ali Abdelkhalek on 17/02/2025.
//

import SwiftUI

struct FixedFramesView: View {
    
    var body: some View {
        VStack(alignment: .leading){
            Color(.darkGray)
                .border(Color.black, width: 3)
                .frame(width: 300, height: 300)
            
            Text("Hello World!")
                .background(Color(.darkGray))
                .frame(maxWidth: .greatestFiniteMagnitude)
                .background(Color(.green))
                .frame(width: 200)
                .padding(10)
                .background(Color(.red))
        }
        .frame(width: 300)
        .background(Color.blue)
        
    }
}

#Preview {
    FixedFramesView()
}
