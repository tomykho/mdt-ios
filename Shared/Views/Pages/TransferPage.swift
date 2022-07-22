//
//  TransferPage.swift
//  MDT
//
//  Created by Tomy Kho on 21/7/22.
//

import SwiftUI
import Combine

struct TransferPage: View {
    @Environment(\.presentationMode) var presentation
    
    @State private var amount: Double = 0
    @State private var description: String = ""
    @State private var errors: [String: String] = [:]
    @State private var showDialog = false
    @State private var alertTitle: String = ""
    @State private var showAlert: Bool = false
    @State private var colorScheme = 0
    @State private var searchText = ""
    @State private var payeeLoading = true
    @State private var payees = [User]()
    @State private var selectedPayee: User? = nil
    private let currencyFormatter = NumberFormatter()
    
    init() {
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "en_SG")
        currencyFormatter.currencySymbol = ""
        currencyFormatter.minimumFractionDigits = 0
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2.0) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 2.0) {
                    Group {
                        Text("Payee").font(.footnote)
                        Menu {
                            ForEach(payees, id: \.self) { payee in
                                Button {
                                    self.selectedPayee = payee
                                } label: {
                                    ZStack {
                                        HStack {
                                            Text(payee.name ?? "-")
                                        }
                                    }
                                }
                            }
                        } label: {
                            ZStack {
                                TextField("", text: Binding.constant(""))
                                    .multilineTextAlignment(.leading)
                                VStack(alignment: .leading) {
                                    Text(selectedPayee?.name ?? "")
                                        .fontWeight(.bold)
                                        .font(.caption)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text(selectedPayee?.accountNo ?? "")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.caption2)
                                        .foregroundColor(.gray)
                                }
                                .padding(.horizontal)
                                if payeeLoading {
                                    ProgressView()
                                }
                            }
                        }
                        .disabled(payeeLoading)
                        .opacity(payeeLoading ? 0.5 : 1)
                        if let err = errors["payee"] {
                            Text(err)
                                .foregroundColor(.red)
                                .font(.footnote)
                        }
                    }
                    .onAppear {
                        let request = MDTService.shared.payees()
                        request.perform { result in
                            self.payees = result.data
                            self.payeeLoading = false
                        } failure: { error in
                            if error.response?.statusCode == 401 {
                                MDTService.shared.token = nil
                            }
                        }
                    }
                    Group {
                        Text("Amount")
                            .font(.footnote)
                            .padding(.top, 10.0)
                        TextField("", text: Binding<String>(
                            get: {
                                if amount == 0 {
                                    return ""
                                }
                                return currencyFormatter.string(from: NSNumber(value: amount)) ?? ""
                            },
                            set: {
                                if let value = currencyFormatter.number(from: $0.replacingOccurrences(of: ",", with: "")) {
                                    self.amount = value.doubleValue
                                }
                            }
                        ))
                            .keyboardType(.decimalPad)
                        if let err = errors["amount"] {
                            Text(err)
                                .foregroundColor(.red)
                                .font(.footnote)
                        }
                    }
                    Group {
                        Text("Description")
                            .font(.footnote)
                            .padding(.top, 10.0)
                        TextEditor(text: $description)
                            .overlay(
                                Rectangle()
                                    .stroke(.black, lineWidth: 2.0)
                            )
                            .frame(height: 120)
                        if let err = errors["description"] {
                            Text(err)
                                .foregroundColor(.red)
                                .font(.footnote)
                        }
                    }
                }
                .padding()
            }
            Divider()
            Button(action: {
                errors.removeAll()
                if selectedPayee == nil {
                    errors["payee"] = "Payee is required"
                }
                if amount == 0 {
                    errors["amount"] = "Amount is required"
                }
                if errors.isEmpty {
                    if let selectedPayee = selectedPayee {
                        let parameters = TransferRequest(
                            receipientAccountNo: selectedPayee.accountNo,
                            amount: amount,
                            description: description
                        )
                        let request = MDTService.shared.transfer(
                            parameters: parameters
                        )
                        showDialog = true
                        request.perform { result in
                            MDTService.shared.refresh()
                            self.presentation.wrappedValue.dismiss()
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
                }
            }, label: {
                Text("Transfer Now")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 6)
            })
            .padding()
        }
        .modifier(DefaultViewModifier())
        .navigationTitle("Transfer")
        .progressDialog(isShowing: $showDialog)
        .alert(alertTitle, isPresented: $showAlert) {
            Button("OK", role: .cancel) {
                showAlert = false
            }
        }
    }
}

struct TransferPage_Previews: PreviewProvider {
    static var previews: some View {
        TransferPage()
    }
}
