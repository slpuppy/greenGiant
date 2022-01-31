//
//  GameOver.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 29/01/22.
//

import SpriteKit

class GameOverOverlay {
    let node: SKNode
    let background: SKSpriteNode
    let label: SKLabelNode
    
    init(frame: CGRect) {
        self.background = GameOverOverlay.buildBackground(from: frame)
        self.label = GameOverOverlay.buildLabel()
        
        self.node = SKNode()
        self.node.zPosition = 100
        
        
        self.node.addChild(self.background)
        self.node.addChild(self.label)
    }
    
    func onTap() {
        let animationSequence: [SKAction] = [
            .fadeOut(withDuration: 0.5),
            .run {
                self.node.removeFromParent()
            }
        ]
        self.node.run(.sequence(animationSequence))
    }
    
    static private func buildBackground(from frame: CGRect) -> SKSpriteNode {
        let overlay = SKSpriteNode(color: .black, size: frame.size)
        overlay.alpha = 0
        
        return overlay
    }
    
    static private func buildLabel() -> SKLabelNode {
        let labelNode = SKLabelNode(text: "Tap to restart")
        labelNode.fontColor = .white
        labelNode.fontName = UIFont.boldSystemFont(ofSize: 21).fontName
        
        return labelNode
    }
}
