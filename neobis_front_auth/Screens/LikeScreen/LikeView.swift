//
//  LikeView.swift
//  neobis_front_auth
//
//  Created by Askar Soronbekov on 1/10/23.
//

import Foundation
import UIKit
import SnapKit

class LikedView: UIView {
    
    let boxImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Artwork")
        
        return image
    }()
    
    let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Ой пусто!"
        label.font = UIFont(name: "GothamPro-Bold", size: 18)
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        backgroundColor = .white
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(boxImage)
        addSubview(emptyLabel)
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
    }
}

