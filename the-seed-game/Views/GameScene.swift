//
//  GameScene.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 28/01/22.
//

import SpriteKit
import GameplayKit
import GameKit

protocol GameSceneDelegate: AnyObject {
    func leaderboardTapped()
    func updateLeaderboardScore()
    func dismissMenuView()
    func setupMenuBar()
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    weak var gameSceneDelegate: GameSceneDelegate?
    var gameInstructions: GameInstructions!
    var firstTrunk: Trunk!
    var lastTrunk: Trunk!
    var lastBranch: Branch!
    var gameCamera: GameCamera!
    var treeNodesLoop: [SKSpriteNode] = []
    var background: Background!
    var sun: Sun!
    var walls: Walls!
    var scoreBoard: Scoreboard!
    var intro: Intro!
    var gameOverOverlay: GameOverOverlay!
    var animationRunning: Bool = false
    var status: GameStatus = .intro
    var lastUpdate: TimeInterval = 0
    
    var difficultyManager: DifficultyManager!
    
    var gameCameraMovementVelocity: CGFloat = 60
    var playerCanPlay: Bool = true
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        //#if DEBUG
        //       view.showsPhysics = true
        //       view.showsNodeCount = true
        //       view.showsFPS = true
        //       //        self.speed = -50
        //#endif
        
        setupScene(view: view)
        setupCamera()
        setupBackgrounds()
        setupSun()
        setupDifficultyManager()
        setupIntro()
        runIntroStartAnimation()
    }
    
    // Prepara a cena
    func setupScene(view: SKView) {
        self.size = view.frame.size
        self.backgroundColor = UIColor(named: "backgroundColor") ?? .white
        self.anchorPoint = .init(x: 0.5, y: 0.5)
    }
    
    func setupDifficultyManager() {
        difficultyManager = DifficultyManager(frame: self.frame)
    }
    
    // Prepara a camera
    func setupCamera() {
        gameCamera = GameCamera()
        self.camera = gameCamera.node
        self.addChild(gameCamera)
    }
    
    // Prepara os backgrounds do jogo
    func setupBackgrounds() {
        setupBeginingBackground()
        setupBackground()
    }
    
    func setupBeginingBackground() {
        let backgroundIntro = SKSpriteNode(imageNamed: "bgIntro")
        backgroundIntro.position.y = self.frame.midY
        backgroundIntro.zPosition = 0
        self.addChild(backgroundIntro)
    }
    
    func setupBackground() {
        let bgNode = Background.buildBackground(frame: self.frame)
        background = Background.init(node: bgNode)
        self.addChild(background)
    }
    
    // Prepara o sol do jogo
    func setupSun() {
        let sunNode = Sun.buildSun(frame: self.frame)
        sun = Sun.init(node: sunNode)
        sun.node.zPosition = 1
        
        sun.node.anchorPoint = .init(x: 0.5, y: 1)
        sun.node.position = CGPoint(x: 0, y: -20)
        gameCamera.node.addChild(sun.node)
    }
    
    // Prepara a cena de introdução do jogo
    func setupIntro() {
        intro = Intro(frame: self.frame)
        self.addChild(intro)
        
    }
    
    // Roda as animações do começo do jogo
    func runIntroStartAnimation() {
        intro.runStartAnimation()
        sun.runIntroStartAnimation()
    }
    
    func touchDown(atPoint pos : CGPoint) {
        GameCrashlytics.shared.logTap(at: pos, at: lastUpdate)
        
        if animationRunning {
            GameAnalytics.shared.logTappedWhenAnimationWasRunning(at: pos, gameState: status)
            return
        }
        
        switch status {
        case .intro:
            runIntroCutsceneAnimation()
            setupStartGame()
            gameSceneDelegate?.setupMenuBar()
        case .playing:
            if self.scene?.isPaused != true {
                if !playerCanPlay {
                    break
                }
                
                removeGameInstructions()
                modifyDifficulty(pressedIn: pos)
                setupTrunk(pos: pos)
                setupBranch(pos: pos)
                setupLittleBranch(pos: pos)
                addScore()
                discardUselessElements()
                startGameCameraMovement()
            }
            
        case .paused:
            break
            
        case .gameOver:
            if gameOverOverlay.leaderboardsLabel.contains(pos) {
                gameSceneDelegate?.leaderboardTapped()
                return
            }
            
            if gameOverOverlay.playAgainLabel.contains(pos) {
                gameOverOverlay.onTapPlayAgain()
                resetGame()
            }
        }
    }
    
    func runIntroCutsceneAnimation() {
        intro.runCutsceneAnimation()
        
        sun.node.anchorPoint = .init(x: 0.5, y: 0.5)
        sun.node.position.y -= sun.node.size.height/2
        sun.runIntroCutsceneAnimation(frame: self.frame)
    }
    
    func setupStartGame(){
        status = .playing
        //Remove elementos e animações da intro e da cutscene
        
        // Constroi as paredes
        let leftWall = Walls.buildLeftWall(frame: self.frame)
        let rightWall = Walls.buildRightWall(frame: self.frame)
        gameCamera.node.addChild(leftWall)
        gameCamera.node.addChild(rightWall)
        walls = Walls(rightWall: rightWall, leftWall: leftWall)
        
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
        
        // Setup da label e icons das instrucoes do game
        setupGameInstructions()
        
        // Seta a posição o Scoreboard
        let scoreBoardLabel = Scoreboard.buildLabel()
        scoreBoardLabel.position = CGPoint(x: 0, y: self.frame.maxY - (self.view?.safeAreaInsets.top)! - 45)
        gameCamera.node.addChild(scoreBoardLabel)
        
        scoreBoard = Scoreboard(node: scoreBoardLabel)
        
        treeNodesLoop.append(firstTrunk.node)
    }
    
    func setupGameInstructions() {
        gameInstructions = GameInstructions(frame: self.frame)
        self.addChild(gameInstructions)
        
        // Animações das instruções
        gameInstructions.runAnimations()
    }
    
    func removeGameInstructions() {
        gameInstructions.node.run(.sequence([
            .fadeOut(withDuration: 1),
            .run {
                self.gameInstructions.node.removeFromParent()
            }
        ]))
    }
    
    func addScore() {
        if Score.shared.score.truncatingRemainder(dividingBy: 5) + 1.2 >= 5 {
            gameCameraMovementVelocity += 7
        }
        Score.shared.score += 1.2
        scoreBoard.update()
    }
    
    func decreaseScore(by value: Double) {
        Score.shared.score -= value
        scoreBoard.update()
    }
    
    func modifyDifficulty(pressedIn pos: CGPoint) {
        difficultyManager.gameScreenTapped(in: pos, at: lastUpdate)
    }
    
    // Funcao que cria um novo tronco vertical eposiciona na tela
    func setupTrunk(pos: CGPoint) {
        let trunk = Trunk.buildTrunk()
        trunk.node.zRotation = 0.01 * (getHorizontalScreenSide(in: pos) == .right ? -1 : 1)
        trunk.node.zRotation *= difficultyManager.trunkZRotationMultiplier
        
        let currentTrunkBottomRefPosition = self.convert(
            trunk.bottomRefNode.position,
            from: trunk.node
        )
        let currentTrunkCenterPosition = trunk.node.position
        let currentTrunkCenterOffset = currentTrunkCenterPosition - currentTrunkBottomRefPosition
        let previousTrunkTopRefPosition = self.convert(
            lastTrunk.topRefNode.position,
            from: lastTrunk.node
        )
        let newPosition = previousTrunkTopRefPosition + currentTrunkCenterOffset
        // posiciona novo tronco com centro em topo do anterior mais a diferenca acima
        
        trunk.node.position = newPosition
        
        self.addChild(trunk)
        trunk.attach(to: lastTrunk, on: self.physicsWorld)
        
        lastTrunk = trunk
        treeNodesLoop.append(lastTrunk.node)
    }
    
    // Funcao que cria um novo galho horizontal eposiciona na tela
    func setupBranch(pos: CGPoint) {
        
        let branch = Branch.buildBranch()
        
        branch.node.physicsBody?.mass *= difficultyManager.branchWeightMultiplier
        branch.node.physicsBody?.mass *= CGFloat.random(in: 1...4)
        branch.node.position.y = lastTrunk.node.position.y + lastTrunk.node.frame.height/2 - 15
        branch.node.anchorPoint = .init(x: 0.5, y: 0.5)
        
        switch getHorizontalScreenSide(in: pos) {
        case .left:
            branch.node.position.x = lastTrunk.node.position.x - branch.node.frame.width/2
            branch.node.zRotation = -0.33
        case .right:
            branch.node.position.x = lastTrunk.node.position.x + branch.node.frame.width/2
            branch.node.zRotation = 0.33
        }
        
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
    
    func getHorizontalScreenSide(in pos: CGPoint) -> HorizontalScreenSide {
        if pos.x > self.frame.midX {
            return .right
        }
        
        return .left
    }
    
    func startGameCameraMovement() {
        gameCamera.node.removeAllActions()
        gameCamera.startGameCameraMovement(velocity: gameCameraMovementVelocity)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node == nil || contact.bodyB.node == nil {
            return
        }
        
        let bodyAName = contact.bodyA.node!.name!
        let bodyBName = contact.bodyB.node!.name!
        let collisionPos = contact.contactPoint
        
        let isWallsCollision = checkWallsCollision(
            bodyAName: bodyAName,
            bodyBName: bodyBName
        )
        
        if isWallsCollision && status != .gameOver {
            GameAnalytics.shared.logGameOver(cause: .wallCrash)
            
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
        
        animationRunning = true
        
        gameSceneDelegate?.dismissMenuView()
        gameSceneDelegate?.updateLeaderboardScore()
        status = .gameOver
        showGameOverOverlay(startsAnimationAt: collisionPos, labelsAppearDelay: 3)
        resetCameraPosition(delay: 1)
        removeTreeWithAnimation(delay: 4)
        
        self.run(.sequence([
            .wait(forDuration: 6),
            .run {
                self.animationRunning = false
            }
        ]))
    }
    
    func showGameOverOverlay(
        startsAnimationAt pos: CGPoint,
        labelsAppearDelay delay: TimeInterval
    ) {
        gameOverOverlay = GameOverOverlay(frame: self.frame)
        gameCamera.node.addChild(gameOverOverlay.node)
        
        gameOverOverlay.runOnAppearAnimation(
            startPos: convert(pos, to: gameOverOverlay.node),
            frame: self.frame,
            labelsAppearDelay: 4
        )
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
        if element.position.y < (self.gameCamera.node.position.y - self.frame.height+100) {
            return true
        }
        return false
    }
    
    func resetGame() {
        gameCameraMovementVelocity = 60
        intro.removeIntro()
        walls.removeWalls()
        scoreBoard.removeScoreBoard()
        sun.removeSun()
        Score.shared.resetScore()
        
        setupIntro()
        setupSun()
        runIntroStartAnimation()
        status = .intro
    }
    
    func resetCameraPosition(delay: TimeInterval) {
        gameCamera.node.removeAllActions()
        gameCamera.resetPositionWithAnimation(
            to: CGPoint(x: self.frame.midX, y: self.frame.midY),
            delay: delay
        )
    }
    
    func removeTreeWithAnimation(delay: TimeInterval) {
        let allChildNodes = self.children
        var allTreeNodes: [SKNode] = []
        
        let fadeOutAnimation: SKAction = .fadeOut(withDuration: 2)
        fadeOutAnimation.timingMode = .easeOut
        
        for childNode in allChildNodes.reversed() {
            if checkIfHasTreeElementName(node: childNode) {
                childNode.run(.sequence([
                    .wait(forDuration: delay),
                    fadeOutAnimation
                ]))
                
                allTreeNodes.append(childNode)
            }
        }
        
        allTreeNodes.forEach { treeNode in
            treeNode.run(.sequence([
                .wait(forDuration: delay + 2.1),
                .run {
                    treeNode.removeFromParent()
                }
            ]))
        }
    }
    
    func checkIfHasTreeElementName(node: SKNode) -> Bool {
        let possibleNames = [
            Trunk.Names.trunk,
            LittleBranch.Names.littleBranch,
            Branch.Names.branch
        ]
        
        for name in possibleNames {
            if node.name == name {
                return true
            }
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
        if lastUpdate == 0 {
            lastUpdate = currentTime
            return
        }
        
        GameCrashlytics.shared.updateKeysValues(gameState: status)
        
        if status == .playing && checkIfTreeIsBelowCamera() {
            GameAnalytics.shared.logGameOver(cause: .bottomOverlaps)
            
            let bottomPosition = self.convert(lastTrunk.topRefNode.position, from: lastTrunk.node)
            gameOver(collisionPos: bottomPosition)
            return
        }
        
        if status == .playing && Score.shared.score > 0 && checkIfReachedSun() {
            reachedSunPenality()
        }

        if status == .playing && !playerCanPlay && checkIfCanRemoveSunPenality() {
            removeSunPenality()
        }
        
        lastUpdate = currentTime
        
        if status == .gameOver {
            background.updateBackwards(
                cameraPos: gameCamera.node.position,
                frame: self.frame
            )
            
            return
        }
        
        background.update(cameraPos: gameCamera.node.position)
    }
    
    func checkIfTreeIsBelowCamera() -> Bool {
        let topPositionY = self.convert(lastTrunk.topRefNode.position, from: lastTrunk.node).y
        let cameraBottomPositionY = gameCamera.node.position.y - self.frame.height/2
        
        return topPositionY < cameraBottomPositionY
    }
    
    func checkIfReachedSun() -> Bool {
        let topPositionSceneCoordinates = self.convert(
            lastTrunk.topRefNode.position,
            from: lastTrunk.node
        )
        let topPositionCameraCoordinates = gameCamera.node.convert(
            topPositionSceneCoordinates,
            from: self
        )
        
        return sun.node.contains(topPositionCameraCoordinates)
    }
    
    func checkIfCanRemoveSunPenality() -> Bool {
        let trunkTopPosition = self.convert(lastTrunk.topRefNode.position, from: lastTrunk.node)
        
        return trunkTopPosition.y <= gameCamera.node.position.y
    }
    
    func reachedSunPenality() {
        if !playerCanPlay {
            return
        }
        
        decreaseScore(by: 3.6)
        playerCanPlay = false
    }
    
    func removeSunPenality() {
        playerCanPlay = true
    }
}


