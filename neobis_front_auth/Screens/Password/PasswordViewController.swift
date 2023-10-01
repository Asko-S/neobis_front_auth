//  PasswordViewController.swift
//  neobis_front_auth
//  Created by Askar Soronbekov

import Foundation
import UIKit
import SnapKit

class PasswordViewController: UIViewController {
    let mainView = PasswordView()
    
    var passwordProtocol: PasswordProtocol!
    var username: String = ""
    var email: String = ""
    
    init(registerProtocol: PasswordProtocol) {
        self.passwordProtocol = registerProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
        let eyeButton = UIBarButtonItem(image: UIImage(named: "eye-switch")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(eyeButtonPressed))
        self.navigationItem.rightBarButtonItem = eyeButton
        
        title = "Регистрация"
        
        mainView.finishButton.addTarget(self, action: #selector(finishButtonPressed), for: .touchUpInside)
        
        passwordProtocol.registerResult = { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.handleSuccessfulLogin(data)
                case .failure(let error):
                    self?.handleLoginFailure(error)
                }
            }
        }
        
        setupView()
    }
    
    func handleSuccessfulLogin(_ data: Data) {
        
        print ("success")
        
        let vc = LoginViewController(loginProtocol: LoginViewModel())
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func handleLoginFailure(_ error: Error) {
        
        mainView.passwordError.isHidden = false
        mainView.passwordField.textColor = UIColor(red: 0.954, green: 0.27, blue: 0.27, alpha: 1)
        mainView.passwordConfirmField.textColor = UIColor(red: 0.954, green: 0.27, blue: 0.27, alpha: 1)
        print("Login failed with error: \(error)")
    }
    
    @objc func finishButtonPressed() {
        if mainView.passwordField.text == mainView.passwordConfirmField.text{
            passwordProtocol.register( password: mainView.passwordField.text!, password_repeat: mainView.passwordConfirmField.text!)
        }
    }
    
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func eyeButtonPressed() {
        mainView.passwordField.isSecureTextEntry = !mainView.passwordField.isSecureTextEntry
        mainView.passwordConfirmField.isSecureTextEntry = !mainView.passwordConfirmField.isSecureTextEntry
    }

    func setupView() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
}

