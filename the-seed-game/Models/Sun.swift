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
   
    init(node: SKSpriteNode) {
        self.node = node
    }
    
    func removeSun() {
        self.node.removeFromParent()
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
        
        let sun = SKSpriteNode(texture: SKTexture(image: UIImage(named: "sun") ?? UIImage()))
        sun.scale(to: CGSize(width: sun.size.width*1.4, height: sun.size.height*1.4))
        sun.zPosition = 1
        sun.name = Names.sun
        
        let sunOverlay = SKSpriteNode(
            texture: SKTexture(image: UIImage(named: "sunOverlay") ?? UIImage())
        )
        sunOverlay.setScale(1.2)
        sunOverlay.zPosition = 0
        sunOverlay.name = Names.sunOverlay
        
        sunOverlay.addChild(sun)
        
        return sunOverlay
    }

    func runIntroStartAnimation() {
        // criação das animações
        let sunAnimation = SKAction.sequence([.scale(by: 1.05, duration: 1.5), .scale(by: 1/1.05, duration: 1.5)])
        sunAnimation.timingMode = .easeInEaseOut
        
        // inicialização das animações
        self.node.run(.repeatForever(sunAnimation))
    }

    func runIntroCutsceneAnimation(frame: CGRect) {
        let sunAnimation = SKAction.move(to: CGPoint(x: 0.0, y: frame.maxY + 250), duration: 1.5)
          sunAnimation.timingMode = .easeInEaseOut
        
        
        self.node.run(sunAnimation)
    }
    
    enum Names {
        static let sun: String = "sun"
        static let sunOverlay: String = "sunOverlay"
    }
}
