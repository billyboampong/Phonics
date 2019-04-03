//
//  ConsonantsVC.swift
//  Phonics-N
//
//  Created by Billy Boampong on 21/03/2019.
//  Copyright © 2019 BBWave. All rights reserved.
//

import UIKit
import AVFoundation

class ConsonantsVC: UIViewController {
    
    
    var audioPlayer : AVAudioPlayer?
    var selectedSoundFileName : String = ""
    var playedConsonant : String = ""
    var randomConsonantIndex : Int = 0
    var consonantArray = ["B", "C", "D", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "X", "Y", "Z"]

    
    @IBOutlet weak var consonantAnswerLabel: UILabel!
    
    @IBOutlet weak var consonantFace01: UIButton!
    @IBOutlet weak var consonantFace02: UIButton!
    @IBOutlet weak var consonantFace03: UIButton!
    @IBOutlet weak var consonantFace04: UIButton!
    @IBOutlet weak var consonantFace05: UIButton!
    @IBOutlet weak var consonantFace06: UIButton!
    
    
    
// Selects a random consonant for the question
    func randomConsonant() {
        randomConsonantIndex = Int.random(in: 0 ... 5)
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
        let consonantFaces = [consonantFace01, consonantFace02, consonantFace03, consonantFace04, consonantFace05, consonantFace06]
        let tag = sender.tag - 1
        if consonantFaces[tag]!.currentTitle == playedConsonant {
            rightAnswer(sender: consonantFaces[tag]!)
            refreshConsonantsWithDelay()
        }
        else {
            wrongAnswer(sender: consonantFaces[tag]!)
        }
        
    }
    
// Plays 'correct' audio, highlights 'correct' button and disables/enables 'correct' button
    func rightAnswer (sender: UIButton) {
        selectedSoundFileName = "ThatsCorrect.mp3"
        playAudio()
        consonantAnswerLabel.text = "CORRECT!"
        consonantAnswerLabel.textColor = UIColor(rgb: 0x39ff14)
        let consonantFaces = [consonantFace01, consonantFace02, consonantFace03, consonantFace04, consonantFace05, consonantFace06]
        let tag = sender.tag - 1
        consonantFaces[tag]!.layer.cornerRadius = 5
        consonantFaces[tag]!.layer.borderColor = UIColor(rgb: 0x39ff14).cgColor
        consonantFaces[tag]!.layer.borderWidth = 8.0
        consonantFaces[tag]!.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            consonantFaces[tag]!.layer.borderWidth = 0
            consonantFaces[tag]!.isUserInteractionEnabled = true
        })
    }
    
//Plays 'wrong' audio and highlights 'wrong' button
    func wrongAnswer (sender: UIButton) {
        selectedSoundFileName = "Uhoh.mp3"
        playAudio()
        consonantAnswerLabel.text = "WRONG :("
        consonantAnswerLabel.textColor = UIColor(rgb: 0xFB2B11)
        let consonantFaces = [consonantFace01, consonantFace02, consonantFace03, consonantFace04, consonantFace05, consonantFace06]
        let tag = sender.tag - 1
        consonantFaces[tag]!.layer.cornerRadius = 5
        consonantFaces[tag]!.layer.borderColor = UIColor(rgb: 0xFB2B11).cgColor
        consonantFaces[tag]!.layer.borderWidth = 8.0
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3, execute: {
            self.consonantAnswerLabel.text = ""
            consonantFaces[tag]!.layer.borderWidth = 0
        })
    }
    

    
// New question audio setup and play
    func newQuestion() {
        randomConsonant()
        selectedSoundFileName = "WhichOneIs.mp3"
        playAudio()
        
        let possibleArray = [consonantFace01.currentTitle, consonantFace02.currentTitle, consonantFace03.currentTitle, consonantFace04.currentTitle, consonantFace05.currentTitle, consonantFace06.currentTitle]
        
        let when = DispatchTime.now() + 1.7
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.selectedSoundFileName = possibleArray[self.randomConsonantIndex]!+".mp3"
            self.playAudio()
        }
    }
    
// Consonant button faces refresh function
    func newFaces() {
        let consonantFaces = [consonantFace01, consonantFace02, consonantFace03, consonantFace04, consonantFace05, consonantFace06]
        for (consonantFace, consonant) in zip(consonantFaces, consonantArray.shuffled()) {
            consonantFace?.setTitle(consonant, for: .normal)
        }
    }
    
    
// Establishes correct answer based on consonant audio played
    func newAnswer() {
        let possibleArray = [consonantFace01.currentTitle, consonantFace02.currentTitle, consonantFace03.currentTitle, consonantFace04.currentTitle, consonantFace05.currentTitle, consonantFace06.currentTitle]
        playedConsonant = possibleArray[randomConsonantIndex]!
        print(playedConsonant)
    }
    
// Combines functions to refresh the whole question and views
    func refreshConsonantsWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.newFaces()
            self.newQuestion()
            self.newAnswer()
            self.consonantAnswerLabel.text = ""
        })
    }
    
// Local VC back button function
    @IBAction func dismissConsonantsVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
// Local refresh button function (replays consonant audio)
    @IBAction func refreshConsonantAudio(_ sender: Any) {
        selectedSoundFileName = "\(playedConsonant).mp3"
        playAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newFaces()
        newQuestion()
        newAnswer()
        
    }
    
    @IBAction func consonantFace01Pressed(_ sender: UIButton) {
        checkAnswer(sender: consonantFace01)
    }
    
    @IBAction func consonantFace02Pressed(_ sender: UIButton) {
        checkAnswer(sender: consonantFace02)
    }
    
    @IBAction func consonantFace03Pressed(_ sender: UIButton) {
        checkAnswer(sender: consonantFace03)
    }
    
    
    @IBAction func consonantFace04Pressed(_ sender: UIButton) {
        checkAnswer(sender: consonantFace04)
    }
    
    @IBAction func consonantFace05Pressed(_ sender: UIButton) {
        checkAnswer(sender: consonantFace05)
    }
    
    @IBAction func consonantFace06Pressed(_ sender: UIButton) {
        checkAnswer(sender: consonantFace06)
    }
    
}

// TO DO
// add soundbites
