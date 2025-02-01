//
//  ForgotPasswordViewModel.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 17.01.25.
//

import Foundation
import FirebaseAuth


class ForgotPasswordViewModel {
    func sendPasswordReset(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            guard self != nil else { return }

            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    
    func checkIfEmailExists(_ email: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: UUID().uuidString) { [weak self] result, error in
            guard self != nil else { return }

            if let error = error as NSError? {
                let authError = AuthErrorCode(_bridgedNSError: error)
                
                if authError?.code == .emailAlreadyInUse {
                    completion(.success(true))
                } else {
                    completion(.failure(error))
                }
            } else if result != nil {
                result?.user.delete {  _ in
                    completion(.success(false))
                }
            }
        }
    }
}
