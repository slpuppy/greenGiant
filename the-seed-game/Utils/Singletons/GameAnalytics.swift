//
//  GameAnalytics.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 10/02/22.
//

import FirebaseAnalytics
import CoreGraphics

class GameAnalytics {
    static let shared = GameAnalytics()
    
    private init() {}
    
    func logTappedMuteButton() {
        Analytics.logEvent(LogEventNames.tapped_mute, parameters: [
            LogEventNames.previous_music_volume: getMusicVolumeStr()
        ])
    }
    
    func logTappedPauseButton(isPaused: Bool) {
        Analytics.logEvent(LogEventNames.tapped_pause, parameters: [
            LogEventNames.previous_pause_status: getPauseStatusStr(isPaused: isPaused)
        ])
    }
    
    func logGameOver(cause: CauseOfGameOver) {
        Analytics.logEvent(LogEventNames.game_over, parameters: [
            LogEventNames.game_score: getGameScoreStr(),
            LogEventNames.cause_of_game_over: getCauseOfGameOverStr(cause)
        ])
    }
    
    func logTappedWhenAnimationWasRunning(at pos: CGPoint, gameState: GameStatus) {
        Analytics.logEvent(LogEventNames.tapped_when_animation_was_running, parameters: [
            LogEventNames.tapped_at: getPositionStr(pos),
            LogEventNames.game_state: getGameStateStr(gameState)
        ])
    }
    
    private func getMusicVolumeStr() -> String {
        guard let volume = MusicPlayer.shared.audioPlayer?.volume else {
            return "was not initialized"
        }
        
        return volume.description
    }
    
    private func getPauseStatusStr(isPaused: Bool) -> String {
        if isPaused {
            return "was paused"
        }
        
        return "was not paused"
    }
    
    private func getCauseOfGameOverStr(_ cause: CauseOfGameOver) -> String {
        switch cause {
        case .wallCrash:
            return "wall crash"
        case .bottomOverlaps:
            return "bottom overlaps"
        }
    }
    
    private func getPositionStr(_ pos: CGPoint) -> String {
        return "\(pos.x)x, \(pos.y)y"
    }
    
    private func getGameScoreStr() -> String {
        return Score.shared.score.description
    }
    
    enum LogEventNames {
        static let tapped_mute: String = "tapped_mute"
        static let previous_music_volume: String = "previous_music_volume"
        
        static let tapped_pause: String = "tapped_pause"
        static let previous_pause_status: String = "previous_pause_status"
        
        static let game_over: String = "game_over"
        static let cause_of_game_over: String = "cause_of_game_over"
        static let game_score: String = "game_score"
        
        static let tapped_when_animation_was_running: String = "tapped_when_animation_was_running"
        static let tapped_at: String = "tapped_at"
        static let game_state: String = "game_state"
    }
}
