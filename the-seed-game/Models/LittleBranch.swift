//
//  LittleBranch.swift
//  the-seed-game
//
//  Created by Gabriel Puppi on 29/01/22.
//


import SpriteKit


class LittleBranch {
    
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
            x: otherTrunk.node.frame.midX,
            y: otherTrunk.node.frame.midY
        )
        
        let joint = SKPhysicsJointFixed.joint(
            withBodyA: bodyA,
            bodyB: bodyB,
            anchor: anchorPosition
        )

        physicsWorld.add(joint)
    }
    
   static func buildLittleBranch() -> LittleBranch {
        
        let node = SKSpriteNode(imageNamed: "littleBranch")
        let nodePhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 66, height: 40))
        nodePhysicsBody.mass = 10
       node.physicsBody?.angularDamping = 0.2
        node.physicsBody = nodePhysicsBody
        node.zPosition = 1
       node.name = Names.littleBranch
        
        let littleBranch = LittleBranch(node: node)
        return littleBranch
        
    }
    
    enum Names {
        static let littleBranch: String = "littleBranch"
    }
}

