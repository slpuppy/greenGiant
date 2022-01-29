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
            x: otherTrunk.node.frame.midX,
            y: otherTrunk.node.frame.maxY
        )
        
        let joint = SKPhysicsJointFixed.joint(
            withBodyA: bodyA,
            bodyB: bodyB,
            anchor: anchorPosition
        )

        physicsWorld.add(joint)
    }
    
   static func buildBranch() -> Branch {
        
        let node = SKSpriteNode(imageNamed: "branch")
        let nodePhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 120, height: 30))
        nodePhysicsBody.mass = 1
        node.physicsBody = nodePhysicsBody
        node.zPosition = 1
        nodePhysicsBody.contactTestBitMask = node.physicsBody!.collisionBitMask
       
        
        let branch = Branch(node: node)
        return branch
        
    }
    

}
