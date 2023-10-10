//
//  StringExtensions.swift
//  neobis_front_auth
//
//  Created by Askar Soronbekov 

import Foundation

extension String {
    func countOccurences(of searchString: String, in range: NSRange) -> Int {
        let substring = (self as NSString).substring(with: range)
        return substring.components(separatedBy: searchString).count - 1
    }
}

