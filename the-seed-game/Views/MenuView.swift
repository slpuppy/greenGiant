//
//  MenuView.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 08/02/22.
//

import UIKit
import SnapKit

class MenuView: UIView {
    
    lazy var gameCenterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "gamecontroller"), for: .normal)
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var muteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var pauseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pause"), for: .normal)
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
//        self.snp.makeConstraints { make in
//            make.width.equalTo(50)
//       }
        
        self.backgroundColor = UIColor(white: 1, alpha: 0.6)
        self.layer.cornerRadius = 29
        setupMenuBarItems()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupMenuBarItems() {
       
        self.addSubview(muteButton)
        self.addSubview(gameCenterButton)
      
        
        muteButton.imageView?.snp.makeConstraints({ make in
            make.size.equalTo(28)
        })
        
        gameCenterButton.imageView?.snp.makeConstraints({ make in
            make.size.equalTo(32)
        })
        
     
        muteButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp_topMargin).offset(10)
            make.centerX.equalTo(self.snp_centerXWithinMargins)
//            make.leading.equalTo(self.snp_leadingMargin).offset(6)
//            make.trailing.equalTo(self.snp_trailingMargin).offset(-6)
            make.size.equalTo(28)
        }
        gameCenterButton.snp.makeConstraints { make in
            make.top.equalTo(muteButton.snp_bottomMargin).offset(32)
            make.centerX.equalTo(self.snp_centerXWithinMargins)
            make.bottom.equalTo(self.snp_bottomMargin).offset(-6)
            make.leading.equalTo(self.snp_leadingMargin).offset(6)
            make.trailing.equalTo(self.snp_trailingMargin).offset(-6)
            make.size.equalTo(32)
        }
        
    }
    
    
}
