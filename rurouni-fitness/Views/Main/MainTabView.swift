//
//  MainTabView.swift
//  rurouni-fitness
//
//  Created by Антон Штрамвасов on 01.04.2026.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Главная", systemImage: "house")
                }
            
            WorkoutsView()
                .tabItem {
                    Label("Тренировки", systemImage: "figure.run")
                }
            
            ProfileView()
                .tabItem {
                    Label("Профиль", systemImage: "person")
                }
        }
    }
}

// Временные заглушки
struct HomeView: View {
    var body: some View {
        Text("Главная")
            .font(.largeTitle)
    }
}

struct WorkoutsView: View {
    var body: some View {
        Text("Тренировки")
            .font(.largeTitle)
    }
}

struct ProfileView: View {
    @EnvironmentObject private var viewModel: LoginViewModel
    
    var body: some View {
        VStack {
            Text("Профиль")
                .font(.largeTitle)
            
            Button("Выйти") {
                logout()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
    
    private func logout() {
        // Очищаем UserDefaults
        UserDefaults.standard.removeObject(forKey: "isAuth")
        UserDefaults.standard.removeObject(forKey: "user")
        UserDefaults.standard.removeObject(forKey: "authToken")
        
        // Сбрасываем состояние
        viewModel.isLoggedIn = false
        viewModel.login = ""
        viewModel.password = ""
    }
}

#Preview {
    MainTabView()
        .environmentObject(LoginViewModel())
}
