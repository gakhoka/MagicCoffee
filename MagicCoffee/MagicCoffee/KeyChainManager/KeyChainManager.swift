//
//  KeyChainManager.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 22.01.25.
//

import Foundation


class KeychainManager {
    
    private let usernameKey = "Username"
    private let passwordKey = "Password"
    
    var email: String?
    var password: String?
    
    var isLoggedIn: Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    
    func saveCredentials(email: String, password: String) {
        KeyChain.shared.save(Data(email.utf8), account: usernameKey)
        KeyChain.shared.save(Data(password.utf8), account: passwordKey)
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
    }
    
    func loadCredentials() {
        
        guard isLoggedIn else { return }
        
        if let usernameData = KeyChain.shared.read(account: usernameKey),
           let passwordData = KeyChain.shared.read(account: passwordKey) {
            email = String(data: usernameData, encoding: .utf8)
            password = String(data: passwordData, encoding: .utf8)
        }
    }
    
    func handleLogin(email: String, password: String){
        saveCredentials(email: email, password: password)
    }

}
