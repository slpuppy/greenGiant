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
    var lastBranch: Branch!
    var gameCamera: SKCameraNode!
    var leftWall: SKNode!
    var rightWall: SKNode!
    var trunkLoop: [Trunk] = []
    var branchLoop: [Branch] = []
    
    override func didMove(to view: SKView) {
        self.size = view.frame.size
        self.backgroundColor = .white
        self.anchorPoint = .init(x: 0.5, y: 0.5)
        let camera = SKCameraNode()
        self.addChild(camera)
        self.gameCamera = camera
        self.camera = camera
        
        leftWall = SKNode()
        let leftWallPhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: self.frame.height))
        leftWallPhysicsBody.isDynamic = false
        leftWall.physicsBody = leftWallPhysicsBody
        leftWall.position.x = self.frame.minX
        self.addChild(leftWall)
        
        rightWall = SKNode()
        let rightWallPhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: self.frame.height))
        rightWallPhysicsBody.isDynamic = false
        rightWall.physicsBody = rightWallPhysicsBody
        rightWall.position.x = self.frame.maxX
        self.addChild(rightWall)
        
        
        
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
        trunkLoop.append(firstTrunk)
    }
    
    func buildTrunk() -> Trunk {
        let node = SKSpriteNode(color: .black, size: CGSize(width: 10, height: 100))
        let nodePhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height: 100))
        nodePhysicsBody.angularDamping = 5.0
        nodePhysicsBody.mass = 1
        node.physicsBody = nodePhysicsBody
        
        let trunk = Trunk(node: node)
        return trunk
    }
    
    func buildBranch() -> Branch {
        
        let node = SKSpriteNode(color: .black, size: CGSize(width: 80, height: 10))
        let nodePhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 80, height: 5))
        nodePhysicsBody.mass = 0.5
        node.physicsBody = nodePhysicsBody
        
        let branch = Branch(node: node)
        return branch
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
        setupBranch(pos: pos)
        setupTrunk(pos: pos)
        if lastTrunk.node.position.y > self.frame.midY {
            
            self.gameCamera?.run(.move(to: CGPoint(x: 0, y: lastTrunk.node.position.y), duration: 0.5))
        }
        leftWall.position.y = lastTrunk.node.position.y
        rightWall.position.y = lastTrunk.node.position.y
    }
    
    func discardUselessElements() {
        for trunk in trunkLoop {
            if checkUselessElement(trunk.node){
                trunk.node.removeFromParent()
            }
            
        }
    }
    
    func checkUselessElement(_ element: SKSpriteNode) -> Bool {
        if element.position.y < (self.gameCamera.position.y - self.frame.height) {
            return true
        }
        return false
    }
    
    
    func setupTrunk(pos: CGPoint){
        
        let trunk = buildTrunk()
        trunk.node.position.y = lastTrunk.node.position.y + lastTrunk.node.frame.height
        trunk.node.position.x = lastTrunk.node.position.x
        self.addChild(trunk)
        trunk.attach(to: lastTrunk, on: self.physicsWorld)
        trunk.node.anchorPoint = .zero
        trunk.node.zRotation = 0.1 * (pos.y < frame.midX ? -1 : 1) + lastTrunk.node.zRotation
        trunk.node.anchorPoint = .init(x: 0.5, y: 0.5)
        lastTrunk = trunk
        
        trunkLoop.append(lastTrunk)
        
    }
    
    func setupBranch(pos: CGPoint) {
        
        let branch = buildBranch()
        branch.node.position.y = lastTrunk.node.position.y
        branch.node.position.x = (pos.x < frame.midX ? lastTrunk.node.position.x - branch.node.frame.width/2 : lastTrunk.node.position.x + branch.node.frame.width/2)
        self.addChild(branch)
        branch.attach(to: lastTrunk, on: self.physicsWorld)
        branchLoop.append(branch)
        
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
