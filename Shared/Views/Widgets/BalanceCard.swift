//
//  CardView.swift
//  MDT
//
//  Created by Tomy Kho on 21/7/22.
//

import SwiftUI

struct CardView: View {

    var body: some View {
        VStack {
            Text("Card")
        }
        .padding(20)
        .multilineTextAlignment(.center)
        .background(
            Rectangle()
                .fill(.white)
                .cornerRadius(20.0, corners: [.topRight, .bottomRight])
                .shadow(radius: 10)
        )
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
