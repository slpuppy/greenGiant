//
//  Trunk.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 28/01/22.
//

import SpriteKit

class Trunk {
    let node: SKSpriteNode
    
    let topRefNode: SKNode
    let bottomRefNode: SKNode
    let branchLeftRefNode: SKNode
    let branchRightRefNode: SKNode
    let littleBranchLeftRefNode: SKNode
    let littleBranchRightRefNode: SKNode
    
    init(node: SKSpriteNode) {
        self.node = node
        
        self.topRefNode = Trunk.buildNode()
        self.topRefNode.name = "topRef"
        self.bottomRefNode = Trunk.buildNode()
        self.bottomRefNode.name = "bottomRef"
        self.branchLeftRefNode = Trunk.buildNode()
        self.branchLeftRefNode.name = "branchLeftRef"
        self.branchRightRefNode = Trunk.buildNode()
        self.branchRightRefNode.name = "branchRightRef"
        self.littleBranchLeftRefNode = Trunk.buildNode()
        self.littleBranchLeftRefNode.name = "littleBranchLeftRef"
        self.littleBranchRightRefNode = Trunk.buildNode()
        self.littleBranchRightRefNode.name = "littleBranchRightRef"
        
        addRefNodesToNode()
        positionRefNodes()
    }
    
    func attach(to otherTrunk: Trunk, on physicsWorld: SKPhysicsWorld) {
        guard let bodyA = node.physicsBody,
              let bodyB = otherTrunk.node.physicsBody else {
            return
        }
        
        let anchorPosition = CGPoint(
            x: node.frame.midX,
            y: node.frame.maxY + 5
        )
        
        let joint = SKPhysicsJointFixed.joint(
            withBodyA: bodyA,
            bodyB: bodyB,
            anchor: anchorPosition
        )
    
        physicsWorld.add(joint)
    }
    
    static func buildTrunk() -> Trunk {
        let node = SKSpriteNode(imageNamed: "trunk")
//        node.scale(to: CGSize(width: node.size.width*0.8, height: node.size.height*0.8))
        let nodePhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: node.frame.width, height: node.frame.height))
        node.zPosition = 5
        nodePhysicsBody.angularDamping = 0.8
        nodePhysicsBody.mass = 10
        node.physicsBody = nodePhysicsBody
        node.name = Names.trunk
        
        let trunk = Trunk(node: node)
        return trunk
    }
    
    private static func buildNode() -> SKNode {
        return SKNode()
    }
    
    private func addRefNodesToNode() {
        self.node.addChild(self.topRefNode)
        self.node.addChild(self.bottomRefNode)
        self.node.addChild(self.branchLeftRefNode)
        self.node.addChild(self.branchRightRefNode)
        self.node.addChild(self.littleBranchLeftRefNode)
        self.node.addChild(self.littleBranchRightRefNode)
    }
    
    private func positionRefNodes() {
        self.topRefNode.position.y = self.node.frame.maxY
        self.bottomRefNode.position.y = self.node.frame.minY
        
        self.branchLeftRefNode.position = CGPoint(
            x: self.node.frame.minX + 3,
            y: self.node.frame.maxY - 25
        )
        self.branchRightRefNode.position = CGPoint(
            x: self.node.frame.maxX - 3,
            y: self.node.frame.maxY - 25
        )
        
        self.littleBranchLeftRefNode.position = CGPoint(
            x: self.node.frame.minX + 3,
            y: self.node.frame.minY + 25
        )
        self.littleBranchRightRefNode.position = CGPoint(
            x: self.node.frame.maxX - 3,
            y: self.node.frame.minY + 25
        )
    }
    
    enum Names {
        static let trunk: String = "trunk"
    }
}
