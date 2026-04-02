//
//  LoginViewModel.swift
//  rurouni-fitness
//
//  Created by  Антон Штрамвасов on 01.04.2026.
//

import SwiftUI
import Combine


@MainActor
class LoginViewModel: ObservableObject {
    @Published var login:           String = ""
    @Published var password:        String = ""
    @Published var isLoading:       Bool = false
    @Published var errorMessage:    String?
    @Published var isLoggedIn:      Bool = false
    @Published var currentUser:     User?
    
    private let authService: AuthService
    private let authStorage = AuthStorage.shared
    
    // Валидации
    var isFormValid: Bool {
        !login.isEmpty && !password.isEmpty
    }
    
    init(authService: AuthService = AuthService()) {
        self.authService = authService
    }
    
    func submitLogin(){
        guard isFormValid else { return }
        
        Task {
            await performLogin()
        }
    }
    
    
    func checkExistingSession() {
        if authStorage.isAuthenticated(),
           let savedUser = authStorage.getUser() {
            currentUser = savedUser
            isLoggedIn = true
            print("✅ Session restored for user: \(savedUser.display_name ?? savedUser.username)")
        } else {
            print("❌ No saved session found")
        }
    }
    
    
    
    
    
    private func performLogin() async {
            isLoading = true
            errorMessage = nil
            
            do {
                // Вызываем асинхронный метод сервиса
                let response = try await authService.login(username: login, password: password)

                
                // Сохраняем токен (если нужно)
                saveAuthData(response)
                
                // Переключаем состояние
                if (response.isAuth) {
                    currentUser = response.user
                    isLoggedIn = true
                }
                isLoading = false
                
            } catch let error as NetworkError {
                // Обработка специфичных ошибок API
                isLoading = false
                
                switch error {
                case .unauthorized:
                    errorMessage = "Неверный логин или пароль"
                case .serverError(let statusCode, let message):
                    errorMessage = message ?? "Ошибка сервера: \(statusCode)"
                default:
                    errorMessage = error.localizedDescription
                }
                
            } catch {
                // Любые другие ошибки
                isLoading = false
                errorMessage = "Произошла ошибка: \(error.localizedDescription)"
            }
        }
        
        private func saveAuthData(_ response: AuthResponse) {
            authStorage.saveAuthResponse(response)
        }
    
    
    
}
