//
//  SKScene+Twig.swift.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 28/01/22.
//

import SpriteKit

extension SKScene {
    func addChild(_ trunk: Trunk) {
        addChild(trunk.node)
    }
}


