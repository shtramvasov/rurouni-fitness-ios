//
//  LoginView.swift
//  rurouni-fitness
//
//  Created by  Антон Штрамвасов on 01.04.2026.
//

import SwiftUI


struct LoginView: View {
    @EnvironmentObject private var viewModel: LoginViewModel
    
    @FocusState private var focusedField: Field?

    enum Field {
        case login
        case password
    }
    
    var body: some View {
        VStack(spacing: 16){
            
            Text("Rurouni Fitness")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.black.opacity(0.75))
                
            
            VStack(spacing: 22) {
                VStack(alignment: .leading, spacing: 8) {
                    // Лейбл
                    Text("Имя пользователя")
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                    
                    // Поле ввода
                    TextField("Имя пользователя или почта", text: $viewModel.login)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(focusedField == .login ? Color.blue.opacity(0.4) : Color.gray.opacity(0.2),
                                        lineWidth: focusedField == .login ? 2 : 1)
                        )
                        .focused($focusedField, equals: .login)
                        .textContentType(.username)
                        .autocapitalization(.none)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    // Лейбл
                    Text("Пароль")
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                    
                    // Поле ввода пароля
                    SecureField("*****", text: $viewModel.password)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(focusedField == .password ? Color.blue.opacity(0.4) : Color.gray.opacity(0.2),
                                        lineWidth: focusedField == .password ? 2 : 1)
                        )
                        .focused($focusedField, equals: .password)
                        .textContentType(.password)
                }
                
                // Сообщение об ошибке
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                }
                
                Button(action: {
                    viewModel.submitLogin()
                }) {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("Войти")
                            .frame(maxWidth: .infinity)
                            .bold()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(viewModel.isFormValid ? Color.blue : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
            }
            .padding()
            }
            .padding(.vertical, 28)
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.1), lineWidth: 1)
            )
            .shadow(color: Color.gray.opacity(0.3), radius: 18, x: 0, y: 5)
            .padding(.horizontal, 20)
        
    }
    
}

#Preview {
    NavigationStack {
        LoginView()
            .environmentObject(LoginViewModel())
    }
}
