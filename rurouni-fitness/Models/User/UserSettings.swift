//
//  UserSettings.swift
//  rurouni-fitness
//
//  Created by  Антон Штрамвасов on 31.03.2026.
//

import Foundation

struct UserSettings: Codable {
    let email_news_updates: Bool
    let email_personal_statistics: Bool
    let telegram_workout_reminders: Bool
    let telegram_security_alerts: Bool
}
