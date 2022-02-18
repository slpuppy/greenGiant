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

            let firstAchievement = getAchievement(
                userAchievements: achievements,
                identifier: AchievementIds.firstTimeGrower
            )

            if firstAchievement.isCompleted {
                return
            }

            firstAchievement.showsCompletionBanner = true
            firstAchievement.percentComplete = 100

            try await GKAchievement.report([firstAchievement])
        } catch {
            print("Error updating \(AchievementIds.firstTimeGrower)")
        }
    }
    
    func reportTimesPlayed() async {
        do {
            let achievements = try await GKAchievement.loadAchievements()
            var achievementsToReport: [GKAchievement] = []
            
            let fiveTree = getAchievement(
                userAchievements: achievements,
                identifier: AchievementIds.fiveTree
            )
            if !fiveTree.isCompleted {
                fiveTree.showsCompletionBanner = true
                fiveTree.percentComplete += 100/5
                
                achievementsToReport.append(fiveTree)
            }
            
            let twentyFiveTree = getAchievement(
                userAchievements: achievements,
                identifier: AchievementIds.twentyFiveTree
            )
            if !twentyFiveTree.isCompleted {
                twentyFiveTree.showsCompletionBanner = true
                twentyFiveTree.percentComplete += 100/25
                
                achievementsToReport.append(twentyFiveTree)
            }
            
            let fiftyTree = getAchievement(
                userAchievements: achievements,
                identifier: AchievementIds.fiftyTree
            )
            if !fiftyTree.isCompleted {
                fiftyTree.showsCompletionBanner = true
                fiftyTree.percentComplete += 100/50
                
                achievementsToReport.append(fiftyTree)
            }
            
            achievementsToReport.isEmpty ? nil : (try await GKAchievement.report(achievementsToReport))
        } catch {
            print(
                "Error updating \(AchievementIds.fiveTree) and/or \(AchievementIds.twentyFiveTree) and/or \(AchievementIds.fiftyTree)"
            )
        }
    }
    
    func reportGameProgress() async {
        let reachedFourTwentyMark = checkFourTwentyMark()
        let reachedSweetspot = checkSweetspot()
        
        if !reachedFourTwentyMark && !reachedSweetspot {
            return
        }
        
        do {
            let achievements = try await GKAchievement.loadAchievements()
            var achievementsToReport: [GKAchievement] = []
            
            if reachedFourTwentyMark {
                let fourTwentyAchievement = getAchievement(
                    userAchievements: achievements,
                    identifier: AchievementIds.fourTwenty
                )
                
                if !fourTwentyAchievement.isCompleted {
                    fourTwentyAchievement.showsCompletionBanner = true
                    fourTwentyAchievement.percentComplete = 100
                    
                    achievementsToReport.append(fourTwentyAchievement)
                }
            }
            
            if reachedSweetspot {
                let sweetspotAchievement = getAchievement(
                    userAchievements: achievements,
                    identifier: AchievementIds.sweetspot
                )
                
                if !sweetspotAchievement.isCompleted {
                    sweetspotAchievement.showsCompletionBanner = true
                    sweetspotAchievement.percentComplete = 100
                    
                    achievementsToReport.append(sweetspotAchievement)
                }
            }
            
            achievements.isEmpty ? nil : (try await GKAchievement.report(achievements))
        } catch {
            print("Error updating \(AchievementIds.fourTwenty) and/or \(AchievementIds.sweetspot)")
        }
    }
    
    private func getAchievement(
        userAchievements: [GKAchievement],
        identifier: String
    ) -> GKAchievement {
        var achievement = userAchievements.first(where: {
            return $0.identifier == identifier
        })
        
        if achievement == nil {
            achievement = GKAchievement(identifier: identifier)
        }
        
        return achievement!
    }
    
    private func checkFourTwentyMark() -> Bool {
        return Score.shared.score >= 420
    }
    
    private func checkSweetspot() -> Bool {
        let score = Score.shared.score
        let timesDecreased = Score.shared.timesDecreased
        
        return score >= 100 && timesDecreased == 0
    }
    
    enum AchievementIds {
        static let firstTimeGrower: String = "ggiant001"
        
        static let fiveTree: String = "5trees"
        static let twentyFiveTree: String = "25trees"
        static let fiftyTree: String = "50trees"
        
        static let fourTwenty: String = "420bro"
        
        static let sweetspot: String = "sweetspot"
    }
}
