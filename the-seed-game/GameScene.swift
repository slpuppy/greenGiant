//
//  GameScene.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 28/01/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var lastTwig: Twig!
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
        
        let root = buildTwig()
        root.node.position.y = self.frame.minY + root.node.frame.size.height/2
        root.node.physicsBody?.isDynamic = false
        self.addChild(root)
        
        lastTwig = root
    }
    
    func buildTwig() -> Twig {
        let node = SKSpriteNode(color: .black, size: CGSize(width: 10, height: 100))
        
        let nodePhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height: 100))
        nodePhysicsBody.angularDamping = 50
        nodePhysicsBody.mass = 0.1
        node.physicsBody = nodePhysicsBody
        
        let twig = Twig(node: node)
        return twig
    }
    
    func touchDown(atPoint pos : CGPoint) {
        let twig = buildTwig()
        twig.node.position.y = lastTwig.node.position.y + lastTwig.node.frame.height
        twig.node.position.x = lastTwig.node.position.x
        self.addChild(twig)
//        isPaused = true
        twig.attach(to: lastTwig, on: self.physicsWorld)
        twig.node.anchorPoint = .zero
        twig.node.zRotation = 0.2 * (pos.x < frame.midX ? -1 : 1) + lastTwig.node.zRotation
        twig.node.anchorPoint = .init(x: 0.5, y: 0.5)
//        isPaused = false
        lastTwig = twig
        
        
        self.gameCamera?.position = lastTwig.node.position
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
