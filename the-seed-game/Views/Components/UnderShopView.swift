//
//  UnderShopView.swift
//  the-seed-game
//
//  Created by Gabriel Puppi on 23/02/22.
//

import UIKit

struct UnderShopViewDTO {
    let userCoins: Int
    let itemData: ShopItem
    let purchased: Bool
}
class UnderShopView: UIView {

    lazy var caveBackground: UIImageView = {
        let image = UIImage(named: "caveBG")
        let imageView = UIImageView()
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    lazy var growLed: UIImageView = {
        let image = UIImage(named: "growLed")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var title: UIImageView = {
        let image = UIImage(named: "shopSign")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var lightRay: UIImageView = {
        let image = UIImage(named: "lightRay")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var leftArrow: UIButton = {
        let image = UIImage(named: "leftArrow")
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
   
    lazy var rightArrow: UIButton = {
        let image = UIImage(named: "rightArrow")
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var itemContainer: UIView = {
        let view = UIView()
        view.addSubview(leftArrow)
        view.addSubview(rightArrow)
        view.addSubview(shopItemView)
        view.translatesAutoresizingMaskIntoConstraints = false
        shopItemView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        leftArrow.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(view.snp.centerY)
            make.trailing.equalTo(shopItemView.snp.leading).offset(-18)
        }
      rightArrow.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalTo(view.snp.centerY)
            make.leading.equalTo(shopItemView.snp.trailing).offset(18)
        }
        return view
    }()
    
    var yourCoins: UserCoinsView!
    
    var shopItemView: ShopItemView!

    var purchaseButton: PurchaseButton!
    
    
    init(frame: CGRect = .zero, data: UnderShopViewDTO) {
        super.init(frame: frame)
        setupViewData(data)
        setupSubviews()
        setupViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupViewData(_ data: UnderShopViewDTO){
        yourCoins = UserCoinsView(userCoins: data.userCoins)
        shopItemView = ShopItemView(itemData: data.itemData)
        purchaseButton = PurchaseButton(price: data.itemData.price, purchased: data.purchased)
        
    }
    
    
    func setupSubviews(){
        self.addSubview(caveBackground)
        self.addSubview(lightRay)
        self.addSubview(growLed)
        self.addSubview(title)
        self.addSubview(itemContainer)
        self.addSubview(yourCoins)
        self.addSubview(purchaseButton)
        
    
    }
    
    func setupViewConstraints() {
        caveBackground.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
      
        growLed.snp.makeConstraints { make in
            make.centerX.equalTo(caveBackground.snp.centerX)
            make.top.equalTo(caveBackground.snp.top).offset(-10)
        }
        title.snp.makeConstraints { make in
            make.centerX.equalTo(caveBackground.snp.centerX)
            make.top.equalTo(growLed.snp.bottom).offset(20)
        }
        yourCoins.snp.makeConstraints { make in
            make.centerX.equalTo(caveBackground.snp.centerX)
            make.top.equalTo(title.snp.bottom).offset(20)
        }
        itemContainer.snp.makeConstraints { make in
            make.centerX.equalTo(caveBackground.snp.centerX)
            make.top.equalTo(yourCoins.snp.bottom).offset(32)
            
        }
        purchaseButton.snp.makeConstraints { make in
            make.centerX.equalTo(caveBackground.snp.centerX)
            make.top.equalTo(itemContainer.snp.bottom).offset(24)
        }
        lightRay.snp.makeConstraints { make in
            make.leading.equalTo(caveBackground.snp.leading)
            make.trailing.equalTo(caveBackground.snp.trailing)
            make.bottom.equalTo(caveBackground.snp.bottom).offset(-7)
        }
       
         
            
            
          
        
    
        
        
        
        
    }
  
    
    

}
