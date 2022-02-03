
import Foundation
import SpriteKit

extension SKScene {
    
    func addChild(_ sun: Sun) {
        addChild(sun.node)
    }
}
