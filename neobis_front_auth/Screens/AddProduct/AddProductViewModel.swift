//
//  AddProductViewModel.swift
//  neobis_front_auth
//
//  Created by Askar Soronbekov on 1/10/23.
//

import Foundation
import UIKit

protocol AddProductViewModelProtocol: AnyObject {
    var isAdded: Bool { get }
    var addResult: ((Result<Data, Error>) -> Void)? { get set }
    
    func addProduct(images: [UIImage], title: String, price: String, shortDescription: String?, fullDescription: String?)
}

class AddProductViewModel: AddProductViewModelProtocol {
    
    var isAdded: Bool = false
    var addResult: ((Result<Data, Error>) -> Void)?
    
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }
    
    func addProduct(images: [UIImage], title: String, price: String, shortDescription: String?, fullDescription: String?) {
        let imageDatas = images.compactMap { $0.jpegData(compressionQuality: 1.0) }
        
        let endpoint = "product/api/"
        
        let parameters: [String: Any] = [
//            "images": images,
            "title": title,
            "price": price,
            "short_description": shortDescription ?? "",
            "full_description": fullDescription ?? ""
        ]
        
        apiService.postImagesWithBearerToken(endpoint: endpoint, parameters: parameters, imageDatas: imageDatas, bearerToken: AuthManager.shared.accessToken ?? "") { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    let dataString = String(data: data, encoding: .utf8)
                    print("Data received: \(dataString ?? "nil")")
                    self?.isAdded = true
                    self?.addResult?(.success(data))
                case .failure(let error):
                    let errorMessage = "Failed to add product: \(error.localizedDescription)"
                    print(errorMessage)
                    self?.isAdded = false
                    self?.addResult?(.failure(error))
                }
            }
        }
    }

}

