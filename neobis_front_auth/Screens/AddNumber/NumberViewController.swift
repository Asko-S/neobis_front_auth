//  NumberViewController.swift
//  neobis_front_auth
//  Created by Askar Soronbekov on 30/9/23.

import Foundation
import UIKit
import SnapKit

class NumberViewController: UIViewController{
    
    let mainView = NumberView()
    var numberProtocol: NumberProtocol!
    
    init(numberProtocol: NumberProtocol!) {
        self.numberProtocol = numberProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        mainView.enterButton.addTarget(self, action: #selector(enterPressed), for: .touchUpInside)
        
        let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
        numberProtocol.registerResult = { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.handleSuccessfulRegister(data)
                case .failure(let error):
                    self?.handleLoginFailure(error)
                }
            }
        }
    }
    
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func enterPressed() {
        if let text = mainView.numberField.text {
            var digits = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            
            if let firstDigit = digits.first {
                digits.removeFirst()
            }
            
            digits = "+996" + digits
            
            numberProtocol.fullRegister(phone_number: digits)
        }
    }
    
    func handleSuccessfulRegister(_ data: Data) {

        let vc = CustomTabBarC()
        vc.modalPresentationStyle = .fullScreen
        
        if let viewControllers = vc.viewControllers {
            let lastIndex = viewControllers.count - 1
            vc.selectedIndex = lastIndex
        }
        
        present(vc, animated: true, completion: nil)
    }
    
    func handleLoginFailure(_ error: Error) {
        
        mainView.errorLabel.isHidden = false
        print("Login failed with error: \(error)")
    }
        
    func setupView() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
}

