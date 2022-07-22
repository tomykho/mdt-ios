//
//  ContentView.swift
//  Shared
//
//  Created by Tomy Kho on 20/7/22.
//

import SwiftUI

struct WelcomeView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                Text("MDT")
                    .font(.system(size: 60, weight: .heavy))
                Spacer()
                NavigationLink(destination: LoginView()) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 6)
                }
                NavigationLink(destination: RegisterView()) {
                    Text("Register")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 6)
                }
                .buttonStyle(.bordered)
            }
            .padding()
        }
        .buttonStyle(.borderedProminent)
        .tint(.black)
        .accentColor(.black)
        .textFieldStyle(.roundedBorder)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
