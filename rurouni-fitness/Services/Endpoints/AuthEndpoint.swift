//
//  AuthEndpoint.swift
//  rurouni-fitness
//
//  Created by  Антон Штрамвасов on 31.03.2026.
//

import Foundation

enum AuthEndpoint {
    case login(username: String, password: String)
    case status
}

extension AuthEndpoint: APIEndpoint {
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .status:
            return "/api/auth/status"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .status:
            return .get
        }
    }
    
    var body: Encodable? {
        switch self {
        case .login(let username, let password):
            return LoginRequest(username: username, password: password)
        default:
            return nil
        }
    }
}
