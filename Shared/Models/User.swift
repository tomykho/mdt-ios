//
//  User.swift
//  MDT
//
//  Created by Tomy Kho on 21/7/22.
//

import Foundation

struct User: Codable, Hashable {
    let id: String?
    let name: String?
    let accountNo: String
    let balance: Double?
    let accountHolder: String?
}
