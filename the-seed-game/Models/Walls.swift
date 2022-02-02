//
//  Walls.swift
//  the-seed-game
//
//  Created by Gabriel Puppi on 29/01/22.
//

import SpriteKit


class Walls {
    
    let rightWall: SKNode
    let leftWall: SKNode
    
    init(rightWall: SKNode, leftWall: SKNode) {
        self.rightWall = rightWall
        self.leftWall = leftWall
    }
    
    static func buildLeftWall(frame: CGRect) -> SKNode {
        let node = SKNode()
        let nodePhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height:frame.height))
        nodePhysicsBody.isDynamic = false
        node.physicsBody = nodePhysicsBody
        node.position.x = frame.minX
        node.name = Names.leftWall
        
        return node
    }
    
    static func buildRightWall(frame: CGRect) -> SKNode {
        let node = SKNode()
        let nodePhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height:frame.height))
        nodePhysicsBody.isDynamic = false
        node.physicsBody = nodePhysicsBody
        node.position.x = frame.maxX
        node.name = Names.rightWall
        
        return node
    }
    
    func updatePosition(to pos: CGPoint) {
        rightWall.position.y = pos.y
        leftWall.position.y = pos.y
    }
    
    func removeWalls() {
        self.rightWall.removeFromParent()
        self.leftWall.removeFromParent()
    }
    
    enum Names {
        static let leftWall: String = "leftWall"
        static let rightWall: String = "rightWall"
    }
    
}
