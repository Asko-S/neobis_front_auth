//
//  ProductViewController.swift
//  neobis_front_auth
//
//  Created by Askar Soronbekov on 1/10/23.
//

import Foundation
import UIKit
import SnapKit

class ProductViewController: UIViewController{
    
    let containView = ProductView()
    let animationDuration = 0.3
    let popupAnimationDuration = 0.5

    var ProductViewModelType: ProductProtocol!
    var getUserProtocol: GetUserProtocol!
    var user: String = ""
    var products: [[String: Any]] = []
    var blurEffectView: UIVisualEffectView?
    var sendId: Int = 0

    
    let popUp: PopUpView = {
        let view = PopUpView()
        view.isHidden = true
        
        return view
    }()
    
    init(Product: ProductProtocol!, productProtocol: GetUserProtocol!) {
        self.ProductViewModelType = Product
        self.getUserProtocol = productProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мои товары"
        
        let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
        containView.collectionView.dataSource = self
        containView.collectionView.delegate = self
        containView.collectionView.register(ProductCellView.self, forCellWithReuseIdentifier: "ProductCell")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        popUp.changeButton.addTarget(self, action: #selector(changePressed), for: .touchUpInside)
        popUp.trashButton.addTarget(self, action: #selector(trashPressed), for: .touchUpInside)
        
        setupView()
        getProductData()
        getUserData()
    }
    
    func getUserData() {
        getUserProtocol.fetchUserData() { [weak self] result in
            switch result {
            case .success(let userData):
                self!.user = userData["email"] as! String
            case .failure(let error):
                print("Failed to fetch user data:", error)
            }
        }
    }
    
    func getProductData() {
        ProductViewModelType.fetchProductData() { [weak self] result in
            switch result {
            case .success(let productData):
                //                print(productData)
                self?.parseProductData(productData: productData)
            case .failure(let error):
                print("Failed to fetch product data:", error)
            }
        }
    }
    
    func parseProductData(productData: [[String: Any]]) {
        for data in productData {
            if data["user"] as? String == user {
                if let id = data["id"] as? Int,
                   let user = data["user"] as? String,
                   let images = data["images"] as? [String],
                   let title = data["title"] as? String,
                   let price = data["price"] as? String,
                   let likes = data["likes"] as? Int,
                   let isFan = data["is_fan"] as? Bool {
                    let product: [String: Any] = [
                        "id": id,
                        "user": user,
                        "images": images,
                        "title": title,
                        "price": price,
                        "likes": likes,
                        "isFan": isFan
                    ]
                    products.append(product)
                }
            }
        }
        
        containView.updateView(with: self.products)
    }
    
    func setupView() {
        view.addSubview(containView)
        view.addSubview(popUp)
        
        containView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        popUp.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(644 * UIScreen.main.bounds.height / 812)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc func backPressed() {
        dismiss(animated: true)
    }
    
    @objc func infoButtonTapped(sender: UIButton) {
        sendId = (products[sender.tag]["id"] as? Int)!
        print(sendId)
        popUp.isHidden = false
        blurContainView()
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let touchPoint = gesture.location(in: view)
        if !popUp.frame.contains(touchPoint) {
            popUp.isHidden = true
            unblurContainView()
        }
    }
    
    @objc func changePressed() {
        let vc = ChangeProductViewController(changeProductProtocol: ChangeProductViewModel(id: sendId))
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func trashPressed() {
        ProductViewModelType.deleteProduct(withID: sendId)
    }

    func unblurContainView() {
        blurEffectView?.removeFromSuperview()
        blurEffectView = nil
    }
    
    func blurContainView() {
        let blurEffect = UIBlurEffect(style: .regular)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        view.addSubview(blurEffectView!)
        view.bringSubviewToFront(popUp) // Ensure the popUp is above the blurred view
    }
}


extension ProductViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCellView
        
        let product = products[indexPath.item]
        
        if let title = product["title"] as? String {
            cell.productNameLabel.text = title
        }
        
        if let price = product["price"] as? String {
            cell.priceLabel.text = price
        }
        
        if let images = product["images"] as? [String], let imageURLString = images.first, let imageURL = URL(string: imageURLString) {
            URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.productImageView.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        cell.productImageView.image = UIImage(named: "defaultImage")
                    }
                }
            }.resume()
        }
        
        cell.infoButton.tag = indexPath.row
        cell.infoButton.addTarget(self, action: #selector(self.infoButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = 161 * UIScreen.main.bounds.width / 375
        let cellHeight = 184 * UIScreen.main.bounds.height / 812
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
}
