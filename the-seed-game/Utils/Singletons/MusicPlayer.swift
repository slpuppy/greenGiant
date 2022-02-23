//
//  MusicPlayer.swift
//  the-seed-game
//
//  Created by Gabriel Puppi on 08/02/22.
//

import Foundation
import AVFoundation



class MusicPlayer {
    
    static let shared = MusicPlayer()
    var audioPlayer: AVAudioPlayer?
    var status: PlayerStatus = .fullVolume
    
    func startBackgroundMusic() {
        if let bundle = Bundle.main.path(forResource: "background", ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.numberOfLoops = -1
                audioPlayer.volume = 0.3
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
    
    func stopBackgroundMusic() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.stop()
    }
    
    func mute() {
        audioPlayer?.volume = 0.0
        status = .muted
    }
    
    func unmute() {
        audioPlayer?.volume = 0.3
        status = .fullVolume
    }
    
    func setToLowVolume() {
        audioPlayer?.setVolume(0.03, fadeDuration: 0.3)
        status = .lowVolume
    }
    
    enum PlayerStatus {
        case muted
        case fullVolume
        case lowVolume
    }
}
