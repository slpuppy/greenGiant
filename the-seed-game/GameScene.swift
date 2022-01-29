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
    var trunkLoop: [Trunk] = []
    var branchLoop: [Branch] = []
    var background: Background!
    var walls: Walls!
    
    override func didMove(to view: SKView) {
        
#if DEBUG
        view.showsPhysics = true
        view.showsNodeCount = true
        view.showsFPS = true
        //        self.speed = -50
#endif
        
        setupScene(view: view)
        
        // Constroi o background
        let bgNode = Background.buildBackground(frame: self.frame)
        background = Background.init(node: bgNode)
        self.addChild(background)
        
        
        // Constroi as paredes
        let leftWall = Walls.buildLeftWall(frame: self.frame)
        let rightWall = Walls.buildRightWall(frame: self.frame)
        self.addChild(leftWall)
        self.addChild(rightWall)
        walls = Walls(rightWall: rightWall, leftWall: leftWall)
        
        // Constroi o primeiro tronco
        let firstTrunk = Trunk.buildTrunk()
        firstTrunk.node.position.y = self.frame.minY + firstTrunk.node.frame.size.height/2
        firstTrunk.node.physicsBody?.isDynamic = false
        firstTrunk.node.zPosition = 1
        self.addChild(firstTrunk)
        lastTrunk = firstTrunk
        trunkLoop.append(firstTrunk)
    }
    
    func setupScene(view: SKView) {
        self.size = view.frame.size
        self.backgroundColor = .clear
        self.anchorPoint = .init(x: 0.5, y: 0.5)
        let camera = SKCameraNode()
        self.gameCamera = camera
        self.camera = camera
        self.addChild(camera)
    }
    
  func touchDown(atPoint pos : CGPoint) {
        
        setupBranch(pos: pos)
        setupTrunk(pos: pos)
        if lastTrunk.node.position.y > self.frame.midY {
            
            self.gameCamera?.run(.move(to: CGPoint(x: 0, y: lastTrunk.node.position.y), duration: 0.2))
        }
        
        walls.updatePosition(to: lastTrunk.node.position)
        discardUselessElements()
    }
    
    func discardUselessElements() {
        discardUselessTrunks()
        discardUselessBranches()
        
    }
    
    func checkUselessElement(_ element: SKSpriteNode) -> Bool {
        if element.position.y < (self.gameCamera.position.y - self.frame.height/2) {
            return true
        }
        return false
    }
    
    func discardUselessTrunks() {
        var indexToRemove: Int = -1
        for i in 0..<trunkLoop.count {
            if checkUselessElement(trunkLoop[i].node){
                trunkLoop[i+1].node.physicsBody?.isDynamic = false
                trunkLoop[i].node.removeFromParent()
                
                
                indexToRemove = i
            }
        }
        if indexToRemove != -1 {
            
            for _ in 0...indexToRemove {
                trunkLoop.removeFirst()
            }
        }
    }
    
    func discardUselessBranches() {
        var indexToRemove: Int = -1
        for i in 0..<branchLoop.count {
            if checkUselessElement(branchLoop[i].node){
                branchLoop[i+1].node.physicsBody?.isDynamic = false
                branchLoop[i].node.removeFromParent()
                indexToRemove = i
            }
        }
        if indexToRemove != -1 {
            for _ in 0...indexToRemove {
                branchLoop.removeFirst()
            }
        }
    }
    
  func setupTrunk(pos: CGPoint){
        
        let trunk = Trunk.buildTrunk()
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
        
        let branch = Branch.buildBranch()
        branch.node.position.y = lastTrunk.node.position.y + lastTrunk.node.frame.height/2
        branch.node.position.x = (pos.x < frame.midX ? lastTrunk.node.position.x - branch.node.frame.width/2 : lastTrunk.node.position.x + branch.node.frame.width/2)
        branch.node.anchorPoint = .init(x: 0.5, y: 0.5)
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
        background.update(cameraPos: gameCamera.position)
    }
}
