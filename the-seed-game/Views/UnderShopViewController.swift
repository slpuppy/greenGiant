//
//  UnderShopViewController.swift
//  the-seed-game
//
//  Created by Gabriel Puppi on 23/02/22.
//

import UIKit
import SnapKit

class UnderShopViewController: UIViewController {
    
    var underShopView: UnderShopView!
    var shopManager = ShopManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      print("Presented")
        
        setupView()
        setupSubviews()
        setupConstraints()
    }
    
    func setupView(){
        self.view.backgroundColor = .black
        let firstItem = shopManager.items[0]
        let purchasedFirst = shopManager.userItemsIds.contains(firstItem.id)
        underShopView = UnderShopView(data: UnderShopViewDTO(
            userCoins: UserCoins.shared.coins,
            itemData: shopManager.items[0] ,
            purchased: purchasedFirst
        ))
    }
    
    func setupSubviews() {
        self.view.addSubview(underShopView)
        
    }
    
    func setupConstraints() {
        underShopView.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY)
        }
    }
}
