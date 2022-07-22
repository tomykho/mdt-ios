//
//  API.swift
//  MDT
//
//  Created by Tomy Kho on 21/7/22.
//

import TRON
import SwiftUI
import KeychainSwift
import Alamofire

class MDTService : ObservableObject {
    static let shared = MDTService()
    let tron = TRON(baseURL: "https://green-thumb-64168.uc.r.appspot.com")
    let keychain = KeychainSwift(keyPrefix: "mdt")
    var token: String? {
        set {
            if let val = newValue {
                keychain.set(val, forKey: "token")
                isLoggedIn = true
            } else {
                keychain.delete("token")
                isLoggedIn = false
            }
        }
        get {
            return keychain.get("token")
        }
    }
    var username: String? {
        set {
            if let val = newValue {
                keychain.set(val, forKey: "username")
            } else {
                keychain.delete("username")
            }
        }
        get {
            return keychain.get("username")
        }
    }
    @Published var isLoggedIn: Bool = false
    @Published var user: User?
    
    private init() {
        isLoggedIn = token != nil
    }
    
    func request<T: Codable>(_ path: String,
                             _ method: HTTPMethod = .get,
                             _ parameters: Codable? = nil
    ) -> APIRequest<T, APIError> {
        let request: APIRequest<T, APIError> = tron.codable.request(path)
        request.method = method
        if let token = token {
            request.headers["Authorization"] = token
        }
        if let parameters = parameters {
            request.parameterEncoding = JSONEncoding.default
            if let parameters = parameters.asDictionary() {
                request.parameters = parameters
            }
            request.headers["Content-Type"] = "application/json"
        }
        return request;
    }
    
    func register(parameters: AuthRequest) -> APIRequest<AuthResponse, APIError> {
        return self.request("register", .post, parameters)
    }
    
    func login(parameters: AuthRequest) -> APIRequest<AuthResponse, APIError> {
        return self.request("login", .post, parameters)
    }
    
    func logout() {
        username = nil
        token = nil
    }
    
    func refresh() {
        balance().perform { result in
            self.user = result
        } failure: { error in
            if error.response?.statusCode == 401 {
                self.token = nil
            }
        }
        transactions().perform { result in
            print(result)
        } failure: { error in
            guard let data = error.data else { return }
            let theJSONText = String(data: data, encoding: .ascii)
            print("JSON string = \(theJSONText!)")
            if error.response?.statusCode == 401 {
                self.token = nil
            }
        }
    }
    
    func balance() -> APIRequest<User, APIError> {
        return self.request("balance")
    }
    
    func transactions() -> APIRequest<ListResponse<Transaction>, APIError> {
        return self.request("transactions")
    }
    
    func payees() -> APIRequest<ListResponse<User>, APIError> {
        return self.request("payees")
    }
    
    func transfer(parameters: TransferRequest) -> APIRequest<TransferResponse, APIError> {
        return self.request("transfer", .post, parameters)
    }
}
