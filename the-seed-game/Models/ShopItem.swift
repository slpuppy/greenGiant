//
//  ShopItem.swift
//  the-seed-game
//
//  Created by Gabriel Puppi on 23/02/22.
//

import Foundation
import UIKit

class ShopItem {
    let name: String
    let price: Int
    let type: ItemType
    let effect: String
    let id: String
    let image: UIImage
    
    init(name: String, price: Int, type: ShopItem.ItemType, effect: String, id: String, image: UIImage) {
        self.name = name
        self.price = price
        self.type = type
        self.effect = effect
        self.id = id
        self.image = image
    }
    
    
    enum ItemType: String {
        case booster = "Booster"
        case nutrient = "Nutrient"
    }
}


