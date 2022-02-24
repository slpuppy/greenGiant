//
//  ShopItemFrame.swift
//  the-seed-game
//
//  Created by Gabriel Puppi on 23/02/22.
//

import UIKit

class ShopItemView: UIView {

    lazy var imageFrame: UIImageView = {
        let image = UIImage(named: "itemFrame")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var itemImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var itemName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var itemTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var itemEffectLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    init(frame: CGRect = .zero, itemData: ShopItem){
        super.init(frame: frame)
        setupComponentsData(itemData)
        setupSubviews()
        setupConstraints()
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponentsData(_ data: ShopItem){
        itemImage.image = data.image
        itemName.text = data.name
        itemTypeLabel.text = data.type.rawValue
        itemEffectLabel.text = data.effect
   }

    func setupSubviews() {
        self.addSubview(imageFrame)
        self.addSubview(itemImage)
        self.addSubview(itemName)
        self.addSubview(itemTypeLabel)
        self.addSubview(itemEffectLabel)
   }
    func setupConstraints() {
        imageFrame.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            
        }
        itemImage.snp.makeConstraints { make in
            make.leading.equalTo(imageFrame.snp.leading).offset(24)
            make.centerY.equalTo(imageFrame.snp.centerY)
        }
        itemName.snp.makeConstraints { make in
            make.top.equalTo(imageFrame.snp.top).offset(16)
            make.leading.equalTo(itemImage.snp.trailing).offset(10)
        }
        itemTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(itemName.snp.bottom).offset(12)
            make.leading.equalTo(itemName.snp.leading)
            }
        itemEffectLabel.snp.makeConstraints { make in
            make.top.equalTo(itemName.snp.bottom).offset(8)
            make.leading.equalTo(itemName.snp.leading)
        }
        
    }
    
}
