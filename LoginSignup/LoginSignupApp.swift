//
//  LoginSignupApp.swift
//  LoginSignup
//
//  Created by Kiran Poudel on 7/6/22.
//

import SwiftUI


@main
struct LoginSignupApp: App {
        
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}


class User: ObservableObject {
    @Published var name: String
    @Published var address: String
    
    init(name: String, address: String) {
        self.name = name
        self.address = address
    }
}
