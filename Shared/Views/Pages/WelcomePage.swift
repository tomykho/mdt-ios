//
//  WelcomePage.swift
//  MDT
//
//  Created by Tomy Kho on 20/7/22.
//

import SwiftUI

struct WelcomePage: View {
    
    var body: some View {
        NavigationView {
            VStack {
                Text("MDT")
                    .font(.system(size: 60, weight: .heavy))
                Spacer()
                NavigationLink(destination: LoginPage()) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 6)
                }
                NavigationLink(destination: RegisterPage()) {
                    Text("Register")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 6)
                }
                .buttonStyle(.bordered)
            }
            .padding()
            .modifier(DefaultViewModifier())
        }
        .accentColor(.black)
        .navigationViewStyle(.stack)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage()
    }
}
