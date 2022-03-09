//
//  LittleBranch.swift
//  the-seed-game
//
//  Created by Gabriel Puppi on 29/01/22.
//


import SpriteKit


class LittleBranch {
    
    let node: SKSpriteNode
    let leftRefNode: SKNode
    let rightRefNode: SKNode
    
    
    init(node: SKSpriteNode) {
        self.node = node
        
        self.leftRefNode = LittleBranch.buildNode()
        self.rightRefNode = LittleBranch.buildNode()
        
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
        
        let node = SKSpriteNode(texture: SKTexture(image: UserSkins.shared.currentSkinData.littleBranchImage))
        
        node.scale(to: CGSize(width: node.size.width*0.8, height: node.size.height*0.8))
//        let nodePhysicsBody = SKPhysicsBody(rectangleOf: node.size)
        let nodePhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: node.size.width, height: 5))
        nodePhysicsBody.mass = 10
        node.physicsBody?.angularDamping = 0.2
        node.physicsBody = nodePhysicsBody
        node.zPosition = 5
        node.name = Names.littleBranch
        
        let littleBranch = LittleBranch(node: node)
        return littleBranch
        
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
        static let littleBranch: String = "littleBranch"
    }
}

