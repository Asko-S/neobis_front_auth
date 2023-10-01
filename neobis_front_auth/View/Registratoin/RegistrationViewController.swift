//  RegistrationViewController.swift
//  neobis_front_auth
//  Created by Askar Soronbekov

import UIKit
import SnapKit

class RegistrationViewController: UIViewController {
    
    let contentView = RegistrationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
        title = "Регистрация"
        
        setupView()
        contentView.enterButton.addTarget(self, action: #selector(enterButtonPressed), for: .touchUpInside)
    }
    
    @objc func enterButtonPressed() {
        
        if contentView.enterButton.backgroundColor != UIColor(red: 0.754, green: 0.754, blue: 0.754, alpha: 1) {
            guard let userName = contentView.nameField.text else { return }
            guard let email = contentView.mailField.text else { return }
            let vc = PasswordViewController(registerProtocol: PasswordViewModel(userName: userName, email: email))
            
            vc.username = contentView.nameField.text ?? ""
            vc.email = contentView.mailField.text ?? ""
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }

    func setupView() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
}

