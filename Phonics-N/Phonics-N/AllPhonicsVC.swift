//
//  AllPhonicsVC.swift
//  Phonics-N
//
//  Created by Billy Boampong on 03/04/2019.
//  Copyright © 2019 BBWave. All rights reserved.
//

import UIKit
import AVFoundation

class AllPhonicsVC: UIViewController {
    
    
    var audioPlayer : AVAudioPlayer?
    var selectedSoundFileName : String = ""
    var playedAll : String = ""
    var randomAllIndex : Int = 0
    var allArray = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "ai", "ar", "ch", "ck", "ee", "ie", "ng", "oa", "oi", "oo", "or", "ou", "ph", "qu", "sh", "ss", "th", "ue"]
    
    
    @IBOutlet weak var allAnswerLabel: UILabel!
    
    @IBOutlet weak var allFace01: UIButton!
    @IBOutlet weak var allFace02: UIButton!
    @IBOutlet weak var allFace03: UIButton!
    @IBOutlet weak var allFace04: UIButton!
    @IBOutlet weak var allFace05: UIButton!
    @IBOutlet weak var allFace06: UIButton!
    
    
    
// Selects a random all letter for the question
    func randomAll() {
        randomAllIndex = Int.random(in: 0 ... 5)
    }
    
// Plays audio based on 'selectedSoundFileName' input
    func playAudio() {
        let path = Bundle.main.path(forResource: selectedSoundFileName, ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Couldn't load audio") }
    }
    
    
// Check answer function
    func checkAnswer (sender: UIButton) {
        let allFaces = [allFace01, allFace02, allFace03, allFace04, allFace05, allFace06]
        let tag = sender.tag - 1
        if allFaces[tag]!.currentTitle == playedAll {
            rightAnswer(sender: allFaces[tag]!)
            refreshAllsWithDelay()
        }
        else {
            wrongAnswer(sender: allFaces[tag]!)
        }
        
    }
    
// Plays 'correct' audio, highlights 'correct' button and disables/enables 'correct' button
    func rightAnswer (sender: UIButton) {
        selectedSoundFileName = "ThatsCorrect.mp3"
        playAudio()
        allAnswerLabel.text = "CORRECT"
        allAnswerLabel.textColor = UIColor(rgb: 0x39ff14)
        let allFaces = [allFace01, allFace02, allFace03, allFace04, allFace05, allFace06]
        let tag = sender.tag - 1
        allFaces[tag]!.layer.cornerRadius = 5
        allFaces[tag]!.layer.borderColor = UIColor(rgb: 0x39ff14).cgColor
        allFaces[tag]!.layer.borderWidth = 8.0
        allFaces[tag]!.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            allFaces[tag]!.layer.borderWidth = 0
            allFaces[tag]!.isUserInteractionEnabled = true
        })
    }
    
// Plays 'wrong' audio and highlights 'wrong' button
    func wrongAnswer (sender: UIButton) {
        selectedSoundFileName = "Uhoh.mp3"
        playAudio()
        allAnswerLabel.text = "Wrong...     "
        allAnswerLabel.textColor = UIColor(rgb: 0xFB2B11)
        let allFaces = [allFace01, allFace02, allFace03, allFace04, allFace05, allFace06]
        let tag = sender.tag - 1
        allFaces[tag]!.layer.cornerRadius = 5
        allFaces[tag]!.layer.borderColor = UIColor(rgb: 0xFB2B11).cgColor
        allFaces[tag]!.layer.borderWidth = 8.0
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3, execute: {
            self.allAnswerLabel.text = ""
            allFaces[tag]!.layer.borderWidth = 0
        })
    }
    
    
    
// New question audio setup and play
    func newQuestion() {
        randomAll()
        selectedSoundFileName = "WhichOneIs.mp3"
        playAudio()
        
        let possibleArray = [allFace01.currentTitle, allFace02.currentTitle, allFace03.currentTitle, allFace04.currentTitle, allFace05.currentTitle, allFace06.currentTitle]
        
        let when = DispatchTime.now() + 1.7
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.selectedSoundFileName = possibleArray[self.randomAllIndex]!+".mp3"
            self.playAudio()
        }
    }
    
// Consonant button faces refresh function
    func newFaces() {
        let allFaces = [allFace01, allFace02, allFace03, allFace04, allFace05, allFace06]
        for (allFace, all) in zip(allFaces, allArray.shuffled()) {
            allFace?.setTitle(all, for: .normal)
        }
    }
    
    
// Establishes correct answer based on consonant audio played
    func newAnswer() {
        let possibleArray = [allFace01.currentTitle, allFace02.currentTitle, allFace03.currentTitle, allFace04.currentTitle, allFace05.currentTitle, allFace06.currentTitle]
        playedAll = possibleArray[randomAllIndex]!
        print(playedAll)
    }
    
// Combines functions to refresh the whole question and views
    func refreshAllsWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.newFaces()
            self.newQuestion()
            self.newAnswer()
            self.allAnswerLabel.text = ""
        })
    }
    
// Local VC back button function
    @IBAction func dismissAllPhonicsVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
// Local refresh button function (replays phonic audio)
    @IBAction func refreshAllAudio(_ sender: Any) {
        selectedSoundFileName = "\(playedAll).mp3"
        playAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newFaces()
        newQuestion()
        newAnswer()
        
    }
    
    @IBAction func allFace01Pressed(_ sender: Any) {
        checkAnswer(sender: allFace01)
    }
    
    @IBAction func allFace02Pressed(_ sender: Any) {
        checkAnswer(sender: allFace02)
    }
    
    @IBAction func allFace03Pressed(_ sender: Any) {
        checkAnswer(sender: allFace03)
    }
    
    @IBAction func allFace04Pressed(_ sender: Any) {
        checkAnswer(sender: allFace04)
    }
    
    @IBAction func allFace05Pressed(_ sender: Any) {
        checkAnswer(sender: allFace05)
    }
    
    @IBAction func allFace06Pressed(_ sender: Any) {
        checkAnswer(sender: allFace06)
    }
    
    
}

// TO DO
// add soundbites




