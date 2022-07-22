//
//  BalanceCard.swift
//  MDT
//
//  Created by Tomy Kho on 21/7/22.
//

import SwiftUI

struct BalanceCard: View {
    @Binding var user: User?
    
    init(user: Binding<User?>) {
        _user = user
    }
    

    var body: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            Text("You have")
                .fontWeight(.bold)
                .font(.subheadline)
            Text("SGD \(user?.balance?.formatCurrency ?? "0")")
                .font(.title2)
                .fontWeight(.bold)
            Text("Account No")
                .padding(.top, 4.0)
                .font(.caption)
                .foregroundColor(Color(.darkGray))
            Text(user?.accountNo ?? "0000-000-0000")
                .fontWeight(.bold)
                .font(.subheadline)
            Text("Username")
                .padding(.top, 4.0)
                .font(.caption)
                .foregroundColor(Color(.darkGray))
            Text(MDTService.shared.username ?? "-")
                .fontWeight(.bold)
                .font(.subheadline)
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width * 0.8, alignment: .leading)
        .background(
            Rectangle()
                .fill(.white)
                .cornerRadius(18.0, corners: [.topRight, .bottomRight])
                .shadow(color: .black.opacity(0.2), radius: 6)
        )
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceCard(user: Binding.constant(nil))
    }
}
