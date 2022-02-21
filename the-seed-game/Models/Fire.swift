//
//  Fire.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 14/02/22.
//

import SpriteKit

class Fire {
    let node: SKSpriteNode
    static var fireFrames: [SKTexture] = {
        var arr: [SKTexture] = []
        for i in 1...4 {
            arr.append(
                SKTexture(image: UIImage(named: "fire\(i)") ?? UIImage())
            )
        }
        
        return arr
    }()
    
    init() {
        self.node = Fire.buildFire()
        runFireAnimation()
    }
    
    private static func buildFire() -> SKSpriteNode {
        let fire = SKSpriteNode(texture: Fire.fireFrames[0])
        fire.anchorPoint = .init(x: 0.5, y: 0)
        fire.position.y += 5
        fire.position.x += 3
        fire.setScale(0)
        fire.name = Names.fire
        
        return fire
    }
    
    private func runFireAnimation() {
        let showFireAnimation: SKAction = .scale(to: 1, duration: 0.3)
        
        var fireAnimationSequence: [SKAction] = []
        
        for frameTexture in Fire.fireFrames {
            fireAnimationSequence.append(
                .setTexture(frameTexture)
            )
            fireAnimationSequence.append(
                .wait(forDuration: 0.2)
            )
        }
        
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
