//
//  UnderShopView.swift
//  the-seed-game
//
//  Created by Gabriel Puppi on 23/02/22.
//

import UIKit

class UnderShopView: UIView {

    lazy var caveBackground: UIImageView = {
        let image = UIImage(named: "caveBG")
        let imageView = UIImageView()
        imageView.image = image
        return imageView
        
    }()
    
    lazy var growLight: UIImageView = {
        let image = UIImage(named: "growLight")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    lazy var title: UIImageView = {
        let image = UIImage(named: "shopTitle")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    lazy var itemFrame: UIView = {
        let image = UIImage(named: "itemFrame")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    
 
    
  
    
    

}
