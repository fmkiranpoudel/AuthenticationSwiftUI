//
//  LoginSignupApp.swift
//  LoginSignup
//
//  Created by Kiran Poudel on 7/6/22.
//

import SwiftUI
import Firebase



@main
struct LoginSignupApp: App {
    
    @AppStorage("isLoggedIn", store: .standard) private var isLoggedIn = false
    
    @ObservedObject var sessionManager = SessionManager()
    
    init() {
        FirebaseApp.configure()
        sessionManager.getCurrentAuthUser()
    }
    var body: some Scene {
        WindowGroup {
            
            switch sessionManager.authState {
            case .login:
                LoginView()
                    .environmentObject(sessionManager)
            case .signUp:
                SignupView()
                    .environmentObject(sessionManager)
            case .session(let user):
                HomeView(user: user)
                    .environmentObject(sessionManager)
            }
        }
    }
}


enum AuthState {
    case signUp
    case login
    case session(user: User)
}

final class SessionManager: ObservableObject {
    @Published var authState: AuthState = .login
    
    
    
    func getCurrentAuthUser() {
        if let user = Auth.auth().currentUser {
            authState = .session(user: user)
        } else {
            authState = .login
        }
    }
    
    func showSignUp() {
        authState = .signUp
    }
    
    func showLogin() {
        authState = .login
    }
    
    
}
