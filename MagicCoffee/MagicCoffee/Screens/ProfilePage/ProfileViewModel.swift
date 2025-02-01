//
//  ProfileViewModel.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 23.01.25.
//


import Foundation
import FirebaseFirestore
import FirebaseAuth

class ProfileViewModel {
    
    var username = ""
    var email = ""
    
    init() {
        fetchUserProfile()
    }
    
    var updateHandler: (() -> Void)?
    
    func fetchUserProfile() {
        guard let currentUser = Auth.auth().currentUser else { return }
        
        let userRef = Firestore.firestore().collection("users").document(currentUser.uid)
        
        userRef.getDocument { [weak self] (document, error) in
            if error != nil {
                return
            }
            
            guard let document = document, document.exists,
                  let data = document.data() else {
                return
            }
            
            self?.username = data["username"] as? String ?? ""
            self?.email = data["email"] as? String ?? ""
            
            DispatchQueue.main.async { [weak self] in
                self?.updateHandler?()
            }
        }
    }
    
    func updateProfile(username: String, email: String, completion: @escaping (Bool) -> Void) {
        
        guard let currentUser = Auth.auth().currentUser else { return }
        
        let userRef = Firestore.firestore().collection("users").document(currentUser.uid)
        
        let updateData: [String: Any] = [
            "username": username,
            "email": email
        ]
        
        userRef.updateData(updateData) { [weak self] error in
            if error != nil {
                completion(false)
                return
            }
            
            self?.username = username
            self?.email = email
            
            DispatchQueue.main.async { 
                self?.updateHandler?()
                completion(true)
            }
        }
    }
    
    func updatePassword(newPassword: String) {
        guard let currentUser = Auth.auth().currentUser else { return }
        
        currentUser.updatePassword(to: newPassword) { error in
            if let error = error {
                print((error.localizedDescription))
                return
            }
        }
    }
    
    func signOut(completion: @escaping () -> Void) {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                completion()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
