//
//  GameViewController.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 28/01/22.
//

import UIKit
import SpriteKit
import GameplayKit
import GameKit


class GameViewController: UIViewController, GKGameCenterControllerDelegate, GameSceneDelegate {
    
    
    func updateLeaderboardScore() {
        updateScore(with: Score.shared.score)
    }
    
    
    func leaderboardTapped() {
          let GameCenterVC = GKGameCenterViewController(leaderboardID: self.gcDefaultLeaderBoard, playerScope: .global, timeScope: .allTime)
          GameCenterVC.gameCenterDelegate = self
          present(GameCenterVC, animated: true, completion: nil)
   }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated:true)
    }
    
    func updateScore(with value: Double)
       {
           if (self.gcEnabled)
           {
               GKLeaderboard.submitScore(Int(value), context:0, player: GKLocalPlayer.local, leaderboardIDs: [self.gcDefaultLeaderBoard], completionHandler: {error in})
           }
       }
    
  
    
    
    var gcEnabled = Bool() // Check if the user has Game Center enabled
    var gcDefaultLeaderBoard = String() // Check the default leaderboardID
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            let scene = GameScene()
            scene.gameSceneDelegate = self
            scene.scaleMode = .aspectFit
            view.presentScene(scene)
            authenticateLocalPlayer()
        }
        let GameCenterVC = GKGameCenterViewController(leaderboardID: self.gcDefaultLeaderBoard, playerScope: .global, timeScope: .allTime)
            GameCenterVC.gameCenterDelegate = self
            present(GameCenterVC, animated: true, completion: nil)
        
    }
    
  
        
      
    
    
    func authenticateLocalPlayer() {
        let localPlayer: GKLocalPlayer = GKLocalPlayer.local

        localPlayer.authenticateHandler = {(ViewController, error) -> Void in
            if ((ViewController) != nil) {
                // Show game center login if player is not logged in
                self.present(ViewController!, animated: true, completion: nil)
            }
            else if (localPlayer.isAuthenticated) {
                
                // Player is already authenticated and logged in
                self.gcEnabled = true

                // Get the default leaderboard ID
                localPlayer.loadDefaultLeaderboardIdentifier(completionHandler: { (leaderboardIdentifer, error) in
                    if error != nil {
                        print(error!)
                    }
                    else {
                        self.gcDefaultLeaderBoard = leaderboardIdentifer!
                    }
                 })
            }
            else {
                // Game center is not enabled on the user's device
                self.gcEnabled = false
                print("Local player could not be authenticated!")
                print(error!)
            }
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
