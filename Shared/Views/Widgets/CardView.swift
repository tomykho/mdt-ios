//
//  CardView.swift
//  MDT
//
//  Created by Tomy Kho on 22/7/22.
//

import SwiftUI

struct CardView<Content: View>: View {
    var content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18)
                .fill(.white)
                .shadow(color: .black.opacity(0.2), radius: 6)
            content()
        }
    }
}
