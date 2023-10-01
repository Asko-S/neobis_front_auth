//  SplashScreenView.swift
//  neobis_front_auth
//  Created by Askar Soronbekov

import Foundation
import UIKit
import SnapKit

class SplashViewController: UIViewController{
    
    let cartImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "shopping-cart 1-2")
        
        return image
    }()
    
    let marketLabel: UILabel = {
        let label = UILabel()
        label.text = "MOBI MARKET"
        label.font = UIFont(name: "Nunito-ExtraBold", size: 32)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews(){
        view.backgroundColor = .white
        
        view.addSubview(cartImage)
        view.addSubview(marketLabel)
    }
    
    func setupConstraints() {
        cartImage.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(219 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(383 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(72 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(103 * UIScreen.main.bounds.width / 375)
        }
        
        marketLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(433 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(335 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(72 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(72 * UIScreen.main.bounds.width / 375)
        }
    }
}

