//
//  DifficultyManager.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 03/02/22.
//

import SpriteKit

// Things that impact difficulty:
// - Branch mass (the more the harder to play)
// - Little Branch mass (the more the harder to play)
// - Trunk zRotation (the more the HARDER to play)

class DifficultyManager {
    var branchWeightMultiplier: CGFloat = 1
//    var littleBranchWeightMultiplier: CGFloat = 1
    var trunkZRotationMultiplier: CGFloat = 1
    
    private let screenFrame: CGRect
    private var lastPressTime: TimeInterval = 0
    private var lastPressSide: ScreenSidePressed!
    private var userSprints: Int = 0
    
    
    init(frame: CGRect) {
        self.screenFrame = frame
    }
    
    func gameScreenTapped(in pos: CGPoint, at pressTime: TimeInterval) {
        if lastPressTime == 0 {
            lastPressTime = pressTime
        }
        
        let screenSidePressed = getSidePressed(pos: pos)
        
        if lastPressSide == nil {
            lastPressSide = screenSidePressed
            return
        }
        
        let deltaTime = pressTime - lastPressTime
        lastPressTime = pressTime
        
        if checkIfIsSprinting(deltaTime: deltaTime, sidePressed: screenSidePressed) {
            trunkZRotationMultiplier += 0.3
        } else {
            trunkZRotationMultiplier = 1
        }
        
        incrementDifficulty()
        
        lastPressSide = screenSidePressed
    }
    
    private func getSidePressed(pos: CGPoint) -> ScreenSidePressed {
        if pos.x > screenFrame.midX {
            return .right
        }
        
        return .left
    }
    
    private func checkIfIsSprinting(
        deltaTime: TimeInterval,
        sidePressed: ScreenSidePressed
    ) -> Bool {
        if deltaTime <= 0.15 && lastPressSide != sidePressed {
            return true
        }
        
        return false
    }
    
    private func incrementDifficulty() {
        let actualScore = Score.shared.score
        
        branchWeightMultiplier = 1 + (actualScore/20)*0.2
    }
    
    enum ScreenSidePressed {
        case left
        case right
    }
}
