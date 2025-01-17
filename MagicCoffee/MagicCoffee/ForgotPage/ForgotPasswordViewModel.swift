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
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
