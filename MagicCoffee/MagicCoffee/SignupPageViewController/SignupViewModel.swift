//
//  SignupViewModel.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 16.01.25.
//

import FirebaseAuth
import UIKit
import Foundation

class SignupViewModel {
    func signUp(email: String,password: String,username: String,confirmPassword: String,
                completion: @escaping (Result<User, Error>) -> Void) {
     
        guard !email.isEmpty, !password.isEmpty, !username.isEmpty, !confirmPassword.isEmpty else {
            completion(.failure(AuthError.emptyFields))
            return
        }
 
        guard password == confirmPassword else {
            completion(.failure(AuthError.passwordsDontMatch))
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
        }
    }
}

enum AuthError: Error {
    case emptyFields
    case passwordsDontMatch
    
    var message: String {
        switch self {
        case .emptyFields:
            return "Please fill in all fields"
        case .passwordsDontMatch:
            return "Passwords don't match"
        }
    }
}
