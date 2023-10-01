//
//  ChangeProductViewController.swift
//  neobis_front_auth
//  Created by Askar Soronbekov

import Foundation
import UIKit
import SnapKit

class ChangeProductViewController: UIViewController{
    
    let containView = ChangeProductView()
    var changeProductProtocol: ChangeProductViewModelProtocol!
    var id: Int = 0
    
    init(changeProductProtocol: ChangeProductViewModelProtocol!) {
        self.changeProductProtocol = changeProductProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containView.addButton.addTarget(self, action: #selector(setPic), for: .touchUpInside)
        let cancelButton = UIBarButtonItem(image: UIImage(named: "cancel")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(cancelPressed))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        let finishButton = UIBarButtonItem(image: UIImage(named: "finish")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(finishPressed))
        self.navigationItem.rightBarButtonItem = finishButton
        
        setupView()
    }
    
    @objc func cancelPressed() {
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func finishPressed() {
        guard !containView.images.isEmpty else { return }
        guard let title =  containView.nameField.text else { return }
        guard let price = containView.priceField.text else { return }
        guard let shortDescription = containView.descriptionOne.text else { return }
        guard let longDescription = containView.descriptionTwo.text else { return }
        
        changeProductProtocol.changeProduct(images: containView.images, title: title, price: price, shortDescription: shortDescription, fullDescription: longDescription)
        navigationController?.popViewController(animated: true)
    }
    
    func setupView() {
        
        view.addSubview(containView)
        
        containView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func setPic() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
}

extension ChangeProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            
            containView.addImage(image)
        }
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

