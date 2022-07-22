//
//  Double.swift
//  MDT
//
//  Created by Tomy Kho on 22/7/22.
//

import Foundation

let currencyFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale(identifier: "en_SG")
    formatter.currencySymbol = ""
    return formatter
}()

extension Double {
    var formatCurrency: String {
        return currencyFormatter.string(for: self) ?? ""
    }
}
