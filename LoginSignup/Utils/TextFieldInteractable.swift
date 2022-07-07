//
//  TextFieldInteractable.swift
//  LoginSignup
//
//  Created by Kiran Poudel on 7/7/22.
//

import Foundation

public protocol Localie {
    var value: String { get }
}

public enum AppError: Error, LocalizedError {
    case requiredField(Localie)
    case custom (String)
    
    
    public var localizedDescription: String {
        switch self {
        case .requiredField(let error): return error.value
        case .custom(let error): return "\(error)"
        }
    }
}

public protocol  Plainable {
    var name: String { get }
}
public protocol Fieldable {
    var   pattern: String { get }
}

public protocol TextFieldInteractable {
    func isValid(value: String?) -> Bool
    var error: AppError? { get set }
    var interactorType: Fieldable { get }
}
