//
//  APIService.swift
//  neobis_front_auth
//
//  Created by Askar Soronbekov on 29/9/23.
//

import Foundation
import Alamofire
import AlamofireImage

class APIService {
    let baseURL = "http://207.154.198.7:8000/"
    
    func post(endpoint: String, parameters: [String: Any], completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: baseURL + endpoint) else { return }
        let request = createRequest(forURL: url, withMethod: "POST", parameters: parameters)
        performRequest(with: request, completion: completion)
    }
    
    func put(endpoint: String, parameters: [String: Any], completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: baseURL + endpoint) else { return }
        let request = createRequest(forURL: url, withMethod: "PUT", parameters: parameters)
        performRequest(with: request, completion: completion)
    }
}
