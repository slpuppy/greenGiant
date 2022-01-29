//
//  Branch.swift
//  the-seed-game
//
//  Created by Gabriel Puppi on 29/01/22.
//


import SpriteKit


class Branch {
    
    let node: SKSpriteNode
    
    init(node: SKSpriteNode) {
        self.node = node
    }
    
    func attach(to otherTrunk: Trunk, on physicsWorld: SKPhysicsWorld) {
        guard let bodyA = node.physicsBody,
              let bodyB = otherTrunk.node.physicsBody else {
            return
        }
        
        let anchorPosition = CGPoint(
            x: node.frame.midX,
            y: node.frame.midY
        )
        
        let joint = SKPhysicsJointFixed.joint(
            withBodyA: bodyA,
            bodyB: bodyB,
            anchor: anchorPosition
        )

        physicsWorld.add(joint)
    }
    
}
