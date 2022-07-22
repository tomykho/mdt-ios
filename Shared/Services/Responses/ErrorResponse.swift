//
//  ErrorResponse.swift
//  MDT
//
//  Created by Tomy Kho on 21/7/22.
//

import Foundation

struct ErrorResponse: Codable {
    let status: String
    let error: String
}
