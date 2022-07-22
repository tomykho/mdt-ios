//
//  TransferResponse.swift
//  MDT
//
//  Created by Tomy Kho on 22/7/22.
//

import Foundation

struct TransferResponse: Codable {
    let status: String
    let transactionId: String
    let recipientAccount: String
    let amount: Double
    let description: String?
}
