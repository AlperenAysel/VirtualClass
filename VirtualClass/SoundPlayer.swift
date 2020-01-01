//
//  SoundPlayer.swift
//  VirtualClass
//
//  Created by Alperen Aysel on 9.12.2019.
//  Copyright © 2019 Alperen. All rights reserved.
//

import Foundation
import AVFoundation
 

class MusicPlayer {
    static let shared = MusicPlayer()
    var audioPlayer: AVAudioPlayer?
    
    func start() {

        if let bundle = Bundle.main.path(forResource: "Dream_Background", ofType: "mp3") {
                 let backgroundMusic = NSURL(fileURLWithPath: bundle)
                 do {
                     audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                     guard let audioPlayer = audioPlayer else { return }
                     audioPlayer.numberOfLoops = -1
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
    
}
class SoundPlayer {
    static let shared = SoundPlayer()
    var audioPlayer: AVAudioPlayer?
    
    func start(sound: String) {

        if let bundle = Bundle.main.path(forResource: sound, ofType: "wav") {
                 let backgroundMusic = NSURL(fileURLWithPath: bundle)
                 do {
                     audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                     guard let audioPlayer = audioPlayer else { return }
                     audioPlayer.numberOfLoops = 0
                     audioPlayer.prepareToPlay()
                     audioPlayer.play()
                 } catch {
                     print(error)
                 }
             }
    }
    
}
