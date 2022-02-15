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
  
  
func reportFirstAchievement() {
     
    let achievement = GKAchievement(identifier: "ggiant001")
    print(achievement)
    achievement.showsCompletionBanner = true
    
     
    GKAchievement.report([achievement], withCompletionHandler: {(error: Error?) in
         if error != nil {
             // Handle the error that occurs.
             print("Error: \(String(describing: error))")
             return
         }
         print("achievement sent")
     })
     
     
//GKAchievement.loadAchievements(completionHandler: { (achievements: [GKAchievement]?, error: Error?) in
//            let achievementID = "ggiant001"
//            var achievement: GKAchievement? = nil
//
//            // Find an existing achievement.
//            achievement = achievements?.first(where: { $0.identifier == achievementID})
//
//            // Otherwise, create a new achievement.
//            if achievement == nil {
//                achievement = GKAchievement(identifier: achievementID)
//            }
//
//            // Insert code to report the percentage.
//            if achievement?.percentComplete == 100 {return}
//            achievement?.percentComplete = 100
//
//
//            GKAchievement.report([achievement!], withCompletionHandler: {(error: Error?) in
//                if error != nil {
//                    // Handle the error that occurs.
//                    print("Error: \(String(describing: error))")
//                }
//            })
//
//            if error != nil {
//                // Handle the error that occurs.
//                print("Error: \(String(describing: error))")
//            }
//        })
        
    }





}



