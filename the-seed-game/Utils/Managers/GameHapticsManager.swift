//
//  GameHapticsManager.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 05/03/22.
//

import CoreHaptics

class GameHapticsManager: CoreHapticsManager {
    func playTreeGrowPattern() {
        do {
            let pattern = try treeGrowPattern()
            try playHapticFromPattern(pattern)
        } catch {
            print("Failed to play tree grow haptic pattern: \(error)")
        }
    }
    
    func playCrashPattern() {
        do {
            let pattern = try crashPattern()
            try playHapticFromPattern(pattern)
        } catch {
            print("Failed to play crash haptic pattern: \(error)")
        }
    }
    
    func playTouchPattern() {
        do {
            let pattern = try touchPattern()
            try playHapticFromPattern(pattern)
        } catch {
            print("Failed to play touch haptic pattern: \(error)")
        }
    }
    
    func playCoinPattern() {
        do {
            let pattern = try coinPattern()
            try playHapticFromPattern(pattern)
        } catch {
            print("Failed to play coin haptic pattern: \(error)")
        }
    }
    
    func playFirePattern() {
        do {
            let pattern = try firePattern()
            try playHapticFromPattern(pattern)
        } catch {
            print("Failed to play fire haptic pattern: \(error)")
        }
    }
    
    private func treeGrowPattern() throws -> CHHapticPattern {
        let treeGrow = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.4),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
            ],
            relativeTime: 0,
            duration: 0.04
        )

        return try CHHapticPattern(events: [treeGrow], parameters: [])
    }
    
    private func crashPattern() throws -> CHHapticPattern {
        let crash = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 1),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
            ],
            relativeTime: 0,
            duration: 0.1
        )

        return try CHHapticPattern(events: [crash], parameters: [])
    }
    
    private func touchPattern() throws -> CHHapticPattern {
        let touch = CHHapticEvent(eventType: .hapticTransient, parameters: [], relativeTime: 0)
        
        return try CHHapticPattern(events: [touch], parameters: [])
    }
    
    private func coinPattern() throws -> CHHapticPattern {
        let coin = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.9)
            ],
            relativeTime: 0,
            duration: 0.01
        )
        
        return try CHHapticPattern(events: [coin], parameters: [])
    }
    
    private func firePattern() throws -> CHHapticPattern {
        let fire = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
            ],
            relativeTime: 0,
            duration: 0.5
        )
        
        return try CHHapticPattern(events: [fire], parameters: [])
    }
    
}
