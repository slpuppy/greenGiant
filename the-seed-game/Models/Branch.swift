//
//  Branch.swift
//  the-seed-game
//
//  Created by Gabriel Puppi on 29/01/22.
//


import SpriteKit


class Branch {
    
    let node: SKSpriteNode
    let leftRefNode: SKNode
    let rightRefNode: SKNode
    
    
    init(node: SKSpriteNode) {
        self.node = node
        
        self.leftRefNode = Branch.buildNode()
        self.rightRefNode = Branch.buildNode()
        
        addRefNodesToNode()
        positionRefNodes()
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
        nodePhysicsBody.mass = 35
        nodePhysicsBody.angularDamping = 0.3
        node.physicsBody = nodePhysicsBody
        node.zPosition = 1
        node.name = Names.branch
        
        let branch = Branch(node: node)
        return branch
        
    }
    
    private static func buildNode() -> SKNode {
        return SKNode()
    }
    
    private func addRefNodesToNode() {
        self.node.addChild(self.leftRefNode)
        self.node.addChild(self.rightRefNode)
    }
    
    private func positionRefNodes() {
        self.leftRefNode.position.x = self.node.frame.minX + 5
        self.rightRefNode.position.x = self.node.frame.maxX - 5
    }
    
    enum Names {
        static let branch: String = "branch"
    }
}
