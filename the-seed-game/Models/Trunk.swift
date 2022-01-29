//
//  Trunk.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 28/01/22.
//

import SpriteKit

class Trunk {
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
            y: node.frame.minY
        )
        
        let joint = SKPhysicsJointFixed.joint(
            withBodyA: bodyA,
            bodyB: bodyB,
            anchor: anchorPosition)
        
      
        
//        joint.lowerAngleLimit = 0.2
//        joint.upperAngleLimit = 0.2
        
        physicsWorld.add(joint)
      
    }
    
    static func buildTrunk() -> Trunk {
        let node = SKSpriteNode(imageNamed: "trunk")
        let nodePhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 12, height: 160))
        node.zPosition = 1
        nodePhysicsBody.angularDamping = 0.4
        nodePhysicsBody.mass = 2
        node.physicsBody = nodePhysicsBody
        nodePhysicsBody.collisionBitMask = node.physicsBody!.collisionBitMask
        
        let trunk = Trunk(node: node)
        return trunk
    }
    
}
