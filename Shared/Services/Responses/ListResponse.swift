//
//  ListResponse.swift
//  MDT
//
//  Created by Tomy Kho on 22/7/22.
//

import Foundation

struct ListResponse<T: Codable>: Codable {
    let status: String
    let data: [T]
}
