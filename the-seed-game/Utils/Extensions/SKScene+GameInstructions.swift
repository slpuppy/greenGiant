//
//  SKScene+GameInstructions.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 05/02/22.
//

import SpriteKit

extension SKScene {
    func addChild(_ gameInstructions: GameInstructions) {
        addChild(gameInstructions.node)
    }
}
