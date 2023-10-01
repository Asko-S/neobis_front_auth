//  Model.swift
//  neobis_front_auth
//  Created by Askar Soronbekov

import Foundation

struct TokenObtainPair: Codable {
    let username: String
    let password: Tokens
    
    // Nested struct to represent tokens
    struct Tokens: Codable {
        let refresh: String
        let access: String
    }
}

struct CodeCheck: Codable {
    let verification_code: String
}

struct CodeSend: Codable {
    let phone_number: String?
}

struct Login: Codable {
    let username: String
    let password: String
    let tokens: String
}

struct ProfileRegistration: Codable {
    let avatar: String
    let username: String
    let email: String
    let first_name: String
    let last_name: String?
    let date_of_birth: String?
}

struct Registration: Codable {
    let username: String
    let email: String
    let password: String
    let password_confirm: String
}

struct TokenRefresh: Codable {
    let refresh: String
    let access: String
}



struct Product: Codable {
    let name: String
    let description: String
    let photo: String?
    let available: Bool
    let price: String
}
