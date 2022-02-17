//
//  AchievementManager.swift
//  the-seed-game
//
//  Created by Gabriel Puppi on 14/02/22.
//

import Foundation
import GameKit
import GameplayKit


class AchievementManager {
    func reportFirst() async {
        do {
            let achievements = try await GKAchievement.loadAchievements()

            let firstAchievement = findAchievement(
                in: achievements,
                id: AchievementIds.firstTimeGrower
            )

            guard let achievement = firstAchievement else {
                print("Achievement \(AchievementIds.firstTimeGrower) not found")
                return
            }

            if achievement.isCompleted {
                return
            }

            achievement.showsCompletionBanner = true
            achievement.percentComplete = 100

            try await GKAchievement.report([achievement])
        } catch {
            print("Error updating \(AchievementIds.firstTimeGrower)")
        }
    }
    
    func reportTimesPlayed() async {
        do {
            let achievements = try await GKAchievement.loadAchievements()
            
            let fiveTree = findAchievement(
                in: achievements,
                id: AchievementIds.fiveTree
            )
            let twentyFiveTree = findAchievement(
                in: achievements,
                id: AchievementIds.twentyFiveTree
            )
            let fiftyTree = findAchievement(
                in: achievements,
                id: AchievementIds.fiftyTree
            )
            
            guard let fiveTreeAchievement = fiveTree else {
                print("Achievement \(AchievementIds.fiveTree) not found")
                return
            }
            
            guard let twentyFiveTreeAchievement = twentyFiveTree else {
                print("Achievement \(AchievementIds.twentyFiveTree) not found")
                return
            }
            
            guard let fiftyTreeAchievement = fiftyTree else {
                print("Achievement \(AchievementIds.fiftyTree) not found")
                return
            }
            
            if fiveTreeAchievement.isCompleted &&
                twentyFiveTreeAchievement.isCompleted &&
                fiftyTreeAchievement.isCompleted {
                return
            }
            
            fiveTreeAchievement.showsCompletionBanner = true
            fiveTreeAchievement.percentComplete += 100/5
            
            twentyFiveTreeAchievement.showsCompletionBanner = true
            twentyFiveTreeAchievement.percentComplete += 100/25
            
            fiftyTreeAchievement.showsCompletionBanner = true
            fiftyTreeAchievement.percentComplete += 100/50
            
            try await GKAchievement.report(
                [fiveTreeAchievement, twentyFiveTreeAchievement, fiftyTreeAchievement]
            )
        } catch {
            print("Error updating \(AchievementIds.fiveTree) and \(AchievementIds.twentyFiveTree) and \(AchievementIds.fiftyTree)")
        }
    }
    
    func reportFourTwenty() async {
        if !checkFourTwentyMark() {
            return
        }
        
        do {
            let achievements = try await GKAchievement.loadAchievements()
            
            let fourTwenty = findAchievement(
                in: achievements,
                id: AchievementIds.fourTwenty
            )
            
            guard let fourTwentyAchievement = fourTwenty else {
                print("Achievement \(AchievementIds.fourTwenty) not found")
                return
            }
            
            if fourTwentyAchievement.isCompleted {
                return
            }
            
            fourTwentyAchievement.showsCompletionBanner = true
            fourTwentyAchievement.percentComplete = 100
            try await GKAchievement.report([fourTwentyAchievement])
        } catch {
            print("Error updating first achievement")
        }
    }
    
    private func findAchievement(in achievements: [GKAchievement], id: String) -> GKAchievement? {
        return achievements.first(where: { achievement in
            return achievement.identifier == id
        })
    }
    
    private func checkFourTwentyMark() -> Bool {
        return Score.shared.score >= 420
    }
    
    enum AchievementIds {
        static let firstTimeGrower: String = "ggiant001"
        
        static let fourTwenty: String = "420bro"
        
        static let fiveTree: String = "5trees"
        static let twentyFiveTree: String = "25trees"
        static let fiftyTree: String = "50trees"
    }
}



