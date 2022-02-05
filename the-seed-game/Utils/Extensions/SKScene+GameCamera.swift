//
//  SKScene+GameCamera.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 05/02/22.
//

import SpriteKit

extension SKScene {
    func addChild(_ gameCamera: GameCamera) {
        addChild(gameCamera.node)
    }
}
