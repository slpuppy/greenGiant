//
//  ExitButton.swift
//  the-seed-game
//
//  Created by Gabriel Puppi on 01/03/22.
//

import UIKit

class ExitButton: UIView {

    lazy var exitShopButton: UIButton = {
        let image = UIImage(named: "exitButton")
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect = .zero){
        super.init(frame: frame)
        setupSubviews()
        setupButtonViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        self.addSubview(exitShopButton)
    }
    
   private func setupButtonViewConstraints() {
      
        exitShopButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        
    }
    
}
