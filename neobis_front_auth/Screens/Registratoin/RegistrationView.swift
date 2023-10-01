//  RegistrationView.swift
//  neobis_front_auth
//  Created by Askar Soronbekov

import Foundation
import UIKit
import SnapKit

class RegistrationView: UIView, UITextFieldDelegate{
    
    let cartImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "shopping-cart 1")
        
        return image
    }()
    
    let marketLabel : UILabel = {
        let label = UILabel()
        label.text = "MOBI MARKET"
        label.font = UIFont(name: "Nunito-ExtraBold", size: 18)
        label.textColor = .black
        
        return label
    }()
    
    let nameField: AnimatedTextField = {
        let field = AnimatedTextField()
        field.placeholder = "Имя пользователя"

        let lineView = UIView()
        lineView.backgroundColor = UIColor(red: 0.754, green: 0.754, blue: 0.754, alpha: 1)
        field.addSubview(lineView)

        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.bottom.trailing.equalToSuperview()
        }

        return field
    }()
    
    let mailField: AnimatedTextField = {
        let field = AnimatedTextField()
        field.placeholder = "Почта"

        let lineView = UIView()
        lineView.backgroundColor = UIColor(red: 0.754, green: 0.754, blue: 0.754, alpha: 1)
        field.addSubview(lineView)

        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.bottom.trailing.equalToSuperview()
        }

        return field
    }()
    
    let enterButton: UIButton = {
        let button = UIButton()
//        button.backgroundColor = UIColor(red: 0.329, green: 0.345, blue: 0.918, alpha: 1)
        button.backgroundColor = UIColor(red: 0.754, green: 0.754, blue: 0.754, alpha: 1)
        button.layer.cornerRadius = 23 * UIScreen.main.bounds.height / 812
        button.setTitle("Войти", for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        
        return button
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
        
        nameField.delegate = self
        mailField.delegate = self
    }
    
    func setupViews() {
        addSubview(cartImage)
        addSubview(marketLabel)
        addSubview(nameField)
        addSubview(mailField)
        addSubview(enterButton)
    }
    
    func setupConstraints() {
        cartImage.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(112 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(620 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(133 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(162 * UIScreen.main.bounds.width / 375)
        }
        
        marketLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(200 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(587 * UIScreen.main.bounds.height / 812)
            make.centerX.equalToSuperview()
        }
        
        nameField.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(293 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(484 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
        }
        
        mailField.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(379 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(397 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
        }
        
        enterButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(497 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(271 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.endEditing(true)
    }
    
    func textFieldShouldReturn(_ LoginTextField: UITextField) -> Bool {
        LoginTextField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedName = textField == nameField ? (textField.text as NSString?)?.replacingCharacters(in: range, with: string) : nameField.text
        let updatedMail = textField == mailField ? (textField.text as NSString?)?.replacingCharacters(in: range, with: string) : mailField.text
        
        if let name = updatedName, let mail = updatedMail {
            enterButton.isEnabled = name.count >= 3 && mail.contains("@")
            
            if enterButton.isEnabled {
                enterButton.backgroundColor = UIColor(red: 93/255, green: 95/255, blue: 249/255, alpha: 1.0)
            } else {
                enterButton.backgroundColor = UIColor(red: 0.754, green: 0.754, blue: 0.754, alpha: 1)
            }
            
            if mail.contains("@") {
                enterButton.backgroundColor = UIColor(red: 0.329, green: 0.345, blue: 0.918, alpha: 1)
            }
        }
        
        return true
    }
}


