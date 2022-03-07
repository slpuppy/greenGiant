//
//  UserSkins.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 05/03/22.
//

import Foundation

class TreeSkins {
    var userSkinsIds: [String] = []
    var currentSkinId: String = ""
    static let shared = TreeSkins.init()
    
    private init() {
        self.userSkinsIds = UserDefaults().array(forKey: UserDefaultsKeys.skins) as? [String] ?? []
        self.currentSkinId = UserDefaults().string(forKey: UserDefaultsKeys.currentSkinId) ?? ""
    }
    
    func add(_ skinId: String) {
        self.userSkinsIds.append(skinId)
        
        UserDefaults().set(self.userSkinsIds, forKey: UserDefaultsKeys.skins)
    }
    
    func setCurrentSkin(_ skinId: String) {
        if self.userSkinsIds.first(where: { $0 == skinId }) == nil {
            return
        }
        
        self.currentSkinId = skinId
        UserDefaults().set(self.currentSkinId, forKey: UserDefaultsKeys.currentSkinId)
    }
    
    enum UserDefaultsKeys {
        static let skins: String = "skins"
        static let currentSkinId: String = "currentSkin"
    }
}
