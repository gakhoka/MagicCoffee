//
//  KeychainManager.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 22.01.25.
//
import Foundation


class KeyChain {
    
    static let shared = KeyChain()
    
    func save(_ data: Data, account: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecValueData: data
        ] as CFDictionary
        
        SecItemDelete(query)
        SecItemAdd(query, nil)
    }
    
    func read(account: String) -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        return result as? Data
    }
}
