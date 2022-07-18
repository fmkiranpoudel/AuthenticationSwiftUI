//
//  HomeView.swift
//  LoginSignup
//
//  Created by Kiran Poudel on 7/7/22.
//

import SwiftUI
import Firebase

struct HomeView: View {

    var user: User
    
    @EnvironmentObject var sessionManager: SessionManager

    
    var body: some View {
        
        VStack {
            Text("Welcome \(user.displayName!) (\(user.email!))")
            Button {
                do {
                    try Auth.auth().signOut()
                    print("Logged out")
                    
                    sessionManager.showLogin()
                } catch {
                    print("Failed to logout")
                }
                
            } label: {
                Text("LOGOUT")
            }.padding(.top, 20)
        }
    }
}
