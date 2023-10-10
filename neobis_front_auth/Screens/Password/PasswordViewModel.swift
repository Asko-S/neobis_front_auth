//  PasswordViewModel.swift
//  neobis_front_auth
//  Created by Askar Soronbekov

import Foundation
import UIKit

protocol PasswordProtocol {
    var isRegistered: Bool { get }
    var registerResult: ((Result<Data, Error>) -> Void)? { get set }
    
    func register(password: String, password_repeat: String)
}

class PasswordViewModel: PasswordProtocol {
    
    var isRegistered: Bool = false
    var registerResult: ((Result<Data, Error>) -> Void)?
    
    let apiService: APIService
    
    private let userName: String
    private let email: String
    
    init(userName: String, email: String) {
        self.apiService = APIService()
        self.userName = userName
        self.email = email
    }
    
    func register(password: String, password_repeat: String) {
        let parameters: [String: Any] = ["username": userName, "email": email, "password": password, "password_confirm": password_repeat]
        
        apiService.post(endpoint: "auth/register/", parameters: parameters) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    let dataString = String(data: data, encoding: .utf8)
                    print("Data received: \(dataString ?? "nil")")
                    self?.isRegistered = true
                    self?.registerResult?(.success(data))
                case .failure(let error):
                    let errorMessage = "Failed register number: \(error.localizedDescription)"
                    print(errorMessage)
//                    print("Failed register number")
                    self?.isRegistered = false
                    self?.registerResult?(.failure(error))
                }
            }
        }
    }

}

