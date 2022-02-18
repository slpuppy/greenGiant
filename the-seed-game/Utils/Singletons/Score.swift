//
//  Score.swift
//  the-seed-game
//
//  Created by Gabriel Puppi on 31/01/22.
//
import SpriteKit


class Score {
  
    static let shared = Score(score: 0.0, timesDecreased: 0)
    
    var score: Double
    var timesDecreased: Int
    
    private init(score: Double, timesDecreased: Int) {
        self.score = score
        self.timesDecreased = timesDecreased
     }
    
    func resetScore() {
        self.score = 0.0
        self.timesDecreased = 0
    }
}
