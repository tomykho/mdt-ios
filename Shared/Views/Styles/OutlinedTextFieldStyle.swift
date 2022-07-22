//
//  OutlinedTextFieldStyle.swift
//  MDT
//
//  Created by Tomy Kho on 20/7/22.
//

import SwiftUI

struct OutlinedTextFieldStyle : TextFieldStyle {
    
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding(12.0)
            .background(.white)
            .border(.black, width: 2.0)
    }
    
}

extension TextFieldStyle where Self == OutlinedTextFieldStyle {
    static var outlined: OutlinedTextFieldStyle {
        OutlinedTextFieldStyle()
    }
}
