//
//  Transaction.swift
//  MDT
//
//  Created by Tomy Kho on 22/7/22.
//

import Foundation

struct Transaction: Codable, Hashable {
    let transactionId: String
    let amount: Double
    let description: String?
    let transactionDate: Date
    let transactionType: TransactionType
    let receipient: User?
    let sender: User?
    
    enum TransactionType: String, Codable {
        case transfer, received
    }
    
    var user: User? {
        get {
            return transactionType == .received ? sender : receipient
        }
    }
}
