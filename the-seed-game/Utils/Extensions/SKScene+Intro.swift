//
//  SKScene+Intro.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 02/02/22.
//

import SpriteKit

extension SKScene {
    func addChild(_ intro: Intro) {
        addChild(intro.node)
    }
}
