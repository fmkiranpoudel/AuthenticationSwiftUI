//
//  TextField.swift
//  LoginSignup
//
//  Created by Kiran Poudel on 7/6/22.
//

import SwiftUI


enum TextFieldTypes {
    case email
    case password
    case numbers
    case others
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .email: return .emailAddress
        case .password: return .default
        case .numbers: return .numberPad
        case .others: return .default
        }
    }
}


struct CustomTextField: View {
    var title: String
    var image: String
    @State var email: String
    var type: TextFieldTypes = .others
    
    var body: some View {
        
        HStack(spacing: 0) {
            Image(systemName: image)
                .resizable()
                .foregroundColor(.secondary)
                .frame(width: 25, height: 25, alignment: .leading)
                .padding(.leading, 8)
                .padding(.trailing, 3)
            
            if type == .password {
                SecureField(title, text: $email) {
                    UIApplication.shared.endEditing()
                }
                    .modifier(TextFieldModifiers())
            } else {
                TextField(title, text: self.$email) {
                    UIApplication.shared.endEditing()
                }
                    .modifier(TextFieldModifiers())
                    .keyboardType(type.keyboardType)
            }
            
            
        }
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.secondary.opacity(0.8)))
        .frame(maxWidth: .infinity)
    }
}

struct TextFieldModifiers: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: 40)
            .textFieldStyle(PlainTextFieldStyle())
            .padding([.horizontal], 4)
            .cornerRadius(8)
            .textInputAutocapitalization(.never)
    }
}


extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
