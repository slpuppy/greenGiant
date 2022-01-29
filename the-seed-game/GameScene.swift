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
    var littleBranchLoop:[LittleBranch] = []
    var background: Background!
    var walls: Walls!

    var status: GameStatus = .intro
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
     
#if DEBUG
        view.showsPhysics = true
        view.showsNodeCount = true
        view.showsFPS = true
        //        self.speed = -50
#endif
        
        setupScene(view: view)
        setupBackground()
        self.backgroundColor = .white
        
        switch status {
        case .intro:
            setupIntro()
        case .playing:
           
            setupStartGame()
            
        case .paused:
            break
        case .gameOver:
            break
        }
  
    }
  
    func setupIntro() {
        let groundNode = SKSpriteNode(imageNamed: "ground")
        groundNode.position.y = self.frame.minY
        
        let seedNode = SKSpriteNode(imageNamed: "seed")
        seedNode.position.y = self.frame.midY - 20
        
        self.addChild(groundNode)
        self.addChild(seedNode)
   }
    
   func setupBackground() {
        
        let bgNode = Background.buildBackground(frame: self.frame)
        background = Background.init(node: bgNode)
        self.addChild(background)
        
    }
    
    func setupStartGame(){
        
        // Constroi o background
        
       // Constroi as paredes
        let leftWall = Walls.buildLeftWall(frame: self.frame)
        let rightWall = Walls.buildRightWall(frame: self.frame)
        self.addChild(leftWall)
        self.addChild(rightWall)
        walls = Walls(rightWall: rightWall, leftWall: leftWall)
        walls.leftWall.physicsBody!.contactTestBitMask = walls.leftWall.physicsBody!.collisionBitMask
        walls.rightWall.physicsBody!.contactTestBitMask = walls.rightWall.physicsBody!.collisionBitMask
        // Constroi o primeiro tronco
        let firstTrunk = Trunk.buildTrunk()
        firstTrunk.node.position.y = self.frame.minY + firstTrunk.node.frame.size.height/2
        firstTrunk.node.physicsBody?.isDynamic = false
        firstTrunk.node.zPosition = 1
        self.addChild(firstTrunk)
        lastTrunk = firstTrunk
        trunkLoop.append(firstTrunk)
    }
    
    // Inicia a cena e prepara a camera
    
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
        
      switch status {
      case .intro:
          break
      case .playing:
          setupTrunk(pos: pos)
          setupBranch(pos: pos)
          setupLittleBranch(pos: pos)
          
          if lastTrunk.node.position.y > self.frame.midY {
              let action = SKAction.move(to: CGPoint(x: 0, y: lastTrunk.node.position.y), duration: 0.3)
              action.timingMode = .easeOut
              self.gameCamera?.run(action)
          }
          walls.updatePosition(to: lastTrunk.node.position)
          discardUselessElements()
      
      case .paused:
          break
      
      case .gameOver:
          break
      }
    }
    
// Funcao que cria um novo tronco vertical eposiciona na tela
    
    func setupTrunk(pos: CGPoint){
          
          let trunk = Trunk.buildTrunk()
          trunk.node.position.y = lastTrunk.node.position.y + lastTrunk.node.frame.height
          trunk.node.position.x = lastTrunk.node.position.x
          self.addChild(trunk)
          trunk.attach(to: lastTrunk, on: self.physicsWorld)
          trunk.node.anchorPoint = .zero
         // trunk.node.zRotation = 0.1 * (pos.y < frame.midX ? -1 : 1) + lastTrunk.node.zRotation
          trunk.node.anchorPoint = .init(x: 0.5, y: 0.5)
          lastTrunk = trunk
          trunkLoop.append(lastTrunk)
     }
    
    // Funcao que cria um novo galho horizontal eposiciona na tela
      
      func setupBranch(pos: CGPoint) {
          
          let branch = Branch.buildBranch()
          branch.node.position.y = lastTrunk.node.position.y + lastTrunk.node.frame.height/2
          branch.node.position.x = (pos.x < frame.midX ? lastTrunk.node.position.x - branch.node.frame.width/2 : lastTrunk.node.position.x + branch.node.frame.width/2)
          branch.node.anchorPoint = .init(x: 0.5, y: 0.5)
          branch.node.zRotation = (pos.x < frame.midX ? (-0.33) : (0.33))
          self.addChild(branch)
          branch.attach(to: lastTrunk, on: self.physicsWorld)
          branchLoop.append(branch)
     }
    
    func setupLittleBranch(pos: CGPoint){
        let littleBranch = LittleBranch.buildLittleBranch()
        littleBranch.node.position.y = lastTrunk.node.position.y
        littleBranch.node.position.x = (pos.x < frame.midX ? lastTrunk.node.position.x + littleBranch.node.frame.width/2 : lastTrunk.node.position.x - littleBranch.node.frame.width/2)
        littleBranch.node.anchorPoint = .init(x: 0.5, y: 0.5)
        littleBranch.node.zRotation = (pos.x < frame.midX ? (0.33) : (-0.33))
        self.addChild(littleBranch)
        littleBranch.attach(to: lastTrunk, on: self.physicsWorld)
        littleBranchLoop.append(littleBranch)
        
    }
    
    
    
  func discardUselessElements() {
        discardUselessTrunks()
        discardUselessBranches()
        discardUselessLittleBranches()
   }
    
    func checkUselessElement(_ element: SKSpriteNode) -> Bool {
        if element.position.y < (self.gameCamera.position.y - self.frame.height*0.75) {
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
    
    func discardUselessLittleBranches() {
        var indexToRemove: Int = -1
        for i in 0..<littleBranchLoop.count {
            if checkUselessElement(littleBranchLoop[i].node){
                littleBranchLoop[i+1].node.physicsBody?.isDynamic = false
                littleBranchLoop[i].node.removeFromParent()
                indexToRemove = i
            }
        }
        if indexToRemove != -1 {
            for _ in 0...indexToRemove {
                littleBranchLoop.removeFirst()
            }
        }
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
