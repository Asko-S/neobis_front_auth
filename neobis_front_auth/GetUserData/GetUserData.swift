//  GetUserData.swift
//  neobis_front_auth
//  Created by Askar Soronbekov

import Foundation
import Foundation
import Alamofire

protocol GetUserProtocol {
    func fetchUserData(completion: @escaping (Result<[String: Any], Error>) -> Void)
}

class GetUserViewModel: GetUserProtocol {
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }
    
    func fetchUserData(completion: @escaping (Result<[String: Any], Error>) -> Void) {
        guard let accessToken = AuthManager.shared.accessToken else {
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        AF.request("http://157.230.18.205:8000/auth/profile/", headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let userData = value as? [String: Any] {
                    completion(.success(userData))
                } else {
                    let error = NSError(domain: "UserDataParsingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse user data"])
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

