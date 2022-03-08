//
//  UserSkins.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 05/03/22.
//

import Foundation
import UIKit

class UserSkins {
    private var currentSkinId: String = ""
    private var currentSkinData: SkinData!
    static let shared = UserSkins.init()
    
    private let skins: [SkinData] = [
        SkinData( // DEFAULT SKIN
            id: "",
            branchImage: UIImage(named: "branch") ?? UIImage(),
            littleBranchImage: UIImage(named: "branchLittle") ?? UIImage()
        ),
        SkinData(
            id: ShopManager.ItemIds.blueDream,
            branchImage: UIImage(named: "blueDream") ?? UIImage(),
            littleBranchImage: UIImage(named: "blueDreamLittle") ?? UIImage()
        ),
        SkinData(
            id: ShopManager.ItemIds.crimsonKush,
            branchImage: UIImage(named: "crimsonKush") ?? UIImage(),
            littleBranchImage: UIImage(named: "crimsonKushLittle") ?? UIImage()
        ),
        SkinData(
            id: ShopManager.ItemIds.palmWeed,
            branchImage: UIImage(named: "palmWeed") ?? UIImage(),
            littleBranchImage: UIImage(named: "palmWeedLittle") ?? UIImage()
        ),
        SkinData(
            id: ShopManager.ItemIds.purpleHaze,
            branchImage: UIImage(named: "purpleHaze") ?? UIImage(),
            littleBranchImage: UIImage(named: "purpleHazeLittle") ?? UIImage()
        ),
    ]
    
    private init() {
        self.currentSkinId = UserDefaults().string(forKey: UserDefaultsKeys.currentSkinId) ?? ""
        self.currentSkinData = getCurrentSkinData()
    }
    
    func setCurrentSkin(_ skinId: String) {
        self.currentSkinId = skinId
        UserDefaults().set(self.currentSkinId, forKey: UserDefaultsKeys.currentSkinId)
    }
    
    func getCurrentSkinData() -> SkinData {
        guard let skin = skins.first(where: { item in
            return item.id == self.currentSkinId
        }) else {
            return skins[0]
        }
        
        return skin
    }
    
    enum UserDefaultsKeys {
        static let currentSkinId: String = "currentUserSkin"
    }
}
