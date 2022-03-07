//
//  Coin.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 21/02/22.
//

import SpriteKit

class Coin {
    let node: SKSpriteNode
    static var coinFrames: [SKTexture] = {
        var arr: [SKTexture] = []
        for i in 1...7 {
            arr.append(
                SKTexture(image: UIImage(named: "coin\(i)") ?? UIImage())
            )
        }
        
        return arr
    }()
    
    init() {
        self.node = Coin.buildCoin()
        runCoinAnimation()
    }
    
    private static func buildCoin() -> SKSpriteNode {
        let coin = SKSpriteNode(texture: Coin.coinFrames[0])
        coin.setScale(0.5)
        coin.zPosition = 1
        coin.name = Names.coin
        
        return coin
    }
    
    private func runCoinAnimation() {
        var coinAnimationSequence: [SKAction] = []
        
        for frameTexture in Coin.coinFrames {
            coinAnimationSequence.append(
                .setTexture(frameTexture)
            )
            coinAnimationSequence.append(
                .wait(forDuration: 0.1)
            )
        }
        
        self.node.run(.repeatForever(.sequence(coinAnimationSequence)))
    }
    
    enum Names {
        static let coin: String = "coin"
    }
}
