//
//  Sun.swift
//  the-seed-game
//
//  Created by Gabriel Puppi on 29/01/22.
//

import Foundation
import SpriteKit

class Sun {
    let node: SKSpriteNode
   
    init(node: SKSpriteNode){
        self.node = node
    }
    
    //0,3
    func update(cameraPos: CGPoint) {
        
        let nodeY = node.position.y
        let yChange = node.frame.height * 0.75
        
        if cameraPos.y >= yChange + nodeY {
            
            node.position.y += node.frame.height/2
        }
   }
    
    func moveWithAnimation(to pos: CGPoint) {
        let animation: SKAction = .move(to: pos, duration: 0.5)
        animation.timingMode = .easeInEaseOut
        self.node.run(animation)
    }
  
    static func buildSun(frame: CGRect) -> SKSpriteNode {
        
        let sun = SKSpriteNode(imageNamed: "sun")
        sun.zPosition = 1
        sun.anchorPoint = .init(x: 0.5, y: 0.5)
        sun.position.y = frame.maxY
        
        return sun
        
    }


}
