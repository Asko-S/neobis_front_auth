//  AuthManager.swift
//  neobis_ios_auth
//  Created by Askar Soronbekov

import Foundation

class AuthManager {
    static let shared = AuthManager()
    
    private let accessTokenKey = "AccessToken"
    
    var accessToken: String? {
        get {
            return UserDefaults.standard.string(forKey: accessTokenKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: accessTokenKey)
        }
    }
    
    private init() {}
}
