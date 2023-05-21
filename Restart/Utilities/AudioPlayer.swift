//
//  AudioPlayer.swift
//  Restart
//
//  Created by Tony Gorez on 21/05/2023.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playsound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("Could not play the sound file.")
        }
    }
}
