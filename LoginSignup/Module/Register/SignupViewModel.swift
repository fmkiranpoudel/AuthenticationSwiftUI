//
//  SignupViewModel.swift
//  LoginSignup
//
//  Created by Kiran Poudel on 7/7/22.
//

import Combine

class SignupViewModel: ObservableObject {

    var bag = Set<AnyCancellable>()

    let nameTextModel = TextModel(name: "name", dataType: .none, interactor: TextInteractor(type: .plainText(.name)))

    let emailTextModel = TextModel(name: "email", dataType: .email, interactor: TextInteractor(type: .email))
    
    
    let passwordTextModel = TextModel(name: "password", isSecure: true, dataType: .password, interactor: TextInteractor(type: .password(.password)))
    
    let confirmPasswordTextModel = TextModel(name: "confirm password", isSecure: true, dataType: .password, interactor: TextInteractor(type: .password(.confirmPassword)))

    
    @Published var isSuccess = false
    var  error = [Error]()
    
    init() {
        observeValidation()
    }
    
    /// Method to observe the validations of the TextFields
    private func observeValidation() {
        Publishers.CombineLatest4(nameTextModel.$error, emailTextModel.$error, passwordTextModel.$error, confirmPasswordTextModel.$error).map {
            name, email, password, confirmPassword -> [Error] in
            return [name, email, password, confirmPassword].compactMap { $0 }
        }.eraseToAnyPublisher().sink { [weak self] result in
            self?.error = result
        }.store(in: &bag)
    }
}
