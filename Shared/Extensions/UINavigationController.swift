//
//  UINavigationController.swift
//  MDT
//
//  Created by Tomy Kho on 20/7/22.
//

import SwiftUI

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationBar.topItem?.backButtonDisplayMode = .minimal
        
    }
}
