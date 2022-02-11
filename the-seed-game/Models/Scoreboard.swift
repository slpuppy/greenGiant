//
//  Scoreboard.swift
//  the-seed-game
//
//  Created by Gabriel Puppi on 01/02/22.
//

import SpriteKit

class Scoreboard {
   
    let node: SKLabelNode
    var labelScore: Double = 0.0
    
    init(node: SKLabelNode) {
        self.node = node
    }
    
    static func buildLabel() -> SKLabelNode {
        
        let scoreBoard = SKLabelNode(text: "0m")
        scoreBoard.fontSize = 36
        scoreBoard.zPosition = 4
        scoreBoard.fontColor = UIColor(named: "scoreColor")
        scoreBoard.fontName = "HelveticaNeue-Bold"
        
        
        
        return scoreBoard
    }
    
    func removeScoreBoard() {
        self.node.removeFromParent()
    }
    
    func update() {
        self.node.removeAllActions()
        
        let isIncreasing = Score.shared.score > labelScore
        
        var animationSequence: [SKAction]
        
        if isIncreasing {
            animationSequence = getIncreasingAnimationSequence()
        } else {
            animationSequence = getDecreasingAnimationSequence()
        }
        
        self.node.run(.sequence(animationSequence))
    }
    
    private func getIncreasingAnimationSequence() -> [SKAction] {
        var animationSequence: [SKAction] = []
        
        var auxScore = labelScore
        
        while auxScore < Score.shared.score {
            animationSequence.append(.run {
                self.labelScore += 0.1
                let scoreString = String(format: "%.1f", self.labelScore)
                self.node.text = "\(scoreString)m"
            })
            animationSequence.append(.wait(forDuration: 0.02))
            
            auxScore += 0.1
        }
        
        animationSequence.append(.run {
            self.labelScore = Score.shared.score
            let scoreString = String(format: "%.1f", self.labelScore)
            self.node.text = "\(scoreString)m"
        })
        
        return animationSequence
    }
    
    private func getDecreasingAnimationSequence() -> [SKAction] {
        var animationSequence: [SKAction] = []
        
        var auxScore = labelScore
        
        while auxScore > Score.shared.score {
            animationSequence.append(.run {
                self.labelScore -= 0.1
                let scoreString = String(format: "%.1f", self.labelScore)
                self.node.text = "\(scoreString)m"
            })
            animationSequence.append(.wait(forDuration: 0.03))
            
            auxScore -= 0.1
        }
        
        animationSequence.append(.run {
            self.labelScore = Score.shared.score
            let scoreString = String(format: "%.1f", self.labelScore)
            self.node.text = "\(scoreString)m"
        })
        
        return animationSequence
    }
}
