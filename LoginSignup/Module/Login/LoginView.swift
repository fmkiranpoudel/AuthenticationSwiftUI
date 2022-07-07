//
//  ContentView.swift
//  LoginSignup
//
//  Created by Kiran Poudel on 7/6/22.
//

import SwiftUI

struct LoginView: View {
    
    @State var shoudlNavigateToSignup = false
    @State var email: String = ""
    @State var password: String = ""
    @ObservedObject var loginViewModel = LoginViewModel()

    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ScrollView(showsIndicators: false) {
                    VStack {
                        NavigationLink(destination: SignupView(), isActive: $shoudlNavigateToSignup) { EmptyView() }
                        
                        Image.login
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300, alignment: .center)
                        Group {
                            /// For login title
                            Text(Constants.login)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 30, weight: .bold))
                            
                            VStack(spacing: 20) {
                                CustomTextField(title: Constants.email, image: "at.circle.fill", email: email, type: .email)
                                    .frame(maxWidth: .infinity)
                                
                                CustomTextField(title: Constants.password, image: "lock.circle.fill", email: email, type: .password)
                                    .frame(maxWidth: .infinity)
                            }.padding(.top, 25)
                        }
                        
                        // Forgot Password Views
                        HStack {
                            Spacer()
                            Button {
                                print("Forgot Password Tapped")
                            } label: {
                                Text(Constants.forgotPassword)
                                    .foregroundColor(.theme)
                                    .font(.system(size: 16, weight: .medium))
                            }
                        }
                        
                        Spacer().frame(height: 20)
                        
                        
                        Group {
                            // Login Button
                            Button {
                                print("Login button Tapped")
                            } label: {
                                Text(Constants.login)
                                    .foregroundColor(.white)
                                    .font(.system(size: 20, weight: . semibold))
                            }.frame(maxWidth: .infinity, minHeight: 40)
                                .background(Color.theme)
                                .cornerRadius(10)
                            
                            // View that has two horizontal lines and OR text between them
                            HStack {
                                VStack {
                                    Divider()
                                }
                                
                                Text(Constants.or)
                                    .padding(.horizontal, 4)
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.secondary)
                                VStack {
                                    Divider()
                                }
                            }.padding(.top, 20)
                            
                            // Login With Apple Button
                            Button {
                                print("Login with apple tapped")
                            } label: {
                                HStack {
                                    Image.appleImage
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.black)
                                        .scaledToFit()
                                    Text(Constants.loginWithApple)
                                        .foregroundColor(.black)
                                        .font(.system(size: 20, weight: . semibold))
                                }
                                
                            }.frame(maxWidth: .infinity, minHeight: 40)
                                .background(Color.light)
                                .cornerRadius(10)
                                .padding(.top, 20)
                            
                            Spacer().frame(minHeight: 40)
                            
                            // Register views
                            HStack {
                                Text(Constants.newToFusemachines)
                                Button {
                                    shoudlNavigateToSignup = true
                                }label: {
                                    Text(Constants.register)
                                        .foregroundColor(.theme)
                                }
                            }
                        }
                        
                    }.frame(minHeight: proxy.size.height)
                }
                .frame(minHeight: proxy.size.height)
                .padding()
                .ignoresSafeArea()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

