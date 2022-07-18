//
//  LoginViewModel.swift
//  LoginSignup
//
//  Created by Kiran Poudel on 7/7/22.
//

import Combine
import Firebase

class BaseViewModel: ObservableObject {
    
    @Published var isAPICall = false
    @Published var alertMessage = ""
    @Published var showAlert = false
    
    var bag = Set<AnyCancellable>()
    
    func showAlert(message: String) {
        showAlert = true
        alertMessage = message
    }
}

class LoginViewModel: BaseViewModel {
    
    
    var emailTextModel = TextModel(name: "email", dataType: .email, interactor: TextInteractor(type: .email))
    var passwordTextModel = TextModel(name: "password", isSecure: true, dataType: .password, interactor: TextInteractor(type: .password(.password)))
    
    
    var  error = [Error]()
    
    override init() {
        super.init()
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
    
    func login(sessionManager: SessionManager) {
        
        if let error = error.first as? AppError {
            showAlert(message: error.localizedDescription)
            return
        }
        
        isAPICall = true
        
        Auth.auth().signIn(withEmail: emailTextModel.value, password: passwordTextModel.value) { [weak self] result, error in
            guard let self = self else { return }
            self.isAPICall = false
            if let error = error {
                self.showAlert(message: error.localizedDescription)
            } else {
                if let user = Auth.auth().currentUser {
                    sessionManager.authState = .session(user: user)
                }
            }
        }
    }
}
