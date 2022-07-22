//
//  View.swift
//  MDT
//
//  Created by Tomy Kho on 21/7/22.
//

import SwiftUI

extension View {
    func progressDialog(isShowing: Binding<Bool>,
                        cancelOnTapOutside: Bool = false,
                        cancelAction: (() -> Void)? = nil) -> some View {
        self.modifier(
            ProgressDialog(
                isShowing: isShowing,
                cancelOnTapOutside: cancelOnTapOutside,
                cancelAction: cancelAction
            )
        )
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}
