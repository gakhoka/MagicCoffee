//
//  LoginViewModel.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 16.01.25.
//

import Foundation
import FirebaseAuth

class LoginViewModel {
    
    func signin(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        guard !email.isEmpty, !password.isEmpty else {
            completion(.failure(AuthError.emptyFields))
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard self != nil else { return }
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let firebaseUser = result?.user else {
                completion(.failure(AuthError.loginError))
                return
            }
            
            guard let userId = result?.user.uid else { return }
            
            let loggedInUser = User(
                id: userId, username: firebaseUser.displayName ?? "Unknown",
                email: firebaseUser.email ?? ""
            )
            
            completion(.success(loggedInUser))
        }
    }
    
    
    func getFirebaseErrorMessage(_ error: Error) -> String {
        let nsError = error as NSError
        switch nsError.code {
        case AuthErrorCode.wrongPassword.rawValue:
            return "Wrong password"
        case AuthErrorCode.invalidEmail.rawValue:
            return "Invalid email address"
        default:
            return "An error occurred"
        }
    }
}



