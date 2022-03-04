//
//  leaderboardButton.swift
//  the-seed-game
//
//  Created by Gabriel Puppi on 25/02/22.
//

import Foundation
import SpriteKit


class HomeButtons {
    
    let node: SKNode
    let leaderboardButton: SKSpriteNode
    let shopButton: SKSpriteNode
    
    init(frame: CGRect){
        node = SKNode()
        leaderboardButton = HomeButtons.buildLeaderboardButton(frame: frame)
        shopButton = HomeButtons.buildShopButton(frame: frame)
        setupChilds()
    }
    
    static private func buildLeaderboardButton(frame: CGRect) -> SKSpriteNode {
        let node = SKSpriteNode(imageNamed: "leaderboardButton")
        node.anchorPoint = .init(x: 0.0, y: 0.5)
        node.position.x = frame.minX + 24
        node.zPosition = 8
      
        return node
    }
    
    static private func buildShopButton(frame: CGRect) -> SKSpriteNode {
        let node = SKSpriteNode(imageNamed: "shopButton")
        node.anchorPoint = .init(x: 1.0, y: 0.5)
        node.position.x = frame.maxX - 24
        node.zPosition = 8
        
        return node
    }
    
    private func setupChilds() {
        self.node.addChild(leaderboardButton)
        self.node.addChild(shopButton)
    }
    
    func removeButtons() {
        self.node.removeFromParent()
    }
    
   
}
