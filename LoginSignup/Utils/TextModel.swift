//
//  TextModel.swift
//  LoginSignup
//
//  Created by Kiran Poudel on 7/7/22.
//

import Foundation
import Combine

enum PlainFieldType: Plainable {
    case email
    case password
    case none
    
    var name: String {
        switch self {
        case .email:
            return "email"
        case .password:
            return "password"
        case .none:
            return ""
        }
    }
}

enum FieldDataType: Fieldable {
   case email
   case plainText(PlainFieldType)
   case password(PlainFieldType)
    
    var pattern: String {
           switch self {
           case .email: return "[A-Z0-9a-z._%+-]+@([A-Za-z0-9.-]{2,64})+\\.[A-Za-z]{2,64}"
           case .plainText: return "[\\s\\S]{3,}" //  "\\S{3,}" // include white space
               // "^[^\\s].+[^\\s]$"  warning remove white space
           // alphanumeric with length >= 8
           case .password: return #"^.*(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(^[a-zA-Z0-9_.*\W]+$)"#
       }
    }
}

class TextModel: ObservableObject {
    var bag = Set<AnyCancellable>()
    var name: String
    @Published var value: String = ""
    @Published var error: Error? = nil
    var isSecure: Bool
    let dataType: PlainFieldType
    let interactor: TextFieldInteractable
    init(name: String, isSecure: Bool = false, dataType: PlainFieldType, interactor: TextFieldInteractable = TextInteractor(type: .plainText(.none), optional: false) ) {
        self.name = name
        self.isSecure = isSecure
        self.dataType = dataType
        self.interactor  = interactor
        
        $value.sink { [weak self] value in
            self?.isValid(value: value)
        }.store(in: &bag)
        
    }
    
    func isValid(value: String) {
          guard interactor.isValid(value: value) else {
            error = interactor.error
            return
          }
          error = nil
      }
}
