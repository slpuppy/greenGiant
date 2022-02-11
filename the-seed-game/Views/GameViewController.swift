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
import SnapKit
import GoogleMobileAds

class GameViewController: UIViewController, GKGameCenterControllerDelegate, GameSceneDelegate {
    
    
    let adManager = AdManager()
    
    func dismissMenuView() {
        menuView.removeFromSuperview()
    }
    
    var gcEnabled = Bool() // Check if the user has Game Center enabled
    var gcDefaultLeaderBoard = String() // Check the default leaderboardID
    
    lazy var menuView: MenuView = {
        let view = MenuView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MusicPlayer.shared.startBackgroundMusic()
        MusicPlayer.shared.audioPlayer?.volume = 0.3
        
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
        
        // Ad resquest
        
        adManager.initialize()
        
    }
    
    
    func setupMenuBar(){
        view.addSubview(menuView)
        menuView.layer.zPosition = 10
        menuView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.leading.equalToSuperview().offset(24)
        }
        menuView.muteButton.addTarget(self, action: #selector(muteTapped), for: .touchDown)
        menuView.pauseButton.addTarget(self, action: #selector(pauseTapped), for: .touchDown)
    }
    
    @objc func muteTapped() {
        if MusicPlayer.shared.audioPlayer?.volume != 0 {
            MusicPlayer.shared.audioPlayer?.volume = 0
            menuView.muteButton.tintColor = UIColor(named: "scoreColor")
        } else {
            menuView.muteButton.tintColor = .systemGray2
            MusicPlayer.shared.audioPlayer?.volume = 0.3
        }
    }
    
    func displayAd(){
        adManager.presentInterstitialAd(in: self)
    }
    
    
    @objc func pauseTapped() {
   
        if let view = self.view as! SKView?,
           let gameScene = view.scene as? GameScene {
            gameScene.isPaused.toggle()
            playOrPause()
            if gameScene.isPaused == true {
                menuView.pauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                menuView.pauseButton.tintColor = UIColor(named: "scoreColor")
            } else {
                menuView.pauseButton.setImage(UIImage(systemName: "pause"), for: .normal)
                menuView.pauseButton.tintColor = .systemGray2
            }
        }
    }
    
    func playOrPause() {
        if MusicPlayer.shared.audioPlayer?.volume == 0.3 {
            MusicPlayer.shared.audioPlayer?.setVolume(0.03, fadeDuration: 0.3)
        } else {
            MusicPlayer.shared.audioPlayer?.setVolume(0.3, fadeDuration: 0.3)
        }
    }
    
    func muteSong() {
        return
    }
    
    func pauseGame() {
        return
    }
    
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
