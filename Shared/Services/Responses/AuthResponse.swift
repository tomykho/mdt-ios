//
//  AuthResponse.swift
//  MDT
//
//  Created by Tomy Kho on 21/7/22.
//

import Foundation

struct AuthResponse: Codable {
    let status: String
    let token: String
    let username: String?
    let accountNo: String?
}
