//
//  Intro.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 02/02/22.
//

import SpriteKit

class Intro {
    let node: SKNode
    let ground: SKSpriteNode
    let seed: SKSpriteNode
    let title: SKSpriteNode
    let subtitle: SKLabelNode
    let upBranch: Branch
    
    init(frame: CGRect) {
        // criação dos elementos
        self.node = SKNode()
        self.ground = Intro.buildGround(from: frame)
        self.seed = Intro.buildSeed(from: frame)
        self.title = Intro.buildTitle(from: frame)
        self.subtitle = Intro.buildSubtitle(from: frame)
        self.upBranch = Intro.buildBranch()
        
        addChildsToNode()
    }
    
    func runStartAnimation() {
        runSeedAnimation()
    }
    
    func runCutsceneAnimation() {
        runSeedCutsceneAnimation()
        runTitleCutsceneAnimation()
        runSubtitleCutsceneAnimation()
        runUpBranchCutsceneAnimation()
    }
    
    func removeIntro() {
        self.node.removeFromParent()
    }
    
    
    static private func buildGround(from frame: CGRect) -> SKSpriteNode {
        let groundNode = SKSpriteNode(imageNamed: "ground")
        
        // posicionamento
        groundNode.position.y = frame.minY + 10
        groundNode.zPosition = 5
        
        return groundNode
    }
    
    static private func buildSeed(from frame: CGRect) -> SKSpriteNode {
        let seedNode = SKSpriteNode(imageNamed: "seed")
        
        // posicionamento
        seedNode.position.y = frame.midY - 80
        seedNode.zPosition = 5
        
        return seedNode
    }
    
    static private func buildTitle(from frame: CGRect) -> SKSpriteNode {
        let titleNode = SKSpriteNode(imageNamed: "title")
        
        // posicionamento
        titleNode.position.y = frame.midY + 40
        titleNode.zPosition = 4
        
        return titleNode
    }
    
    static private func buildSubtitle(from frame: CGRect) -> SKLabelNode {
        let subtitleNode = SKLabelNode(text: "Tap the seed to start")
        subtitleNode.fontSize = 20
        subtitleNode.fontColor = .black
        
        // posicionamento
        subtitleNode.position.y = frame.minY + 180
        subtitleNode.zPosition = 3
        
        return subtitleNode
    }
    
    static private func buildBranch() -> Branch {
        let branch = Branch.buildBranch()
        let scaleMultiplier = 3.0
        branch.node.zPosition = 3
        branch.node.scale(to: CGSize(width: (branch.node.size.width * scaleMultiplier), height: (branch.node.size.height * scaleMultiplier)))
        branch.node.position.y = 180
        branch.node.physicsBody = nil
        return branch
    }
    
    private func addChildsToNode() {
        self.node.addChild(self.ground)
        self.node.addChild(self.seed)
        self.node.addChild(self.title)
        self.node.addChild(self.subtitle)
        self.node.addChild(self.upBranch.node)
    }
    
    private func runUpBranchCutsceneAnimation() {
        let upBranchAnimation = SKAction.fadeOut(withDuration: 0.8)
        upBranch.node.run(upBranchAnimation)
   }
    
    private func runSeedAnimation() {
        let seedAnimation = SKAction.sequence([.scale(by: 1.1, duration: 0.5), .scale(by: 1/1.1, duration: 0.5)])
        seedAnimation.timingMode = .easeInEaseOut
        
        seed.run(.repeatForever(seedAnimation))
    }

    private func runSeedCutsceneAnimation() {
        let seedAction1 = SKAction.move(
            to: CGPoint(x: 0.0, y: ground.frame.midY),
            duration: 0.8
        )
        let seedAction2 = SKAction.scale(to: 0.1, duration: 0.8)
        seedAction1.timingMode = .easeIn
        
        seed.run(.group([
            seedAction1,
            seedAction2
        ]))
    }
    
    private func runTitleCutsceneAnimation() {
        let titleAnimation = SKAction.fadeOut(withDuration: 0.8)
        
        title.run(titleAnimation)
    }
    
    private func runSubtitleCutsceneAnimation() {
        let subtitleAnimation = SKAction.fadeOut(withDuration: 0.8)
        
        subtitle.run(subtitleAnimation)
    }
}
