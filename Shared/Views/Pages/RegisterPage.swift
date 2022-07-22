//
//  MainView.swift
//  MDT
//
//  Created by Tomy Kho on 20/7/22.
//

import Foundation
import SwiftUI

struct RegisterPage: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errors: [String: String] = [:]
    @State private var showDialog = false
    @State private var alertTitle: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2.0) {
            Group {
                Text("Username").font(.footnote).textInputAutocapitalization(.never)
                TextField("", text: $username)
                if let err = errors["username"] {
                    Text(err)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
            }
            Group {
                Text("Password")
                    .font(.footnote)
                    .padding(.top, 10.0)
                SecureField("", text: $password)
                if let err = errors["password"] {
                    Text(err)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
            }
            Group {
                Text("Confirm Password")
                    .font(.footnote)
                    .padding(.top, 10.0)
                SecureField("", text: $confirmPassword)
                if let err = errors["confirmPassword"] {
                    Text(err)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
            }
            Spacer()
            Button {
                errors.removeAll()
                if username.trimmingCharacters(in: .whitespaces).isEmpty {
                    errors["username"] = "Username is required"
                }
                if password.trimmingCharacters(in: .whitespaces).isEmpty {
                    errors["password"] = "Password is required"
                }
                if confirmPassword.trimmingCharacters(in: .whitespaces).isEmpty || password != confirmPassword {
                    errors["confirmPassword"] = "Confirm Password does not match"
                }
                if errors.isEmpty {
                    let request = MDTService.shared.register(
                        parameters: AuthRequest(
                            username: username,
                            password: password
                        )
                    )
                    showDialog = true
                    request.perform { result in
                        MDTService.shared.username = username
                        MDTService.shared.token = result.token
                    } failure: { error in
                        guard let data = error.data else { return }
                        do {
                            let res = try JSONDecoder().decode(ErrorResponse.self, from: data)
                            alertTitle = res.error
                            showAlert = true
                            print(res)
                        } catch {
                            print(error)
                        }
                    }.response { _ in
                        showDialog = false
                    }
                }
            } label: {
                Text("Register")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 6)
            }
        }
        .padding()
        .modifier(DefaultViewModifier())
        .navigationTitle("Register")
        .progressDialog(isShowing: $showDialog)
        .alert(alertTitle, isPresented: $showAlert) {
            Button("OK", role: .cancel) {
                showAlert = false
            }
        }
    }
}

struct RegisterPage_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPage()
    }
}
