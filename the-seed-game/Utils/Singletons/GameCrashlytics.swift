//
//  GameCrashlytics.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 10/02/22.
//

import FirebaseCrashlytics

class GameCrashlytics {
    static let shared = GameCrashlytics()
    
    private init() {}
    
    func updateKeysValues(gameState: GameStatus) {
        Crashlytics.crashlytics().setCustomValue(
            getGameStateStr(gameState),
            forKey: ValueKeys.game_state
        )
        Crashlytics.crashlytics().setCustomValue(
            Score.shared.score,
            forKey: ValueKeys.game_score
        )
        Crashlytics.crashlytics().setCustomValue(
            getMusicVolume(),
            forKey: ValueKeys.music_volume
        )
    }
    
    func logTap(at pos: CGPoint, at time: TimeInterval) {
        Crashlytics.crashlytics().log(
            "Tapped at (\(pos.x)x, \(pos.y)y) at \(time.description)s"
        )
    }
    
    private func getMusicVolume() -> String {
        guard let musicVolume = MusicPlayer.shared.audioPlayer?.volume else {
            return "was not initialized"
        }
        
        return musicVolume.description
    }
    
    enum ValueKeys {
        static let game_state: String = "game_state"
        static let game_score: String = "game_score"
        static let music_volume: String = "music_state"
    }
}
