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
    
   static func buildBranch() -> Branch {
        
        let node = SKSpriteNode(color: .black, size: CGSize(width: 80, height: 10))
        let nodePhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 80, height: 5))
        nodePhysicsBody.mass = 2
        node.physicsBody = nodePhysicsBody
        node.zPosition = 1
        
        let branch = Branch(node: node)
        return branch
        
    }
    
}
