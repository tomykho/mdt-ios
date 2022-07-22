//
//  MainView.swift
//  MDT
//
//  Created by Tomy Kho on 20/7/22.
//

import SwiftUI

struct RegisterView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
            TextField("Password", text: $password)
            Spacer()
            Button(action: {}, label: {
                Text("Register")
            })
        }.padding()
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
