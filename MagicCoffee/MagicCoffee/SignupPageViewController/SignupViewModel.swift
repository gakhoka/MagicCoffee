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
            
            
            guard let user = result?.user else {
                completion(.failure(AuthError.userNotCreated))
                return
            }
            
            let coffeeUser = User(username: username, email: user.email ?? "")
  
            completion(.success(coffeeUser))
   
        }
    }
    
     func getFirebaseErrorMessage(_ error: Error) -> String {
        let nsError = error as NSError
        switch nsError.code {
        case AuthErrorCode.emailAlreadyInUse.rawValue:
            return "Email is already in use"
        case AuthErrorCode.invalidEmail.rawValue:
            return "Invalid email address"
        case AuthErrorCode.weakPassword.rawValue:
            return "Password is too weak"
        default:
            return "An error occurred"
        }
    }
}
    
enum AuthError: Error {
    case emptyFields
    case passwordsDontMatch
    case userNotCreated
    
    var message: String {
        switch self {
        case .emptyFields:
            return "Please fill in all fields"
        case .passwordsDontMatch:
            return "Passwords don't match"
        case .userNotCreated:
            return "Error during sign up"
        }
    }
}

