//
//  MDTApp.swift
//  Shared
//
//  Created by Tomy Kho on 20/7/22.
//

import SwiftUI

@main
struct MDTApp: App {
    @StateObject var service = MDTService.shared
    
    var body: some Scene {
        WindowGroup {
            if service.isLoggedIn {
                HomePage()
            } else {
                WelcomePage()
            }
        }
    }
}
