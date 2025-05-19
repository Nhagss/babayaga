//
//  AudioManagerView.swift
//  babayaga
//
//  Created by Melissa Freire Guedes on 13/05/25.
//

import SwiftUI
import Foundation
import AVFAudio

final class AudioManager {
    @MainActor static let shared = AudioManager()
    private var player: AVAudioPlayer?
    private var secondaryPlayer: AVAudioPlayer?
    
    init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print(error)
        }
    }
    func playSound(named: String) {
        guard let url = Bundle.main.url(forResource: named, withExtension: "mp3") else {
            print("Couldn't find \(named).wav")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1
            player?.play()
        } catch {
            print(error)
        }
    }
    
    func playSoundGranny(named: String) {
        guard let url = Bundle.main.url(forResource: named, withExtension: "mp3") else {
            print("Couldn't find \(named).wav")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = 0
            player?.play()
        } catch {
            print(error)
        }
    }
    
    func stopSound() {
       player?.stop()
       player = nil
   }
    func playEffect(named: String) {
//        print(#function)
        guard let url = Bundle.main.url(forResource: named, withExtension: "mp3") else {
            print("Couldn't find \(named).mp3")
            return
        }

        do {
//            print("Tocou")
            secondaryPlayer?.stop()
            secondaryPlayer = try AVAudioPlayer(contentsOf: url)
//            effectPlayer.volume = 10
            secondaryPlayer?.numberOfLoops = 0
            secondaryPlayer?.play()
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + effectPlayer.duration) {
//            }
        } catch {
            print("Error playing effect: \(error)")
        }
    }
}
