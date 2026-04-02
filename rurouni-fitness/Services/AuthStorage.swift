//
//  AuthStorage.swift
//  rurouni-fitness
//
//  Created by  Антон Штрамвасов on 01.04.2026.
//

import Foundation

class AuthStorage {
    static let shared = AuthStorage()
    
    private let defaults = UserDefaults.standard
    
    private let isAuthKey = "isAuth"
    private let userKey = "user"
    
    private init() {}
    
    func saveAuthResponse(_ response: AuthResponse) {
        saveToUserDefaults(response)
    }
    
    func getUser() -> User? {
        guard let userData = defaults.data(forKey: userKey) else {
            return nil
        }
        return try? JSONDecoder().decode(User.self, from: userData)
    }
    
    func isAuthenticated() -> Bool {
        return defaults.bool(forKey: isAuthKey)
    }
    
    func clear() {
        defaults.removeObject(forKey: isAuthKey)
        defaults.removeObject(forKey: userKey)
        print("🗑️ Auth data cleared from UserDefaults")
    }
    
    private func saveToUserDefaults(_ response: AuthResponse) {
        // Сохраняем флаг авторизации
        defaults.set(response.isAuth, forKey: isAuthKey)
        
        // Сохраняем пользователя как Data (JSON)
        do {
            let userData = try JSONEncoder().encode(response.user)
            defaults.set(userData, forKey: userKey)
        } catch {
            print("Failed to encode user: \(error)")
        }
    }
}
