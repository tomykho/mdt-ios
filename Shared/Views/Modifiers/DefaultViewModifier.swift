//
//  DefaultViewModifier.swift
//  MDT
//
//  Created by Tomy Kho on 20/7/22.
//

import SwiftUI

struct DefaultViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyle(.borderedProminent)
            .tint(.black)
            .textFieldStyle(.outlined)
            .background(.gray.opacity(0.1))
            
    }
}
