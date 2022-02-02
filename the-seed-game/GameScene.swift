//
//  GameScene.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 28/01/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var firstTrunk: Trunk!
    var lastTrunk: Trunk!
    var lastBranch: Branch!
    var gameCamera: SKCameraNode!
    var treeNodesLoop: [SKSpriteNode] = []
    var background: Background!
    var sun: Sun!
    var walls: Walls!
    var scoreBoard: Scoreboard!
    var setupIntroCutscene: () -> Void = {}
    


    var gameOverOverlay: GameOverOverlay!
    var animationRunning: Bool = false
    
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
        setupSun()
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
    
    
    func setupScoreboard() {
        
        
    }
    
    func setupIntro() {
        
        // cria os elementos
        
        let bgNode = SKSpriteNode(imageNamed: "bgIntro")
        let groundNode = SKSpriteNode(imageNamed: "ground")
        let seedNode = SKSpriteNode(imageNamed: "seed")
        let titleNode = SKSpriteNode(imageNamed: "title")
        let subtitle = SKLabelNode(text: "Tap the seed to start")
        subtitle.fontSize = 20
        subtitle.fontColor = .black
        
        // posiciona e os elementos
        subtitle.position.y = self.frame.minY + 180
        subtitle.zPosition = 3
        groundNode.position.y = self.frame.minY + 10
        groundNode.zPosition = 5
        seedNode.position.y = self.frame.midY - 60
        seedNode.zPosition = 5
        titleNode.position.y = self.frame.midY + 40
        titleNode.zPosition = 4
        bgNode.position.y = self.frame.midY
        bgNode.zPosition = 0
       
        //adiciona os elementos na cena
        self.addChild(bgNode)
        self.addChild(groundNode)
        self.addChild(seedNode)
        self.addChild(titleNode)
        self.addChild(subtitle)
        
        // criação das animações
        let sunAnimation = SKAction.sequence([SKAction.scale(by: 1.05, duration: 1.5), SKAction.scale(by: 1/1.05, duration: 1.5)])
        sunAnimation.timingMode = .easeInEaseOut
        let seedAnimation = SKAction.sequence([SKAction.scale(by: 1.1, duration: 0.5), SKAction.scale(by: 1/1.1, duration: 0.5)])
        seedAnimation.timingMode = .easeInEaseOut
        // inicialização das animações
        sun.node.run(.repeatForever(sunAnimation))
        seedNode.run(.repeatForever(seedAnimation))
 
      self.setupIntroCutscene = {
          let subtitleAnimation = SKAction.fadeOut(withDuration: 0.8)
          
          self.sun.node.anchorPoint = .init(x: 0.5, y: 0.5)
          self.sun.node.position.y -= self.sun.node.size.height/2
                                            
          let sunAnimation = SKAction.move(to: CGPoint(x: 0.0, y: self.frame.maxY + 200), duration: 1.5)
            sunAnimation.timingMode = .easeInEaseOut
          let seedAction1 = SKAction.move(to: CGPoint(x: 0.0, y: groundNode.frame.midY), duration: 0.8)
          let seedAction2 = SKAction.scale(to: 0.1, duration: 0.8)
          seedAction1.timingMode = .easeIn
            
            subtitle.run(subtitleAnimation)
            self.sun.node.run(sunAnimation)
            titleNode.run(subtitleAnimation)
            seedNode.run(seedAction1)
            seedNode.run(seedAction2)
        }
   }
  func setupBackground() {
        
        let bgNode = Background.buildBackground(frame: self.frame)
        background = Background.init(node: bgNode)
        self.addChild(background)
   }
    
    func setupSun() {
        let sunNode = Sun.buildSun(frame: self.frame)
        sun = Sun.init(node: sunNode)
        sun.node.zPosition = 1
        
        sun.node.anchorPoint = .init(x: 0.5, y: 1)
        sun.node.position = CGPoint(x: 0, y: -20)
        self.addChild(sun)
    }
    
    func setupStartGame(){
        status = .playing
        //Remove elementos e animações da intro e da cutscene
        
        // Constroi as paredes
        let leftWall = Walls.buildLeftWall(frame: self.frame)
        let rightWall = Walls.buildRightWall(frame: self.frame)
        self.addChild(leftWall)
        self.addChild(rightWall)
        walls = Walls(rightWall: rightWall, leftWall: leftWall)
        walls.leftWall.physicsBody!.contactTestBitMask = walls.leftWall.physicsBody!.collisionBitMask
        walls.rightWall.physicsBody!.contactTestBitMask = walls.rightWall.physicsBody!.collisionBitMask
        // Constroi o primeiro tronco
        firstTrunk = Trunk.buildTrunk()
        firstTrunk.node.position.y = self.frame.minY
        firstTrunk.node.physicsBody?.isDynamic = false
        firstTrunk.node.zPosition = 2
       
        let firstTrunkAnimation = SKAction.move(to: CGPoint(x: 0, y: self.frame.minY + 80), duration: 0.5)
        firstTrunkAnimation.timingMode = .easeIn
        firstTrunk.node.run(.sequence([.wait(forDuration: 0.5), firstTrunkAnimation]))
        self.addChild(firstTrunk)
        lastTrunk = firstTrunk
        
        // Seta a posição o Scoreboard
        let scoreBoardLabel = Scoreboard.buildLabel()
        print((self.view?.safeAreaInsets.top)!)
        scoreBoardLabel.position = CGPoint(x: 0, y: self.frame.maxY - (self.view?.safeAreaInsets.top)! - 45)
        camera!.addChild(scoreBoardLabel)
        
        scoreBoard = Scoreboard(node: scoreBoardLabel)
        
        treeNodesLoop.append(firstTrunk.node)
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
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node == nil || contact.bodyB.node == nil {
            return
        }
        
        let bodyAName = contact.bodyA.node!.name!
        let bodyBName = contact.bodyB.node!.name!
        let collisionPos = contact.contactPoint
        
        let wallsCollision = checkWallsCollision(
            bodyAName: bodyAName,
            bodyBName: bodyBName
        )
        
        if wallsCollision && status != .gameOver {
            gameOver(collisionPos: collisionPos)
        }
    }
    
    func checkWallsCollision(bodyAName: String, bodyBName: String) -> Bool {
        if bodyAName == Walls.Names.leftWall || bodyBName == Walls.Names.leftWall {
            return true
        }
        
        if bodyAName == Walls.Names.rightWall || bodyBName == Walls.Names.rightWall {
            return true
        }
        
        return false
    }
    
    func gameOver(collisionPos: CGPoint) {
        if status == .gameOver {
            return
        }
        
        status = .gameOver
        setupGameOverOverlay(startsAnimationAt: collisionPos)
    }
    
    func setupGameOverOverlay(startsAnimationAt pos: CGPoint) {
        self.run(.sequence([
            .wait(forDuration: 0.5),
            .run({
                self.gameOverOverlay = GameOverOverlay(frame: self.frame)
                self.gameOverOverlay.node.position.y = self.gameCamera.position.y
                self.addChild(self.gameOverOverlay.node)
                
                self.gameOverOverlay.runOnAppearAnimation(
                    startPos: self.convert(pos, to: self.gameOverOverlay.node),
                    frame: self.frame
                )
            })
        ]))
    }
    
    func addScore() {
        
        Score.shared.score += 0.8
        scoreBoard.update()
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if animationRunning {
            return
        }
        switch status {
        case .intro:
            setupIntroCutscene()
            setupStartGame()
        case .playing:
            setupTrunk(pos: pos)
            setupBranch(pos: pos)
            setupLittleBranch(pos: pos)
            addScore()
            
            if lastTrunk.node.position.y > self.frame.midY {
                let action = SKAction.move(to: CGPoint(x: 0, y: lastTrunk.node.position.y + 200), duration: 0.4)
                action.timingMode = .easeOut
                self.gameCamera?.run(action)
                
                self.sun.moveWithAnimation(to: CGPoint(x: 0, y: lastTrunk.node.position.y + 400 + self.frame.height/2))
            }
            walls.updatePosition(to: lastTrunk.node.position)
            discardUselessElements()
            
        case .paused:
            break
            
        case .gameOver:
            break
//            gameOverOverlay.onTap()
        }
    }
    
//     Funcao que cria um novo tronco vertical eposiciona na tela
    
    func setupTrunk(pos: CGPoint){
        
        let trunk = Trunk.buildTrunk()
        trunk.node.position.y = lastTrunk.node.position.y + lastTrunk.node.frame.height - 5
        trunk.node.position.x = lastTrunk.node.position.x
        self.addChild(trunk)
        trunk.attach(to: lastTrunk, on: self.physicsWorld)
        trunk.node.anchorPoint = .zero
        // trunk.node.zRotation = 0.1 * (pos.y < frame.midX ? -1 : 1) + lastTrunk.node.zRotation
        trunk.node.anchorPoint = .init(x: 0.5, y: 0.5)
        lastTrunk = trunk
        treeNodesLoop.append(lastTrunk.node)
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
        treeNodesLoop.append(branch.node)
    }
    
    func setupLittleBranch(pos: CGPoint){
        let littleBranch = LittleBranch.buildLittleBranch()
        littleBranch.node.position.y = lastTrunk.node.position.y
        littleBranch.node.position.x = (pos.x < frame.midX ? lastTrunk.node.position.x + littleBranch.node.frame.width/2 : lastTrunk.node.position.x - littleBranch.node.frame.width/2)
        littleBranch.node.anchorPoint = .init(x: 0.5, y: 0.5)
        littleBranch.node.zRotation = (pos.x < frame.midX ? (0.33) : (-0.33))
        self.addChild(littleBranch)
        littleBranch.attach(to: lastTrunk, on: self.physicsWorld)
        treeNodesLoop.append(littleBranch.node)
    }
    
    func discardUselessElements() {
        var indexToRemove: Int = -1
        for i in 0..<treeNodesLoop.count {
            if checkUselessElement(treeNodesLoop[i]) {
                treeNodesLoop[i].physicsBody?.isDynamic = false
                indexToRemove = i
            }
        }
        
        if indexToRemove != -1 {
            for _ in 0...indexToRemove {
                treeNodesLoop.removeFirst()
            }
        }
    }
    
    func checkUselessElement(_ element: SKSpriteNode) -> Bool {
        if element.position.y < (self.gameCamera.position.y - self.frame.height - 20 ) {
            return true
        }
        return false
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
        sun.update(cameraPos: gameCamera.position)
    }
}


