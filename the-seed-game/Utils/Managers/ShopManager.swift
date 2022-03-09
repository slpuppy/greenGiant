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
//        ShopItem(name: "Organic Fertilizer", price: 210, type: .nutrient, effect: "Light Leafs", id: ItemIds.organicFert, image: UIImage(named: "fertilizer") ?? UIImage()),
//        ShopItem(name: "Ancient Bookashi", price: 420, type: .booster, effect: "Steady Growth", id: ItemIds.bookashi, image: UIImage(named: "bookashi") ?? UIImage()),
        ShopItem(name: "Regular Hemp", price: 0, type: .leafSkin, effect: "Cosmetics", id: ItemIds.regularHemp, image: UIImage(named: "branchLittle") ?? UIImage()),
        ShopItem(name: "Palm Weed", price: 25, type: .leafSkin, effect: "Cosmetics", id: ItemIds.palmWeed, image: UIImage(named: "palmWeedLittle") ?? UIImage()),
        ShopItem(name: "Blue Dream", price: 100, type: .leafSkin, effect: "Cosmetics", id: ItemIds.blueDream, image: UIImage(named: "blueDreamLittle") ?? UIImage()),
        ShopItem(name: "Crimson Kush", price: 250, type: .leafSkin, effect: "Cosmetics", id: ItemIds.crimsonKush, image: UIImage(named: "crimsonKushLittle") ?? UIImage()),
        ShopItem(name: "Purple Haze", price: 420, type: .leafSkin, effect: "Cosmetics", id: ItemIds.purpleHaze, image: UIImage(named: "purpleHazeLittle") ?? UIImage())
    ]
    
    init() {
        self.userItemsIds = UserDefaults().array(forKey: UserDefaultsKeys.userItemsIds) as? [String] ?? []
        if self.userItemsIds.isEmpty {
            saveItem(id: ItemIds.regularHemp)
        }
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
    
    enum ItemIds {
        // nutrient
        static let organicFert: String = "organicFert"
        
        // booster
        static let bookashi: String = "bookashi"
        
        // skin
        static let regularHemp: String = "regularHemp"
        static let blueDream: String = "blueDream"
        static let crimsonKush: String = "crimsonKush"
        static let palmWeed: String = "palmWeed"
        static let purpleHaze: String = "purpleHaze"
    }
}
