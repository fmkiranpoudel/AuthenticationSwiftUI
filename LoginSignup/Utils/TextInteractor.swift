//
//  TextInteractor.swift
//  LoginSignup
//
//  Created by Kiran Poudel on 7/7/22.
//

import Foundation

enum LocalValue: Localie {
    case required(String)
    case inValid(String)
    
    var value: String {
        switch self {
        case .required(let string):
            return "Please provide \(string)."
        case .inValid(let string):
            return "Please provide valid \(string)."
        }
    }
}


class TextInteractor: TextFieldInteractable {
    @Published  var error: AppError?
    
    let type: FieldDataType
    let optional: Bool
    //@Published var validationError: AppError! = nil
    
    
    var interactorType: Fieldable {
        return type
    }
    
    init(type: FieldDataType, optional: Bool = false) {
        self.type = type
        self.optional = optional
    }
    
    func isValid(value: String?) -> Bool {
        if optional && (value == nil || value == "" ) { return true }
        
        switch type {
        case .email:
            if !optional && emptyValue(value: value?.trim) {
                error = AppError.requiredField(LocalValue.required(PlainFieldType.email.name))
                return false
            } else if   !value!.trim.validate(withPattern: type.pattern) {
                error = AppError.requiredField(LocalValue.inValid(PlainFieldType.email.name))
                return false
            }
            return true
        case .plainText(let field):
            if !optional && emptyValue(value: value?.trim) {
                error = AppError.requiredField(LocalValue.required(field.name))
                return false
            }
            return true
            
        case .password(let field):
            if !optional && emptyValue(value: value) {
                error = AppError.requiredField(LocalValue.required(field.name))
                return false
            } else if (value?.count ?? 0) < 6 {
                error = AppError.custom("Password should be atleast 6 character")
                return false
            }
            return true
        }
    }
    
    func emptyValue(value: String?) -> Bool {
        guard let value = value else { return true }
        return value.isEmpty
    }
}

