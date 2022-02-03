//
//  SKScene+GameOverOverlay.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 31/01/22.
//

import SpriteKit

extension SKScene {
    func addChild(_ gameOverOverlay: GameOverOverlay) {
        addChild(gameOverOverlay.node)
    }
}
