//
//  TextField.swift
//  MDT
//
//  Created by Tomy Kho on 20/7/22.
//

import SwiftUI

extension TextField {
    
    func outlined(cornerRadius: CGFloat = 5) -> some View {
        self
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(
                    lineWidth: 2.5
                )
            )
    }
}
