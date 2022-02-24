//
//  UserCoinsView.swift
//  the-seed-game
//
//  Created by Gabriel Puppi on 23/02/22.
//

import UIKit
import SnapKit

class UserCoinsView: UIView {
    
    lazy var coinImage: UIImageView = {
        let view = UIImageView(image: UIImage(named: "shopCoin"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var label: UILabel = {
        let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Your Coins:"
        return label
    }()
    
    lazy var userCoinsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(frame: CGRect = .zero, userCoins: Int) {
        super.init(frame: frame)
        self.userCoinsLabel.text = "\(userCoins)"
        self.addSubview(coinImage)
        self.addSubview(userCoinsLabel)
        self.addSubview(label)
        setupViewConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func setupViewConstraints() {
        self.label.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.centerY.equalTo(self.snp.centerY)
        }
        self.userCoinsLabel.snp.makeConstraints { make in
            make.leading.equalTo(label.snp.trailing).offset(15)
            
     
        }
        self.coinImage.snp.makeConstraints { make in
            make.leading.equalTo(userCoinsLabel.snp.trailing).offset(15)
            make.trailing.equalTo(self.snp.trailing)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        
        
        
        
    }
    
    
    
    
}
