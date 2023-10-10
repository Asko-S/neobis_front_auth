//
//  DataExtencions.swift
//  neobis_front_auth
//
//  Created by Askar Soronbekov

import Foundation
extension Data {
    
    mutating public func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
