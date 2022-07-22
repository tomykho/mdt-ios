//
//  Encodable.swift
//  MDT
//
//  Created by Tomy Kho on 21/7/22.
//

import Foundation

extension Encodable {
    func asDictionary() -> [String: Any]? {
        if let data = try? JSONEncoder().encode(self) {
            if let object = try? JSONSerialization.jsonObject(with: data) {
                print(object)
                return object as? [String: Any]
            }
        }
        return nil
    }
}
