//
//  GameCamera.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 05/02/22.
//

import SpriteKit

class GameCamera {
    let node: SKCameraNode
    
    init() {
        self.node = SKCameraNode()
    }
    
    func moveWithAnimation(to pos: CGPoint) {
        let action = SKAction.move(
            to: pos,
            duration: ElementValues.moveAnimationDuration
        )
        action.timingMode = .easeOut
        
        self.node.run(action)
    }
    
    func resetPositionWithAnimation(to pos: CGPoint, delay: TimeInterval = 0) {
        let cameraAnimation: SKAction = .move(
            to: pos,
            duration: ElementValues.resetPositionAnimationDuration
        )
        cameraAnimation.timingMode = .easeOut
        
        self.node.run(.sequence([
            .wait(forDuration: delay),
            cameraAnimation
        ]))
    }
    
    enum ElementValues {
        static let moveAnimationDuration: TimeInterval = 0.4
        static let resetPositionAnimationDuration: TimeInterval = 3
    }
}
