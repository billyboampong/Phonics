//
//  BGM Singleton.swift
//  Phonics-N
//
//  Created by Billy Boampong on 26/02/2019.
//  Copyright © 2019 BB++. All rights reserved.
//

import Foundation
import AVFoundation

class MusicHelper {
    static let sharedHelper = MusicHelper()
    var audioPlayer: AVAudioPlayer?
    
    func playBackgroundMusic() {
        let aSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "BGM", ofType: "mp3")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf:aSound as URL)
            audioPlayer!.numberOfLoops = -1
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
            audioPlayer?.volume = 0.2
        }
        catch {
            print("Cannot play the file")
        }
    }
}
