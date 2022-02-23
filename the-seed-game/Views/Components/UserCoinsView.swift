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
        label.text = "\(UserCoins.shared.coins)"
        return label
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.addSubview(coinImage)
        self.addSubview(userCoinsLabel)
        self.addSubview(label)
        
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
            make.top.equalTo(self.snp.top)
        }
        
        
        
        
    }
    
    
    
    
}
