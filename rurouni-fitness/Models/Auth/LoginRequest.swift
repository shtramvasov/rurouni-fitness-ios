//
//  LoginRequest.swift
//  rurouni-fitness
//
//  Created by  Антон Штрамвасов on 31.03.2026.
//

import Foundation

struct LoginRequest: Encodable {
    let username: String
    let password: String
}
