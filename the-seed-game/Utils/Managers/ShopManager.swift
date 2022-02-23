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
        ShopItem(name: "Organic Fertilizer", price: 100, type: .nutrient, effect: "Steady Growth", id: "organicFert", image: UIImage(named: "fertilizer") ?? UIImage())
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
