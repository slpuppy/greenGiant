//
//  UnderShopHapticsManager.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 05/03/22.
//

import CoreHaptics

class UnderShopHapticsManager: CoreHapticsManager {
    func playTouchPattern() {
        do {
            let pattern = try touchPattern()
            try playHapticFromPattern(pattern)
        } catch {
            print("Failed to play touch haptic pattern: \(error)")
        }
    }
    
    func playUnlockPattern() {
        do {
            let pattern = try unlockPattern()
            try playHapticFromPattern(pattern)
        } catch {
            print("Failed to play unlock haptic pattern: \(error)")
        }
    }
    
    func playNotEnoughCoinsPattern() {
        do {
            let pattern = try notEnoughCoinsPattern()
            try playHapticFromPattern(pattern)
        } catch {
            print("Failed to play not enough coins haptic pattern: \(error)")
        }
    }
    
    private func touchPattern() throws -> CHHapticPattern {
        let touch = CHHapticEvent(eventType: .hapticTransient, parameters: [], relativeTime: 0)
        
        return try CHHapticPattern(events: [touch], parameters: [])
    }
    
    private func unlockPattern() throws -> CHHapticPattern {
        let unlock = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.9)
            ],
            relativeTime: 0,
            duration: 0.01
        )
        
        return try CHHapticPattern(events: [unlock], parameters: [])
    }
    
    private func notEnoughCoinsPattern() throws -> CHHapticPattern {
        let notEnoughCoins = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.3),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
            ],
            relativeTime: 0,
            duration: 0.3
        )
        
        return try CHHapticPattern(events: [notEnoughCoins], parameters: [])
    }
    
}
