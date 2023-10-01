//
//  ProductCellView.swift
//  neobis_front_auth
//
//  Created by Askar Soronbekov on 1/10/23.
//

import UIKit
import SnapKit

class ProductCellView: UICollectionViewCell {
    
    let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let productNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GothamPro-Medium", size: 14)
        label.textColor = .black
        label.text = "BMW M4 Coupe: A Two-Door"
        label.numberOfLines = 0
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GothamPro-Medium", size: 14)
        label.textColor = UIColor(red: 0.365, green: 0.373, blue: 0.937, alpha: 1)
        label.text = "12000"
        return label
    }()
    
    let likeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "heart")
        
        return image
    }()
    
    let likeLabel: UILabel = {
        let label = UILabel()
        label.text = "100"
        label.font = UIFont(name: "GothamPro", size: 12)
        label.textColor = .gray
        
        return label
    }()
    
    let infoButton: UIButton  = { // show pop up
        let button = UIButton()
        button.setImage(UIImage(named: "info"), for: .normal)
        
//        button.addTarget(self, action: #selector(<#T##@objc method#>), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 12 * UIScreen.main.bounds.height / 812
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(productImageView)
        addSubview(productNameLabel)
        addSubview(priceLabel)
        addSubview(likeImage)
        addSubview(likeLabel)
        addSubview(infoButton)
    }
    
    func setupConstraints() {
        productImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(6 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(6 * UIScreen.main.bounds.width / 375)
            make.bottom.equalToSuperview().inset(93 * UIScreen.main.bounds.height / 812)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(95 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(6 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(6 * UIScreen.main.bounds.width / 375)
            make.bottom.equalToSuperview().inset(55 * UIScreen.main.bounds.height / 812)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(133 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(6 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(13 * UIScreen.main.bounds.width / 375)
            make.bottom.equalToSuperview().inset(34 * UIScreen.main.bounds.height / 812)
        }
        
        likeImage.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(157.41 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(8 * UIScreen.main.bounds.width / 375)
//            make.trailing.equalToSuperview().inset(133 * UIScreen.main.bounds.width / 375)
//            make.bottom.equalToSuperview().inset(9.41 * UIScreen.main.bounds.height / 812)
            make.width.equalTo(20 * UIScreen.main.bounds.width / 375)
            make.height.equalTo(20 * UIScreen.main.bounds.height / 812)
        }
        
        likeLabel.snp.makeConstraints{ make in
            make.centerY.equalTo(likeImage)
            make.leading.equalTo(likeImage.snp.trailing).offset(7 * UIScreen.main.bounds.width / 375)
        }
        
        infoButton.snp.makeConstraints{ make in
            make.centerY.equalTo(likeImage)
            make.trailing.equalToSuperview().inset(6 * UIScreen.main.bounds.width / 375)
        }
    }
}

