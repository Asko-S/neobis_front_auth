//
//  NumberView.swift
//  neobis_front_auth
//
//  Created by Askar Soronbekov on 30/9/23.

import Foundation
import UIKit
import SnapKit

class NumberView: UIView, UITextFieldDelegate {
    
    let phoneView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.329, green: 0.345, blue: 0.918, alpha: 1)
        view.layer.cornerRadius = 20 * UIScreen.main.bounds.height / 812
        
        view.layer.shadowColor = UIColor(red: 0.329, green: 0.345, blue: 0.918, alpha: 1).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 4
        
        return view
    }()

    
    let phoneImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "call")
        
        return image
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите номер телефона"
        label.font = UIFont(name: "GothamPro-Medium", size: 20)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Мы отправим вам СМС с кодом подтверждения"
        label.font = UIFont(name: "GothamPro", size: 16)
        label.textColor = UIColor(red: 0.754, green: 0.754, blue: 0.754, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    let numberField: UITextField = {
        let field = UITextField()
        field.font = UIFont(name: "GothamPro-Bold", size: 28)
        field.placeholder = "0(000) 000 000"
        field.textAlignment = .center
        field.keyboardType = .numberPad
        return field
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Данный номер уже зарегистрирован"
        label.textColor = UIColor(red: 0.954, green: 0.27, blue: 0.27, alpha: 1)
        label.font = UIFont(name: "SFProText-Medium", size: 17)
        label.isHidden = true
        label.numberOfLines = 1
        
        return label
    }()
    
    @objc let enterButton: UIButton = {
        let button = UIButton()
//        button.backgroundColor = UIColor(red: 0.329, green: 0.345, blue: 0.918, alpha: 1)
        button.backgroundColor = UIColor(red: 0.754, green: 0.754, blue: 0.754, alpha: 1)
        button.layer.cornerRadius = 23 * UIScreen.main.bounds.height / 812
        button.setTitle("Далее", for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        numberField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = .white
        
        numberField.addTarget(self, action: #selector(numberFieldDidChange(_:)), for: .editingChanged)
        setupViews()
        setupConstraints()
    }
    
    @objc private func numberFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.count == 14 {
            enterButton.backgroundColor = UIColor(red: 0.329, green: 0.345, blue: 0.918, alpha: 1)
        } else {
            enterButton.backgroundColor = UIColor(red: 0.754, green: 0.754, blue: 0.754, alpha: 1)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = format(with: "X(XXX) XXX XXX", phone: newString)
        return false
    }
    
    func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex

        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])

                index = numbers.index(after: index)

            } else {
                result.append(ch)
            }
        }
        return result
    }
            
    func setupViews() {
        addSubview(phoneView)
        addSubview(phoneImage)
        addSubview(mainLabel)
        addSubview(descriptionLabel)
        addSubview(numberField)
        addSubview(enterButton)
        addSubview(errorLabel)
    }
    
    func setupConstraints() {
        phoneView.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(120 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(612 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(147.5 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(147.5 * UIScreen.main.bounds.width / 375)
        }
        
        phoneImage.snp.makeConstraints{ make in
            make.center.equalTo(phoneView.snp.center)
            make.height.equalTo(36 * UIScreen.main.bounds.height / 812)
            make.width.equalTo(36 * UIScreen.main.bounds.width / 375)
        }
        
        mainLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(232 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(561 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
        }
        
        descriptionLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(263 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(511 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
        }
        
        numberField.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(334 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(444 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(62 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(62 * UIScreen.main.bounds.width / 375)
        }
        
        enterButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(497 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(271 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
        }
        
        errorLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(384 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(34 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(34 * UIScreen.main.bounds.width / 375)
            make.bottom.equalToSuperview().inset(406 * UIScreen.main.bounds.height / 812)
        }
    }
}

