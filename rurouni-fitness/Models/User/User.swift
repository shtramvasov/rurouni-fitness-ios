//
//  User.swift
//  rurouni-fitness
//
//  Created by  Антон Штрамвасов on 31.03.2026.
//

import Foundation

struct User: Codable {
    let user_id: Int
    let username: String
    let display_name: String
    let email: String
    let daily_calories: Int?
    let avatar_url: String?
    let created_on_tz: String
    let updated_on_tz: String
    let last_login_on_tz: String
    let gender: String?
    let telegram: String?
    let telegram_id: String?
    let settings: UserSettings
}
