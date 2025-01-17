//
//  SignupViewModel.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 16.01.25.
//

import FirebaseAuth
import UIKit
import Foundation
import FirebaseFirestore

class SignupViewModel {
    
    func signUp(email: String, password: String, username: String, confirmPassword: String,
                completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard !email.isEmpty, !password.isEmpty, !username.isEmpty, !confirmPassword.isEmpty else {
            completion(.failure(AuthError.emptyFields))
            return
        }
        
        guard password == confirmPassword else {
            completion(.failure(AuthError.passwordsDontMatch))
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let userId = authResult?.user.uid else {
                return
            }
            
            let newUser = User(id: userId, username: username, email: email)
            
            self.saveUser(user: newUser) { success in
                if success {
                    completion(.success(()))
                } else {
                    completion(.failure(AuthError.userNotCreated))
                }
            }
        }
    }
    
    private func saveUser(user: User, completion: @escaping (Bool) -> Void) {
        let database = Firestore.firestore()
        let userData: [String: Any] = [
            "id": user.id,
            "username": user.username,
            "email": user.email,
            "points": user.points ?? 0,
            "orders": []
        ]
        
        database.collection("users").document(user.id).setData(userData) { error in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            } else {
                completion(true)
            }
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
    case loginError
    
    var message: String {
        switch self {
        case .emptyFields:
            return "Please fill in all fields"
        case .passwordsDontMatch:
            return "Passwords don't match"
        case .userNotCreated:
            return "Error during sign up"
        case .loginError:
            return "Error during log in"
        }
    }
}

