//
//  GameStates.swift
//  the-seed-game
//
//  Created by Gabriel Puppi on 29/01/22.
//

import Foundation


enum GameStatus {
    case intro
    case playing
    case paused
    case gameOver
}

func getGameStateStr(_ gameState: GameStatus) -> String {
    switch gameState {
    case .intro:
         return "intro"
    case .playing:
        return "playing"
    case .paused:
        return "paused"
    case .gameOver:
        return "game over"
    }
}
