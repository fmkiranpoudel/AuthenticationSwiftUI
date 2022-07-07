//
//  TextField.swift
//  LoginSignup
//
//  Created by Kiran Poudel on 7/6/22.
//

import SwiftUI

struct CustomTextField: View {
    @ObservedObject var model: TextModel
    
    var image: String
    
    var body: some View {
        
        HStack(spacing: 0) {
            Image(systemName: image)
                .resizable()
                .foregroundColor(.secondary)
                .frame(width: 25, height: 25, alignment: .leading)
                .padding(.leading, 8)
                .padding(.trailing, 3)
            
            Group {
                if model.isSecure {
                    SecureField(model.name.capitalized, text: $model.value) {
                        UIApplication.shared.endEditing()
                    }
                } else {
                    TextField(model.name.capitalized, text: $model.value) {
                        UIApplication.shared.endEditing()
                    }            }
            }
            .frame(height: 40)
            .textFieldStyle(PlainTextFieldStyle())
            .padding([.horizontal], 4)
            .cornerRadius(8)
            .textInputAutocapitalization(.never)
            .keyboardType(model.dataType.keyboardType)
            
            
        }
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.secondary.opacity(0.8)))
        .frame(maxWidth: .infinity)
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
