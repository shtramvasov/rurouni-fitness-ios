//
//  AuthEndpoint.swift
//  rurouni-fitness
//
//  Created by  Антон Штрамвасов on 31.03.2026.
//

import Foundation

enum AuthEndpoint {
    case login(username: String, password: String)
}

extension AuthEndpoint: APIEndpoint {
    var path: String {
        switch self {
        case .login:
            return "/api/auth/login"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
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
