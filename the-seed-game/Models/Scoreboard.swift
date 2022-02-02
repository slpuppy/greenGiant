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
        
        labelScore = Score.shared.score
        let scoreString = String(format: "%.1f", labelScore)
        node.text = "\(scoreString)m"
        
        
    }
    

}
