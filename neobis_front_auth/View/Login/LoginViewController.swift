//  LoginViewController.swift
//  neobis_front_auth
//  Created by Askar Soronbekov

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    let mainView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        mainView.registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        mainView.enterButton.addTarget(self, action: #selector(enterButtonPressed), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    @objc func enterButtonPressed() {
        
        if mainView.enterButton.backgroundColor != UIColor(red: 0.754, green: 0.754, blue: 0.754, alpha: 1) {
            
            guard let name = mainView.nameField.text, let password = mainView.passwordField.text else {
                print("Email or password is empty.")
                return
            }
        }
    }
    
    func handleLoginFailure(_ error: Error) {
        mainView.statusLabel.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.mainView.statusLabel.isHidden = true
        }
        
        mainView.nameField.textColor = UIColor(red: 0.954, green: 0.27, blue: 0.27, alpha: 1)
        mainView.passwordField.textColor = UIColor(red: 0.954, green: 0.27, blue: 0.27, alpha: 1)
        mainView.nameLine.backgroundColor = UIColor(red: 0.954, green: 0.27, blue: 0.27, alpha: 1)
        mainView.passwordLine.backgroundColor = UIColor(red: 0.954, green: 0.27, blue: 0.27, alpha: 1)
        print("Login failed with error: \(error)")
    }
    
    @objc func registerButtonPressed() {
        let vc = RegistrationViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupView() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
}

