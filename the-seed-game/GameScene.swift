//
//  GameScene.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 28/01/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var lastTrunk: Trunk!
    var gameCamera: SKCameraNode!
    
    override func didMove(to view: SKView) {
        self.size = view.frame.size
        self.backgroundColor = .white
        self.anchorPoint = .init(x: 0.5, y: 0.5)
        let camera = SKCameraNode()
        self.addChild(camera)
        self.gameCamera = camera
        self.camera = camera
        
        #if DEBUG
        view.showsPhysics = true
        view.showsNodeCount = true
        view.showsFPS = true
//        self.speed = -50
        #endif
        
        let firstTrunk = buildTrunk()
        firstTrunk.node.position.y = self.frame.minY + firstTrunk.node.frame.size.height/2
        firstTrunk.node.physicsBody?.isDynamic = false
        self.addChild(firstTrunk)
        
        lastTrunk = firstTrunk
    }
    
    func buildTrunk() -> Trunk {
        let node = SKSpriteNode(color: .black, size: CGSize(width: 10, height: 100))
        
        let nodePhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height: 100))
        nodePhysicsBody.angularDamping = 50
        nodePhysicsBody.mass = 0.1
        node.physicsBody = nodePhysicsBody
        
        let trunk = Trunk(node: node)
        return trunk
    }
    
    func touchDown(atPoint pos : CGPoint) {
        let trunk = buildTrunk()
        trunk.node.position.y = lastTrunk.node.position.y + lastTrunk.node.frame.height
        trunk.node.position.x = lastTrunk.node.position.x
        self.addChild(trunk)
//        isPaused = true
        trunk.attach(to: lastTrunk, on: self.physicsWorld)
        trunk.node.anchorPoint = .zero
        trunk.node.zRotation = 0.2 * (pos.x < frame.midX ? -1 : 1) + lastTrunk.node.zRotation
        trunk.node.anchorPoint = .init(x: 0.5, y: 0.5)
//        isPaused = false
        lastTrunk = trunk
        
        
        self.gameCamera?.position = lastTrunk.node.position
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
