//
//  Fire.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 14/02/22.
//

import SpriteKit

class Fire {
    let node: SKSpriteNode
    
    init() {
        self.node = Fire.buildFire()
        runFireAnimation()
    }
    
    private static func buildFire() -> SKSpriteNode {
        let fire = SKSpriteNode(imageNamed: "fire1")
        fire.anchorPoint = .init(x: 0.5, y: 0)
        fire.position.y += 5
        fire.position.x += 3
        fire.setScale(0)
        fire.name = Names.fire
        
        return fire
    }
    
    private func runFireAnimation() {
        let showFireAnimation: SKAction = .scale(to: 1, duration: 0.3)
        
        let fireAnimationSequence: [SKAction] = [
            .setTexture(SKTexture(image: UIImage(named: "fire2") ?? UIImage())),
            .wait(forDuration: 0.2),
            .setTexture(SKTexture(image: UIImage(named: "fire3") ?? UIImage())),
            .wait(forDuration: 0.2),
            .setTexture(SKTexture(image: UIImage(named: "fire4") ?? UIImage())),
            .wait(forDuration: 0.2),
            .setTexture(SKTexture(image: UIImage(named: "fire1") ?? UIImage())),
            .wait(forDuration: 0.2),
        ]
        
        self.node.run(.sequence([
            showFireAnimation,
            .repeatForever(.sequence(fireAnimationSequence))
        ]))
    }
    
    static func removeFire(node: SKSpriteNode) {
        let dismissAnimation: SKAction = .group([
//            .fadeOut(withDuration: 0.3),
            .scale(to: 0, duration: 0.3)
        ])
        
        node.run(.sequence([
            dismissAnimation,
            .run {
                node.removeFromParent()
            }
        ]))
    }
    
    enum Names {
        static let fire: String = "fire"
    }
}
