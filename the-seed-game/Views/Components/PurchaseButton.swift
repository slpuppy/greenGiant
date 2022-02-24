//
//  PurchaseButton.swift
//  the-seed-game
//
//  Created by Gabriel Puppi on 24/02/22.
//

import UIKit

class PurchaseButton: UIButton {

    
    lazy var frameImage: UIImageView = {
        let image = UIImage(named: "buttonFrame")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var buttonBar: UIImageView = {
        let image = UIImage(named: "buttonBar")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var coinImage: UIImageView = {
        let image = UIImage(named: "shopCoin")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var priceContainer: UIView!
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var unlockLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var leafImage: UIImageView = {
        let image = UIImage(named: "leafImage")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView }()
   
    init(frame: CGRect = .zero, price: Int = 0, purchased: Bool = false){
        super.init(frame: frame)
        setupSubviews(price: price, purchased: purchased)
        if purchased {
            unlockLabel.text = "Unlocked"
            setupPriceContainerUnlockedConstraints()
        } else {
            unlockLabel.text = "Unlock"
            priceLabel.text = "\(price)"
            setupPriceContainerLockedConstraints()
        }
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews(price: Int, purchased:Bool) {
        self.addSubview(frameImage)
        self.addSubview(buttonBar)
        priceContainer = UIView()
        if purchased {
            priceContainer.addSubview(leafImage)
        } else {
            priceContainer.addSubview(coinImage)
            priceContainer.addSubview(priceLabel)
        }
        self.addSubview(priceContainer)
        self.addSubview(unlockLabel)
  }
    
    func setupPriceContainerUnlockedConstraints(){
        
        
    }
    
    func setupPriceContainerLockedConstraints(){
        coinImage.snp.makeConstraints { make in
            make.leading.equalTo(priceContainer.snp.leading)
            make.centerY.equalTo(priceContainer.snp.centerY)
        }
        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(coinImage.snp.trailing).offset(4.6)
            make.centerY.equalTo(priceContainer.snp.centerY)
        }
    }
    
    func setupConstraints() {
        frameImage.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.centerX.equalTo(self.snp.centerX)
        }
        priceContainer.snp.makeConstraints { make in
            make.leading.equalTo(frameImage.snp.leading).offset(10)
            make.centerY.equalTo(frameImage.snp.centerY)
        }
        buttonBar.snp.makeConstraints { make in
            make.leading.equalTo(priceContainer.snp.trailing).offset(6)
            make.centerY.equalTo(frameImage.snp.centerY)
        }
        unlockLabel.snp.makeConstraints { make in
            make.leading.equalTo(buttonBar.snp.trailing).offset(6)
            make.centerY.equalTo(frameImage.snp.centerY)
        }
        
        
    }
    
}
