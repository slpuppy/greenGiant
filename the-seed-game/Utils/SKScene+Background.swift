//
//  SKScene+Background.swift
//  the-seed-game
//
//  Created by Gabriel Puppi on 29/01/22.
//

import Foundation
import SpriteKit

extension SKScene {
    
    func addChild(_ background: Background) {
        addChild(background.node)
    }
}
