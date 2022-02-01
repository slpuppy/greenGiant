//
//  GameOver.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 29/01/22.
//

import SpriteKit

class GameOverOverlay {
    let node: SKNode
    let circleBackground: SKShapeNode
    
    let labelsContainer: SKNode
    let gameOverTitle: SKSpriteNode
    let subtitle: SKLabelNode
    let scoreTitle: SKLabelNode
    let scoreLabel: SKLabelNode
    let playAgainLabel: SKLabelNode
    let leaderboardsLabel: SKLabelNode
    
    init(frame: CGRect) {
        self.node = SKNode()
        self.node.zPosition = 100
        
        self.circleBackground = GameOverOverlay.buildCircleBackground()
        self.labelsContainer = GameOverOverlay.buildLabelsContainer()
        self.gameOverTitle = GameOverOverlay.buildGameOverTitle()
        self.subtitle = GameOverOverlay.buildSubtitle(text: "Remember fototropism...")
        self.scoreTitle = GameOverOverlay.buildScoreTitle()
        self.scoreLabel = GameOverOverlay.buildScoreLabel()
        self.playAgainLabel = GameOverOverlay.buildPlayAgainLabel()
        self.leaderboardsLabel = GameOverOverlay.buildLeaderboardsLabel()
        
        setupNodesPositions(frame: frame)
        addChildsToLabelsContainer()
        addChildsToNode()
    }
    
    func runOnAppearAnimation(startPos: CGPoint, frame: CGRect) {
        self.circleBackground.position = startPos

        let backgroundAnimationsGroup: [SKAction] = [
            .fadeAlpha(to: 0.85, duration: 0.2),
            .scale(by: frame.height, duration: 1)
        ]
        self.circleBackground.run(.group(backgroundAnimationsGroup))
        
        let labelsFadeInAnimation: SKAction = .fadeIn(withDuration: 0.6)
        labelsFadeInAnimation.timingMode = .easeInEaseOut
        
        let labelsContainerAnimationSequence: [SKAction] = [
            .wait(forDuration: 1.2),
            labelsFadeInAnimation
        ]
        
        self.labelsContainer.run(.sequence(labelsContainerAnimationSequence))
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
    
    static private func buildCircleBackground() -> SKShapeNode {
        let overlay = SKShapeNode(circleOfRadius: 2)
        overlay.strokeColor = .clear
        overlay.fillColor = .black
        
        return overlay
    }
    
    static private func buildLabelsContainer() -> SKNode {
        let container = SKNode()
        container.zPosition = 105
        container.alpha = 0
        
        return container
    }
    
    static private func buildGameOverTitle() -> SKSpriteNode {
        let imageNode = SKSpriteNode(imageNamed: "gameOverTitle")
        
        return imageNode
    }
    
    static private func buildSubtitle(text: String) -> SKLabelNode {
        let subtitleNode = SKLabelNode(text: text)
        subtitleNode.fontSize = 23
        subtitleNode.fontName = FontNames.medium
        subtitleNode.fontColor = .white
        
        return subtitleNode
    }
    
    static private func buildScoreTitle() -> SKLabelNode {
        let scoreTitleNode = SKLabelNode(text: "Your Score:")
        scoreTitleNode.fontSize = 27
        scoreTitleNode.fontName = FontNames.medium
        scoreTitleNode.fontColor = .white
        
        return scoreTitleNode
    }
    
    static private func buildScoreLabel() -> SKLabelNode {
        let scoreLabelNode = SKLabelNode(text: "100m")
        scoreLabelNode.fontSize = 58
        scoreLabelNode.fontName = FontNames.bold
        scoreLabelNode.fontColor = UIColor(named: "greenText")
        
        return scoreLabelNode
    }
    
    static private func buildPlayAgainLabel() -> SKLabelNode {
        let playAgainLabelNode = SKLabelNode(text: "Play Again")
        playAgainLabelNode.fontSize = 28
        playAgainLabelNode.fontName = FontNames.medium
        playAgainLabelNode.fontColor = .white
        
        return playAgainLabelNode
    }
    
    static private func buildLeaderboardsLabel() -> SKLabelNode {
        let attributedString = NSMutableAttributedString(string: "View Leaderboards")
        let strRange = NSMakeRange(0, attributedString.length)
        
        attributedString.beginEditing()
        attributedString.addAttributes(
            [
//                .underlineStyle: 1,
                .font: UIFont(name: FontNames.regular, size: 18) as Any,
                .foregroundColor: UIColor.white,
                .underlineColor: UIColor.white,
            ],
            range: strRange
        )
        attributedString.endEditing()
        
        let leaderboardsLabelNode = SKLabelNode(attributedText: attributedString)

        
        return leaderboardsLabelNode
    }
    
    private func setupNodesPositions(frame: CGRect) {
        self.gameOverTitle.position.y = frame.maxY - 100
        self.subtitle.position.y = self.gameOverTitle.position.y - 75
        self.scoreTitle.position.y = frame.midY + 40
        self.scoreLabel.position.y = frame.midY - 20
        self.leaderboardsLabel.position.y = frame.minY + 100
        self.playAgainLabel.position.y = self.leaderboardsLabel.position.y + 45
    }
    
    private func addChildsToLabelsContainer() {
        self.labelsContainer.addChild(self.gameOverTitle)
        self.labelsContainer.addChild(self.subtitle)
        self.labelsContainer.addChild(self.scoreTitle)
        self.labelsContainer.addChild(self.scoreLabel)
        self.labelsContainer.addChild(self.playAgainLabel)
        self.labelsContainer.addChild(self.leaderboardsLabel)
    }
    
    private func addChildsToNode() {
        self.node.addChild(circleBackground)
        self.node.addChild(labelsContainer)
    }
    
    enum FontNames {
        static let regular: String = "HelveticaNeue"
        static let medium: String = "HelveticaNeue-Medium"
        static let bold: String = "HelveticaNeue-Bold"
    }
}
