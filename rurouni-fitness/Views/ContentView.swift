//
//  ContentView.swift
//  rurouni-fitness
//
//  Created by Антон Штрамвасов on 31.03.2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var loginViewModel = LoginViewModel()
    
    var body: some View {
        Group {
            if loginViewModel.isLoggedIn {
                MainTabView()
                    .environmentObject(loginViewModel)
            } else {
                NavigationStack {
                    ZStack {
                        RadialGradient(
                            colors: [
                                Color(red: 240/255, green: 247/255, blue: 255/255),
                                Color.white
                            ],
                            center: .top,
                            startRadius: 0,
                            endRadius: 900
                        )
                        .ignoresSafeArea()
                        
                        VStack {
                            Spacer()
                            LoginView()
                                .environmentObject(loginViewModel)
                            Spacer()
                        }
                    }
                }
            }
        }
        .onAppear {
            checkExistingSession()
        }
    }
    
    private func checkExistingSession() {
        if let isAuth = UserDefaults.standard.object(forKey: "isAuth") as? Bool,
           isAuth,
           UserDefaults.standard.object(forKey: "user") != nil {
            loginViewModel.isLoggedIn = true
        }
    }
}

#Preview {
    ContentView()
}
