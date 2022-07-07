//
//  String+Extension.swift
//  LoginSignup
//
//  Created by Kiran Poudel on 7/7/22.
//

import Foundation

extension String {
    /// trim whitespace of string
    public var trim: String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    public func validate(withPattern pattern: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        return predicate.evaluate(with: self)
    }
    
}
