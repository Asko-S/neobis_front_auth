//  FinishRegistrationView.swift
//  neobis_front_auth
//  Created by Askar Soronbekov

import Foundation
import UIKit
import SnapKit

class FinishRegView: UIView, UITextFieldDelegate {
    
    var nickName: String = ""
    
    let profilePic: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "defaultPic")
        image.layer.cornerRadius = 40 * UIScreen.main.bounds.height / 812
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    let setPicButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выбрать фотографию", for: .normal)
        button.setTitleColor(UIColor(red: 0.329, green: 0.345, blue: 0.918, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Medium", size: 16)
        
        return button
    }()
    
    let firstSectionView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12 * UIScreen.main.bounds.height / 812
        
        return view
    }()
    
    let nameField: BorderedTextField = {
        let field = BorderedTextField()
        field.placeholder = "Имя"
        
        return field
    }()
    
    let lastNameField: BorderedTextField = {
        let field = BorderedTextField()
        field.placeholder = "Фамилия"
        
        return field
    }()
    
    let nickNameField: BorderedTextField = {
        let field = BorderedTextField()
        field.placeholder = "Имя пользователя"
//        field.text =
        
        return field
    }()
    
    let birthdayField: UITextField = {
        let field = UITextField()
        field.placeholder = "Дата рождения"
        field.font = UIFont(name: "GothamPro-Medium", size: 16)
        
        return field
    }()

    let secondSectionView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12 * UIScreen.main.bounds.height / 812
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor(red: 0.969, green: 0.965, blue: 0.976, alpha: 1)
        view.addSubview(lineView)
        
        lineView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(16 * UIScreen.main.bounds.width / 375)
            make.centerY.equalToSuperview()
            make.height.equalTo(1)
        }
        
        return view
    }()
    
    let numberButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить номер", for: .normal)
        button.setTitleColor(UIColor(red: 0.329, green: 0.345, blue: 0.918, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Medium", size: 16)
        
        return button
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        label.text = "0(000) 000 000"
        label.textColor = UIColor(red: 0.754, green: 0.754, blue: 0.754, alpha: 1)
        
        return label
    }()
    
    let emailField: UITextField = {
        let field = UITextField()
        field.font = UIFont(name: "GothamPro-Medium", size: 16)
        
        return field
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = UIColor(red: 0.969, green: 0.965, blue: 0.976, alpha: 1)
        
        nameField.delegate = self
        emailField.delegate = self
        birthdayField.delegate = self
        lastNameField.delegate = self
        nickNameField.delegate = self
        
        setupViews()
        setupConstraints()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.endEditing(true)
    }
    
    func setupViews() {
        addSubview(profilePic)
        addSubview(setPicButton)
        addSubview(firstSectionView)
        addSubview(secondSectionView)
        addSubview(nameField)
        addSubview(lastNameField)
        addSubview(nickNameField)
        addSubview(birthdayField)
        addSubview(numberButton)
        addSubview(numberLabel)
        addSubview(emailField)
    }
    
    func setupConstraints() {
        profilePic.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(112 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(620 * UIScreen.main.bounds.height / 812)
//            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().inset(148 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(148 * UIScreen.main.bounds.width / 375)
        }
        
        setPicButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(204 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(584 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(98 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(98 * UIScreen.main.bounds.width / 375)
        }
        
        firstSectionView.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(252 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(381 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
        }
        
        secondSectionView.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(443 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(280 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
        }
        
        nameField.snp.makeConstraints{ make in
            make.top.equalTo(firstSectionView.snp.top).inset(6 * UIScreen.main.bounds.height / 812)
            make.leading.equalTo(firstSectionView.snp.leading).inset(16 * UIScreen.main.bounds.width / 375)
            make.trailing.equalTo(firstSectionView.snp.trailing).inset(16 * UIScreen.main.bounds.width / 375)
            make.bottom.equalTo(firstSectionView.snp.bottom).inset(141 * UIScreen.main.bounds.height / 812)
        }
        
        lastNameField.snp.makeConstraints{ make in
            make.top.equalTo(firstSectionView.snp.top).inset(51 * UIScreen.main.bounds.height / 812)
            make.leading.equalTo(firstSectionView.snp.leading).inset(16 * UIScreen.main.bounds.width / 375)
            make.trailing.equalTo(firstSectionView.snp.trailing).inset(16 * UIScreen.main.bounds.width / 375)
            make.bottom.equalTo(firstSectionView.snp.bottom).inset(96 * UIScreen.main.bounds.height / 812)
        }
        
        nickNameField.snp.makeConstraints{ make in
            make.top.equalTo(firstSectionView.snp.top).inset(96 * UIScreen.main.bounds.height / 812)
            make.leading.equalTo(firstSectionView.snp.leading).inset(16 * UIScreen.main.bounds.width / 375)
            make.trailing.equalTo(firstSectionView.snp.trailing).inset(16 * UIScreen.main.bounds.width / 375)
            make.bottom.equalTo(firstSectionView.snp.bottom).inset(51 * UIScreen.main.bounds.height / 812)
        }
        
        birthdayField.snp.makeConstraints{ make in
            make.top.equalTo(firstSectionView.snp.top).inset(141 * UIScreen.main.bounds.height / 812)
            make.leading.equalTo(firstSectionView.snp.leading).inset(16 * UIScreen.main.bounds.width / 375)
            make.trailing.equalTo(firstSectionView.snp.trailing).inset(16 * UIScreen.main.bounds.width / 375)
            make.bottom.equalTo(firstSectionView.snp.bottom).inset(6 * UIScreen.main.bounds.height / 812)
        }
        
        numberButton.snp.makeConstraints{ make in
            make.top.equalTo(secondSectionView.snp.top).inset(10 * UIScreen.main.bounds.height / 812)
            make.leading.equalTo(secondSectionView.snp.leading).inset(16 * UIScreen.main.bounds.width / 375)
            make.trailing.equalTo(secondSectionView.snp.trailing).inset(187 * UIScreen.main.bounds.width / 375)
            make.bottom.equalTo(secondSectionView.snp.bottom).inset(55 * UIScreen.main.bounds.height / 812)
        }
        
        numberLabel.snp.makeConstraints{ make in
            make.top.equalTo(secondSectionView.snp.top).inset(10 * UIScreen.main.bounds.height / 812)
            make.leading.equalTo(secondSectionView.snp.leading).inset(184 * UIScreen.main.bounds.width / 375)
            make.trailing.equalTo(secondSectionView.snp.trailing).inset(16 * UIScreen.main.bounds.width / 375)
            make.bottom.equalTo(secondSectionView.snp.bottom).inset(55 * UIScreen.main.bounds.height / 812)
        }
        
        emailField.snp.makeConstraints{ make in
            make.top.equalTo(secondSectionView.snp.top).inset(55 * UIScreen.main.bounds.height / 812)
            make.leading.equalTo(secondSectionView.snp.leading).inset(16 * UIScreen.main.bounds.width / 375)
            make.trailing.equalTo(secondSectionView.snp.trailing).inset(16 * UIScreen.main.bounds.width / 375)
            make.bottom.equalTo(secondSectionView.snp.bottom).inset(10 * UIScreen.main.bounds.height / 812)
        }
    }
}

