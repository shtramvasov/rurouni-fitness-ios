//
//  AuthResponse.swift
//  rurouni-fitness
//
//  Created by  Антон Штрамвасов on 31.03.2026.
//

import Foundation

struct AuthResponse: Codable {
    let user: User
    let isAuth: Bool
}
