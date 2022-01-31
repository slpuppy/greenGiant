//
//  Score.swift
//  the-seed-game
//
//  Created by Gabriel Puppi on 31/01/22.
//
import SpriteKit


class Score {
  
    var score: Int
    
    init(score: Int) {
         self.score = score
     }
    
    func addScore() {
        
      score = score + 1
        
    }
    
}
