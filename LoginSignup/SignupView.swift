//
//  SignupView.swift
//  LoginSignup
//
//  Created by Kiran Poudel on 7/6/22.
//

import SwiftUI

struct SignupView: View {
    
    @State var email: String = ""
    
    @Environment(\.presentationMode) var presentation
    
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack {
                    Image.login
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250, alignment: .center)
                    Group {
                        /// For register title
                        Text(Constants.register)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 30, weight: .bold))
                        
                        VStack(spacing: 20) {
                            
                            CustomTextField(title: Constants.name, image: "person.circle.fill", email: email, type: .email)
                                .frame(maxWidth: .infinity)
                            
                            
                            CustomTextField(title: Constants.email, image: "at.circle.fill", email: email, type: .email)
                                .frame(maxWidth: .infinity)
                            
                            CustomTextField(title: Constants.password, image: "lock.circle.fill", email: email, type: .password)
                                .frame(maxWidth: .infinity)
                            
                            CustomTextField(title: Constants.confirmPassword, image: "lock.circle.fill", email: email, type: .password)
                                .frame(maxWidth: .infinity)
                        }.padding(.top, 10)
                    }
                    
                    Spacer().frame(height: 20)
                    
                    
                    Group {
                        // Register Button
                        Button {
                            print("Register button Tapped")
                        } label: {
                            Text(Constants.register)
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
                        
                        // Register With Apple Button
                        Button {
                            print("Signup with apple tapped")
                        } label: {
                            HStack {
                                Image.appleImage
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.black)
                                    .scaledToFit()
                                Text(Constants.signupWithApple)
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
                            Text(Constants.haveAccount)
                            Button {
                                self.presentation.wrappedValue.dismiss()
                            }label: {
                                Text(Constants.login)
                                    .foregroundColor(.theme)
                            }
                        }
                    }
                    
                }.frame(minHeight: proxy.size.height)
            }
            .frame(minHeight: proxy.size.height)
            .padding(.horizontal)
            .ignoresSafeArea()
        }.navigationBarHidden(true)
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}

