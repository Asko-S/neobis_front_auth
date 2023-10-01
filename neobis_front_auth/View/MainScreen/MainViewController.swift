//  MainViewController.swift
//  neobis_front_auth
//  Created by Askar Soronbekov

import Foundation
import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    let contentView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    
    func parseProductData(productData: [[String: Any]]) {
        var products: [[String: Any]] = []
        for data in productData {
            if let id = data["id"] as? Int,
               let user = data["user"] as? String,
               let images = data["images"] as? [String],
               let title = data["title"] as? String,
               let price = data["price"] as? String,
               let likes = data["likes"] as? Int,
               let isFan = data["is_fan"] as? Bool {
                let product: [String: Any] = [
                    "id": id,
                    "user": user,
                    "images": images,
                    "title": title,
                    "price": price,
                    "likes": likes,
                    "isFan": isFan
                ]
                products.append(product)
            }
        }
        
        contentView.updateView(with: products)
    }
    
    func setupView() {
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
}

