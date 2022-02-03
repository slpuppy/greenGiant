//
//  Score.swift
//  the-seed-game
//
//  Created by Gabriel Puppi on 31/01/22.
//
import SpriteKit


class Score {
  
    static let shared = Score(score: 0.0)
    
    var score: Double
    
    private init(score: Double) {
         
        self.score = score
     }
    
    func resetScore() {
        self.score = 0
    }
}
