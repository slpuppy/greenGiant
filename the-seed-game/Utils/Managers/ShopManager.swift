//
//  ShopManager.swift
//  the-seed-game
//
//  Created by Gabriel Puppi on 23/02/22.
//

import UIKit


class ShopManager {
    
    var userItemsIds: [String]
    
    var items: [ShopItem] = [
        ShopItem(name: "Organic Fertilizer", price: 210, type: .nutrient, effect: "Light Leafs", id: "organicFert", image: UIImage(named: "fertilizer") ?? UIImage()),
        ShopItem(name: "Ancient Bookashi", price: 420, type: .booster, effect: "Steady Growth", id: "bookashi", image: UIImage(named: "bookashi") ?? UIImage())
    ]
    
    init() {
        
        self.userItemsIds = UserDefaults().array(forKey: UserDefaultsKeys.userItemsIds) as? [String] ?? []
        
    }
    
    func purchaseItem(id itemId: String) -> ShopItem? {
        let item = items.first(where: {
            return $0.id == itemId
        })
        
        guard let selectedItem = item else {
            return nil
        }
        if selectedItem.price <= UserCoins.shared.coins {
            
            UserCoins.shared.subtract(selectedItem.price)
            saveItem(id: selectedItem.id)
            return selectedItem
        }
        return nil
    }
    
    private func saveItem(id itemId: String) {
        userItemsIds.append(itemId)
        UserDefaults().set(userItemsIds, forKey: UserDefaultsKeys.userItemsIds)
        
        
    }
    
    enum UserDefaultsKeys {
        static let userItemsIds: String = "userItemsIds"
    }
}
