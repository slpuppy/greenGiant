//
//  UnderShopViewController.swift
//  the-seed-game
//
//  Created by Gabriel Puppi on 23/02/22.
//

import UIKit
import SnapKit

protocol UnderShopDelegate: AnyObject {
    func updateGameScene()
}

class UnderShopViewController: UIViewController {
    
    var underShopView: UnderShopView!
    var shopManager = ShopManager()
    var backgroundView: UIView!
    var currentItemIndex = 0
    var exitButton: ExitButton!
    weak var underShopDelegate: UnderShopDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Presented")
        setupView()
        setupSubviews()
        setupConstraints()
        setupTouches()
        underShopView.backgroundColor = .black
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        blinkLightAnimation()
    }
    
    func blinkLightAnimation(){
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.1
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        underShopView.lightRay.layer.add(flash, forKey: nil)
    }
    func purchaseButtonAnimation(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: underShopView.purchaseButton.center.x - 10, y: underShopView.purchaseButton.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: underShopView.purchaseButton.center.x + 10, y: underShopView.purchaseButton.center.y))
        
        underShopView.purchaseButton.layer.add(animation, forKey: "position")
        
    }
    
    func cantPurchaseAnimatition() {
        blinkLightAnimation()
        purchaseButtonAnimation()
    }
    
    func setupView(){
        backgroundView = UIView()
        backgroundView.backgroundColor = .black
        self.exitButton = ExitButton()
        let firstItem = shopManager.items[0]
        let purchasedFirst = shopManager.userItemsIds.contains(firstItem.id)
        underShopView = UnderShopView(data: UnderShopViewDTO(
            userCoins: UserCoins.shared.coins,
            itemData: shopManager.items[0] ,
            purchased: purchasedFirst
        ))
    }
    
    func setupSubviews() {
        self.view.addSubview(backgroundView)
        self.view.addSubview(underShopView)
        self.view.addSubview(exitButton)
    }
    
    func setupConstraints() {
        underShopView.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY)
        }
        backgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            
        }
        exitButton.snp.makeConstraints { make in
            make.bottom.equalTo(underShopView.snp.top).offset(-10)
            make.height.equalTo(60)
            make.leading.equalTo(self.view.snp.centerX).offset(16)
            make.trailing.equalTo(self.view.snp.trailing).offset(-36)
            
            
        }
    }
    
    @objc func nextItemPressed() {
        let numberOfItems = shopManager.items.count
        if (numberOfItems - 1) == currentItemIndex {
            currentItemIndex = 0
        } else {
            currentItemIndex += 1
        }
        updateCurrentItem()
    }
    
    @objc func previousItemPressed() {
        let numberOfItems = shopManager.items.count
        if 0 == currentItemIndex {
            currentItemIndex = (numberOfItems - 1)
        } else {
            currentItemIndex -= 1
        }
        updateCurrentItem()
    }
    
    @objc func purchaseItemPressed() {
        let item = shopManager.items[currentItemIndex]
        let purchased = shopManager.userItemsIds.contains(item.id)
        
        if item.type == .leafSkin && purchased {
            updateSkin(item: item)
            return
        }
        purchaseItem(item: item)
    }
    
    func purchaseItem(item: ShopItem) {
       let purchased = shopManager.userItemsIds.contains(item.id)
        
        if UserCoins.shared.coins >= item.price && !purchased {
            shopManager.purchaseItem(id: item.id)
            updateYourCoins()
            updateCurrentItem()
            updateSkin(item: item)
        } else {
            cantPurchaseAnimatition()
        }
    }
    
    func updateSkin(item: ShopItem){
        if item.type != .leafSkin {
            return
        }
        UserSkins.shared.setCurrentSkin(item.id)
       updateCurrentItem()
    }
    
    @objc func exitShopButtonPressed() {
        underShopDelegate?.updateGameScene()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func updateCurrentItem() {
        let item = shopManager.items[currentItemIndex]
        let purchasedItem = shopManager.userItemsIds.contains(item.id)
        underShopView.shopItemView.update(item)
        if item.type == .leafSkin && UserSkins.shared.currentSkinId == item.id {
            underShopView.purchaseButton.update(price: item.price, purchased: purchasedItem, selected: true)
            return
        }
        underShopView.purchaseButton.update(price: item.price, purchased: purchasedItem)
        
    }
    
    
    
    func updateYourCoins() {
        
        underShopView.yourCoins.update(userCoins: UserCoins.shared.coins)
    }
    
    func setupTouches() {
        underShopView.leftArrow.addTarget(self, action: #selector(previousItemPressed), for: .touchUpInside)
        underShopView.rightArrow.addTarget(self, action: #selector(nextItemPressed), for: .touchUpInside)
        underShopView.purchaseButton.addTarget(self, action: #selector(purchaseItemPressed), for: .touchUpInside)
        exitButton.exitShopButton.addTarget(self, action: #selector(exitShopButtonPressed), for: .touchUpInside)
    }
    
}
