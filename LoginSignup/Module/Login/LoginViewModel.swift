//
//  LoginViewModel.swift
//  LoginSignup
//
//  Created by Kiran Poudel on 7/7/22.
//

import Combine

class LoginViewModel: ObservableObject {

    var bag = Set<AnyCancellable>()

    let emailTextModel = TextModel(name: "email", dataType: .email, interactor: TextInteractor(type: .email))
    let passwordTextModel = TextModel(name: "password", isSecure: true, dataType: .password, interactor: TextInteractor(type: .password(.password)))
    @Published var isSuccess = false
    var  error = [Error]()
    
    init() {
        observeValidation()
    }
    
    /// Method to observe the validations of the TextFields
    private func observeValidation() {
        Publishers.CombineLatest(emailTextModel.$error, passwordTextModel.$error).map {
            email, password -> [Error] in
            return [email, password].compactMap { $0 }
        }.eraseToAnyPublisher().sink { [weak self] result in
            self?.error = result
        }.store(in: &bag)
    }
}
