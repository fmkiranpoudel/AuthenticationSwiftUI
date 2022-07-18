//
//  SignupViewModel.swift
//  LoginSignup
//
//  Created by Kiran Poudel on 7/7/22.
//

import Combine
import Firebase

class SignupViewModel: BaseViewModel {

    let nameTextModel = TextModel(name: "name", dataType: .none, interactor: TextInteractor(type: .plainText(.name)))

    let emailTextModel = TextModel(name: "email", dataType: .email, interactor: TextInteractor(type: .email))
    
    let passwordTextModel = TextModel(name: "password", isSecure: true, dataType: .password, interactor: TextInteractor(type: .password(.password)))
    
    let confirmPasswordTextModel = TextModel(name: "confirm password", isSecure: true, dataType: .password, interactor: TextInteractor(type: .password(.confirmPassword)))

    
    var  error = [Error]()
    
    override init() {
        super.init()
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
    
    func signupAction(sessionManager: SessionManager) {
        
        if let error = error.first as? AppError {
            self.showAlert(message: error.localizedDescription)
            return
        }
        
                
        isAPICall = true
        
        
        Auth.auth().createUser(withEmail: emailTextModel.value, password: passwordTextModel.value) { [weak self] result, error in
            
            guard let self = self else { return }
            
            if let error = error {
                self.showAlert(message: error.localizedDescription)
                self.isAPICall = false
            } else {
                switch result {
                case .none:
                    self.showAlert(message: error?.localizedDescription ?? "Failed to signup")
                    self.isAPICall = false
                case .some:
                    if let user = Auth.auth().currentUser {
                        let changeRequest = user.createProfileChangeRequest()
                        changeRequest.displayName = self.nameTextModel.value
                        
                        changeRequest.commitChanges { error in
                            if let error = error {
                                debugPrint("Error is \(error.localizedDescription)")
                                self.isAPICall = false
                            } else {
                                sessionManager.authState = .session(user: user)
                                self.isAPICall = false
                            }
                        }
                    } else {
                        self.isAPICall = false
                        debugPrint("Failed")
                    }
                    
                    
                }
            }
        }
    }
}
