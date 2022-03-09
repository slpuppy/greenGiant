//
//  CoinManager.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 21/02/22.
//

import Foundation

class UserCoins {
    
    var coins: Int
    static let shared = UserCoins.init()
    
    private init() {

       self.coins = UserDefaults().integer(forKey: UserDefaultsKeys.coins)
    
    }
    
    func add(_ value: Int) {
        self.coins += value
        
        UserDefaults().set(self.coins, forKey: UserDefaultsKeys.coins)
    }
    
    func subtract(_ value: Int) {
        self.coins -= value
        
        UserDefaults().set(self.coins, forKey: UserDefaultsKeys.coins)
    }
    
    enum UserDefaultsKeys {
        static let coins: String = "coins"
    }
}
