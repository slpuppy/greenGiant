//
//  SKScene+Branch.swift
//  the-seed-game
//
//  Created by Gabriel Puppi on 29/01/22.
//


import SpriteKit

extension SKScene {
    func addChild(_ branch: Branch) {
        addChild(branch.node)
    }
}
