//
//  TransferRequest.swift
//  MDT
//
//  Created by Tomy Kho on 22/7/22.
//

import Foundation

struct TransferRequest: Codable {
    let receipientAccountNo: String
    let amount: Double
    let description: String?
}
