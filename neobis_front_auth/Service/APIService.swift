//
//  APIService.swift
//  neobis_front_auth
//
//  Created by Askar Soronbekov on 29/9/23.
//

import Foundation
import Alamofire
import AlamofireImage

enum APIServiceError: Error {
    case invalidURL
    case invalidResponse
    case requestFailed(statusCode: Int)
    case emptyResponseData
    case dataParsingError
}

struct APIServiceConstants {
    static let baseURL = "https://www.ishak-backender.org.kg/"
}

class APIService {
    
    func post<T: Codable>(endpoint: String, parameters: [String: Any], completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: APIServiceConstants.baseURL + endpoint) else {
            completion(.failure(APIServiceError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        AF.request(request).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func putWithBearerToken<T: Codable>(endpoint: String, parameters: [String: Any], bearerToken: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: APIServiceConstants.baseURL + endpoint) else {
            completion(.failure(APIServiceError.invalidURL))
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(bearerToken)"
        ]
        
        AF.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in parameters {
                    if let data = (value as? String)?.data(using: .utf8) {
                        multipartFormData.append(data, withName: key)
                    }
                }
                
                if let photoData = parameters["photo"] as? Data {
                    multipartFormData.append(photoData, withName: "photo", fileName: "photo.jpg", mimeType: "image/jpeg")
                }
            },
            to: url,
            method: .put,
            headers: headers
        ).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func postImagesWithBearerToken<T: Codable>(endpoint: String, parameters: [String: Any], imageDatas: [Data], bearerToken: String, completion: @escaping (Result<T, Error>) -> Void) {
        let url = APIServiceConstants.baseURL + endpoint
        let boundary = "Boundary-\(UUID().uuidString)"
        let mimeType = "image/*"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(bearerToken)",
            "Content-Type": "multipart/form-data; boundary=\(boundary)"
        ]
        
        AF.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in parameters {
                    if let stringValue = "\(value)".data(using: .utf8) {
                        multipartFormData.append(stringValue, withName: key)
                    }
                }
                
                for (index, imageData) in imageDatas.enumerated() {
                    let fileName = "image\(index).jpeg"
                    let fieldName = "images"
                    
                    multipartFormData.append(imageData, withName: fieldName, fileName: fileName, mimeType: mimeType)
                }
            },
            to: url,
            method: .post,
            headers: headers
        ).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func putImagesWithBearerToken<T: Codable>(endpoint: String, parameters: [String: Any], imageDatas: [Data], bearerToken: String, completion: @escaping (Result<T, Error>) -> Void) {
        let url = APIServiceConstants.baseURL + endpoint
        let boundary = "Boundary-\(UUID().uuidString)"
        let mimeType = "image/*"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(bearerToken)",
            "Content-Type": "multipart/form-data; boundary=\(boundary)"
        ]
        
        AF.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in parameters {
                    if let stringValue = "\(value)".data(using: .utf8) {
                        multipartFormData.append(stringValue, withName: key)
                    }
                }
                
                for (index, imageData) in imageDatas.enumerated() {
                    let fileName = "image\(index).jpeg"
                    let fieldName = "images"
                    
                    multipartFormData.append(imageData, withName: fieldName, fileName: fileName, mimeType: mimeType)
                }
            },
            to: url,
            method: .put,
            headers: headers
        ).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchProductData<T: Codable>(headers: HTTPHeaders, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request("https://www.ishak-backender.org.kg/products/product/api/", headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getWithBearerToken<T: Codable>(endpoint: String, bearerToken: String, completion: @escaping (Result<T, Error>) -> Void) {
        let url = URL(string: "https://www.ishak-backender.org.kg/" + endpoint)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        
        AF.request(request).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteData<T: Codable>(id: Int, bearerToken: String, completion: @escaping (Result<T, Error>) -> Void) {
        let endpoint = "product/\(id)/"
        let url = APIServiceConstants.baseURL + endpoint
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(bearerToken)"
        ]
        
        AF.request(url, method: .delete, headers: headers)
            .validate(statusCode: 200..<400)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
