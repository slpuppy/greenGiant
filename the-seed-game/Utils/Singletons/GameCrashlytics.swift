//
//  GameCrashlytics.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 10/02/22.
//

import FirebaseCrashlytics

class GameCrashlytics {
    static let shared = GameCrashlytics()
    
    init() {}
    
    func updateValueKeys(gameState: GameStatus) {
        Crashlytics.crashlytics().setCustomValue(
            getGameStateStr(gameState),
            forKey: "game_state"
        )
        Crashlytics.crashlytics().setCustomValue(
            Score.shared.score,
            forKey: "game_score"
        )
        Crashlytics.crashlytics().setCustomValue(
            getMusicStateStr(),
            forKey: "music_state"
        )
    }
    
    func logTap(at pos: CGPoint, at time: TimeInterval) {
        Crashlytics.crashlytics().log("Tapped at (\(pos.x)x, \(pos.y)y) at \(time.description)")
    }
    
    private func getGameStateStr(_ gameState: GameStatus) -> String {
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
    
    private func getMusicStateStr() -> String {
        guard let isPlaying = MusicPlayer.shared.audioPlayer?.isPlaying else {
            return "was not initialized"
        }
        
        if isPlaying {
            return "was playing"
        }
        
        return "was not playing"
    }
}
