//
//  Padding.swift
//  ThinkingInSwiftUI
//
//  Created by Ali Abdelkhalek on 17/02/2025.
//
import SwiftUI

struct PaddingView: View {
    
    var body: some View {
        Color(.darkGray)
            .padding(50)
            .border(Color.black, width: 3)
        
        Color(.darkGray)
            .padding(.bottom, 50)
            .border(Color.black, width: 3)
        
    }
}

#Preview {
    PaddingView()
}
