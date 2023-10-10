//
//  CustomTabBar.swift
//  neobis_front_auth
//  Created by Askar Soronbekov on 29/9/23

import Foundation
import UIKit
import SnapKit

class CustomTabBar: UITabBar {

    let bigButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.329, green: 0.345, blue: 0.918, alpha: 1)
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.addTarget(self, action: #selector(bigButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 25
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTabBarAppearance()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTabBarAppearance()
    }

    private func setupTabBarAppearance() {
        addSubview(bigButton)
        
        bigButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.centerY.equalToSuperview().offset(-30)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        var tabBarItems = subviews.filter { $0 is UIControl }
        tabBarItems = tabBarItems.sorted { $0.frame.minX < $1.frame.minX }

        let tabBarWidth = bounds.width
        let itemWidth = tabBarWidth / CGFloat(tabBarItems.count)

        for (index, item) in tabBarItems.enumerated() {
            if index != tabBarItems.count / 2 { // Exclude the middle button
                item.frame = CGRect(x: itemWidth * CGFloat(index >= tabBarItems.count + 1 / 2 ? index + 1 : index), y: item.frame.minY, width: itemWidth, height: item.frame.height)
            }

            if let imageView = item.subviews.compactMap({ $0 as? UIImageView }).first {
                imageView.contentMode = .center
                imageView.frame = item.bounds
            }
        }
    }



    @objc private func bigButtonTapped() {
        let vc = ProfileViewController(getUserProtocol: GetUserViewModel())


    }
}

