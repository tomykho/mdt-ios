//
//  ProgressDialog.swift
//  MDT
//
//  Created by Tomy Kho on 21/7/22.
//

import SwiftUI

public struct ProgressDialog: ViewModifier {
    @Binding var isShowing: Bool
    let cancelOnTapOutside: Bool
    let cancelAction: (() -> Void)?
    
    public init(isShowing: Binding<Bool>,
                cancelOnTapOutside: Bool,
                cancelAction: (() -> Void)?) {
        _isShowing = isShowing
        self.cancelOnTapOutside = cancelOnTapOutside
        self.cancelAction = cancelAction
        if isShowing.wrappedValue {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            if isShowing {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.black.opacity(0.6))
                    ProgressView()
                        .progressViewStyle(.circular)
                        .padding(.all, 20.0)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(.white)
                        )
                }
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    if cancelOnTapOutside {
                        cancelAction?()
                        isShowing = false
                    }
                }
                .navigationBarBackButtonHidden(isShowing)
            }
        }
    }
}
