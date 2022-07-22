//
//  HomePage.swift
//  MDT
//
//  Created by Tomy Kho on 21/7/22.
//

import SwiftUI

struct HomePage: View {
    @State private var showLogoutAlert = false
    @StateObject var service = MDTService.shared
    private let dateFormatter = DateFormatter()
    
    init() {
        dateFormatter.dateFormat = "d MMM yyyy"
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 2.0) {
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            Button("Logout") {
                                showLogoutAlert = true
                            }
                            .buttonStyle(.borderless)
                            .alert(isPresented: $showLogoutAlert) {
                                Alert(
                                    title: Text("Confirm Logout"),
                                    message: Text("Are you sure want to continue?"),
                                    primaryButton: .destructive(Text("Logout")) {
                                        service.logout()
                                    },
                                    secondaryButton: .cancel(Text("Cancel"))
                                )
                            }
                        }
                        .padding()
                        BalanceCard(user: $service.user)
                        VStack {
                            Text("Your transaction history")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 6)
                            if let userTransactions = service.userTransactions {
                                ForEach(userTransactions.keys.sorted(by: >), id: \.self) { date in
                                    CardView {
                                        VStack(alignment: .leading) {
                                            Text(dateFormatter.string(from: date))
                                                .font(.subheadline)
                                                .fontWeight(.bold)
                                                .foregroundColor(Color(.darkGray))
                                                .frame(
                                                    maxWidth: .infinity,
                                                    alignment: .leading
                                                )
                                            ForEach(userTransactions[date]!, id: \.self) { transaction in
                                                HStack {
                                                    VStack(alignment: .leading) {
                                                        Text(transaction.user?.accountHolder ?? "")
                                                            .fontWeight(.bold)
                                                        Text(transaction.user?.accountNo ?? "")
                                                            .font(.caption2)
                                                            .foregroundColor(.gray)
                                                    }
                                                    Spacer()
                                                    Text("\(transaction.transactionType == .transfer ? "-" : "") \(transaction.amount.formatCurrency)")
                                                        .fontWeight(.bold)
                                                        .foregroundColor(
                                                            transaction.transactionType == .transfer ?
                                                                .gray : .green
                                                        )
                                                }
                                                .padding(.top, 6)
                                            }
                                        }
                                        .padding()
                                    }
                                }
                            } else {
                                ProgressView()
                            }
                        }
                        .padding()
                    }
                }
                Divider()
                NavigationLink(destination: TransferPage()) {
                    Text("Make Transfer")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 6)
                }
                .padding()
            }
            .modifier(DefaultViewModifier())
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        .accentColor(.black)
        .navigationViewStyle(.stack)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            MDTService.shared.refresh()
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
