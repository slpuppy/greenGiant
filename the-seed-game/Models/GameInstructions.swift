//
//  GameInstructions.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 05/02/22.
//

import SpriteKit

class GameInstructions {
    let node: SKNode
    let label: SKLabelNode
    let leftIcon: SKShapeNode
    let rightIcon: SKShapeNode
    
    init(frame: CGRect) {
        self.node = SKNode()
        
        self.label = GameInstructions.buildLabel(frame: frame)
        self.leftIcon = GameInstructions.buildLeftIcon(frame: frame)
        self.rightIcon = GameInstructions.buildRightIcon(frame: frame)
        
        addNodesToNode()
    }
    
    func runAnimations() {
        runLabelAnimations()
        runLeftIconAnimations()
        runRightIconAnimations()
    }
    
    private func runLabelAnimations() {
        let labelAnimation = SKAction.fadeIn(withDuration: 0.8)
        self.label.run(labelAnimation)
    }
    
    private func runLeftIconAnimations() {
        let leftIconAnimationSequence = SKAction.sequence([
            .group([
                .scale(to: 1, duration: 0.5),
                .fadeIn(withDuration: 0.5)
            ]),
            .fadeOut(withDuration: 0.5),
            .group([
                .wait(forDuration: 0.1),
                .scale(to: 0, duration: 0.1),
            ]),
            .wait(forDuration: 0.5)
        ])
        
        self.leftIcon.run(.repeatForever(leftIconAnimationSequence))
    }
    
    private func runRightIconAnimations() {
        let rightIconAnimationSequence = SKAction.sequence([
            .wait(forDuration: 0.5),
            .group([
                .scale(to: 1, duration: 0.4),
                .fadeIn(withDuration: 0.5)
            ]),
            .fadeOut(withDuration: 0.5),
            .group([
                .wait(forDuration: 0.1),
                .scale(to: 0, duration: 0.1)
            ])
        ])
        
        self.rightIcon.run(.repeatForever(rightIconAnimationSequence))
    }
    
    private static func buildLabel(frame: CGRect) -> SKLabelNode {
        let labelNode = SKLabelNode(text: "Tap right or left to grow")
        labelNode.fontSize = 18
        labelNode.fontName = "HelveticaNeue"
        labelNode.position = CGPoint(x: 0, y: frame.minY + 45)
        labelNode.fontColor = UIColor(named: "backgroundColor")
        labelNode.zPosition = 5
        
        return labelNode
    }
    
    private static func buildLeftIcon(frame: CGRect) -> SKShapeNode {
        let leftIconNode = SKShapeNode(circleOfRadius: 20)
        leftIconNode.fillColor = UIColor(named: "backgroundColor")!
        leftIconNode.position = CGPoint(x: frame.minX + 40, y: frame.minY + 50)
        leftIconNode.zPosition = 5
        leftIconNode.xScale = 0
        leftIconNode.yScale = 0
        
        return leftIconNode
    }
    
    private static func buildRightIcon(frame: CGRect) -> SKShapeNode {
        let rightIconNode = SKShapeNode(circleOfRadius: 20)
        rightIconNode.fillColor = UIColor(named: "backgroundColor")!
        rightIconNode.position = CGPoint(x: frame.maxX - 40, y: frame.minY + 50)
        rightIconNode.zPosition = 5
        rightIconNode.xScale = 0
        rightIconNode.yScale = 0
        
        return rightIconNode
    }
    
    private func addNodesToNode() {
        self.node.addChild(self.label)
        self.node.addChild(self.leftIcon)
        self.node.addChild(self.rightIcon)
    }
}
