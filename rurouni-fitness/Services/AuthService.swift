//
//  AuthService.swift
//  rurouni-fitness
//
//  Created by  Антон Штрамвасов on 31.03.2026.
//

import Foundation

class AuthService {
    private let apiClient = APIClient.shared
    
    func login(username: String, password: String) async throws -> AuthResponse {
        let endpoint = AuthEndpoint.login(username: username, password: password)
        let response: AuthResponse = try await apiClient.request(endpoint)
        return response
    }
    
    func checkAuthStatus() async throws -> AuthResponse {
        let endpoint = AuthEndpoint.status
        let response: AuthResponse = try await apiClient.request(endpoint)
        return response
    }
}
