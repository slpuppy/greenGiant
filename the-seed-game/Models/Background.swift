//
//  Background.swift
//  the-seed-game
//
//  Created by Gabriel Puppi on 29/01/22.
//
import SpriteKit

class Background {
    let node: SKSpriteNode
   
    init(node: SKSpriteNode){
        self.node = node
    }
    
    func update(cameraPos: CGPoint) {
        
        let nodeY = node.position.y
        let yChange = node.frame.height * 0.75
        
        if cameraPos.y >= yChange + nodeY {
            
            node.position.y += node.frame.height/2
        }
   }
  
    static func buildBackground(frame: CGRect) -> SKSpriteNode {
        
        let background = SKSpriteNode(imageNamed: "bg")
        background.zPosition = 0
        background.anchorPoint = .init(x: 0.5, y: 0.0)
        background.position.y = frame.maxY
        
        return background
        
    }
    
}
