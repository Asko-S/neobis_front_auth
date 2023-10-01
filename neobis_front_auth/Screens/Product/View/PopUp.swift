//
//  PopUp.swift
//  neobis_front_auth
//  Created by Askar Soronbekov

import Foundation
import UIKit
import SnapKit

class PopUpView: UIView {
    
    let changeButton: UIButton = {
        let button = UIButton()
//        button.backgroundColor = .black
        return button
    }()
    
    let changeLabel: UILabel = {
        let label = UILabel()
        label.text = "Изменить"
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        label.textColor = .black
        
        return label
    }()
    
    let changeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "edit")
        image.backgroundColor = UIColor(red: 0.329, green: 0.345, blue: 0.918, alpha: 1)
        image.layer.cornerRadius = 6 * UIScreen.main.bounds.height / 812
        
        return image
    }()
    
    let trashButton: UIButton = {
        let button = UIButton()

        return button
    }()
    
    let trashLabel: UILabel = {
        let label = UILabel()
        label.text = "Удалить"
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        label.textColor = .black
        
        return label
    }()
    
    let trashImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "trash")
        image.backgroundColor = UIColor(red: 0.329, green: 0.345, blue: 0.918, alpha: 1)
        image.layer.cornerRadius = 6 * UIScreen.main.bounds.height / 812
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = .white
        layer.cornerRadius = 30 * UIScreen.main.bounds.height / 812
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(changeButton)
        addSubview(changeLabel)
        addSubview(changeImage)
        addSubview(trashButton)
        addSubview(trashLabel)
        addSubview(trashImage)
    }
    
    func setupConstraints() {
        changeButton.snp.makeConstraints{ make  in
            make.top.equalToSuperview().inset(36 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(94 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
        }
        
        changeLabel.snp.makeConstraints{ make in
            make.centerY.equalTo(changeButton.snp.centerY)
            make.leading.equalToSuperview().inset(59 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(239 * UIScreen.main.bounds.width / 375)
        }
        
        changeImage.snp.makeConstraints{ make in
            make.centerY.equalTo(changeButton.snp.centerY)
            make.height.equalTo(27 * UIScreen.main.bounds.height / 812)
            make.width.equalTo(27 * UIScreen.main.bounds.width / 375)
            make.leading.equalToSuperview().inset(23 * UIScreen.main.bounds.width / 375)
        }
        
        trashButton.snp.makeConstraints{ make  in
            make.top.equalToSuperview().inset(86 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(44 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
        }
        
        trashLabel.snp.makeConstraints{ make in
            make.centerY.equalTo(trashButton.snp.centerY)
            make.leading.equalToSuperview().inset(59 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(239 * UIScreen.main.bounds.width / 375)
        }
        
        trashImage.snp.makeConstraints{ make in
            make.centerY.equalTo(trashButton.snp.centerY)
            make.height.equalTo(27 * UIScreen.main.bounds.height / 812)
            make.width.equalTo(27 * UIScreen.main.bounds.width / 375)
            make.leading.equalToSuperview().inset(23 * UIScreen.main.bounds.width / 375)
        }
    }
}

