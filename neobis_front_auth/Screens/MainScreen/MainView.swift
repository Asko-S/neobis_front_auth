//  MainView.swift
//  neobis_front_auth
//  Created by Askar Soronbekov

import Foundation
import UIKit
import SnapKit

class MainView: UIView {
    
    var products: [[String: Any]] = []
    
    let cartImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "shopping-cart 1-2")
        
        return image
    }()
    
    let marketLabel: UILabel = {
        let label = UILabel()
        label.text = "MOBI MARKET"
        label.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        
        return label
    }()
    
    let boxImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Artwork")
        image.isHidden = true
        return image
    }()
    
    let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Ой пусто!"
        label.font = UIFont(name: "GothamPro-Bold", size: 18)
        label.textAlignment = .center
        label.isHidden = true
        
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        
        collectionView.register(ProductCellView.self, forCellWithReuseIdentifier: "ProductCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(boxImage)
        addSubview(emptyLabel)
        addSubview(collectionView)
        addSubview(cartImage)
        addSubview(marketLabel)
    }
    
    func setupConstraints() {
        
        boxImage.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(184 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(96 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(111 * UIScreen.main.bounds.width / 375)
            make.bottom.equalToSuperview().inset(443 * UIScreen.main.bounds.height / 812)
        }
        
        emptyLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(413 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(35 * UIScreen.main.bounds.width / 375)
            make.bottom.equalToSuperview().inset(382 * UIScreen.main.bounds.height / 812)
        }
        
        collectionView.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(112 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
            make.bottom.equalToSuperview()
        }
        
        cartImage.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(52 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(311 * UIScreen.main.bounds.width / 375)
            make.bottom.equalToSuperview().inset(716 * UIScreen.main.bounds.height / 812)
        }
        
        marketLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(69 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(72 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(159 * UIScreen.main.bounds.width / 375)
            make.bottom.equalToSuperview().inset(729 * UIScreen.main.bounds.height / 812)
        }
    }
    
    func updateView(with products: [[String: Any]]) {
        self.products = products
        if products.isEmpty {
            emptyLabel.isHidden = false
            collectionView.isHidden = true
        } else {
            emptyLabel.isHidden = true
            collectionView.isHidden = false
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension MainView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCellView
        
        let product = products[indexPath.item]
        
        if let title = product["title"] as? String {
            cell.productNameLabel.text = title
        }
        
        if let price = product["price"] as? String {
            cell.priceLabel.text = price
        }
        
        if let images = product["images"] as? [String], let imageURLString = images.first, let imageURL = URL(string: imageURLString) {
            URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.productImageView.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        cell.productImageView.image = UIImage(named: "defaultImage")
                    }
                }
            }.resume()
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = 161 * UIScreen.main.bounds.width / 375
        let cellHeight = 184 * UIScreen.main.bounds.height / 812
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
