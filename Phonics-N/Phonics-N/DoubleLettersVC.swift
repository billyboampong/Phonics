//
//  DoubleLettersVC.swift
//  Phonics-N
//
//  Created by Billy Boampong on 02/04/2019.
//  Copyright © 2019 BBWave. All rights reserved.
//

import UIKit
import AVFoundation

class DoubleLettersVC: UIViewController {
    
    
    var audioPlayer : AVAudioPlayer?
    var selectedSoundFileName : String = ""
    var playedDouble : String = ""
    var randomDoubleIndex : Int = 0
    var doubleArray = ["ai", "ar", "ch", "ck", "ee", "ie", "ng", "oa", "oi", "oo", "or", "ou", "ph", "qu", "sh", "ss", "th", "ue"]
    
    
    @IBOutlet weak var doubleAnswerLabel: UILabel!
    
    @IBOutlet weak var doubleFace01: UIButton!
    @IBOutlet weak var doubleFace02: UIButton!
    @IBOutlet weak var doubleFace03: UIButton!
    @IBOutlet weak var doubleFace04: UIButton!
    @IBOutlet weak var doubleFace05: UIButton!
    @IBOutlet weak var doubleFace06: UIButton!
    
    
    
// Selects a random double letter for the question
    func randomDouble() {
        randomDoubleIndex = Int.random(in: 0 ... 5)
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
        let doubleFaces = [doubleFace01, doubleFace02, doubleFace03, doubleFace04, doubleFace05, doubleFace06]
        let tag = sender.tag - 1
        if doubleFaces[tag]!.currentTitle == playedDouble {
            rightAnswer(sender: doubleFaces[tag]!)
            refreshDoublesWithDelay()
        }
        else {
            wrongAnswer(sender: doubleFaces[tag]!)
        }
        
    }
    
// Plays 'correct' audio, highlights 'correct' button and disables/enables 'correct' button
    func rightAnswer (sender: UIButton) {
        selectedSoundFileName = "ThatsCorrect.mp3"
        playAudio()
        doubleAnswerLabel.text = "CORRECT"
        doubleAnswerLabel.textColor = UIColor(rgb: 0x39ff14)
        let doubleFaces = [doubleFace01, doubleFace02, doubleFace03, doubleFace04, doubleFace05, doubleFace06]
        let tag = sender.tag - 1
        doubleFaces[tag]!.layer.cornerRadius = 5
        doubleFaces[tag]!.layer.borderColor = UIColor(rgb: 0x39ff14).cgColor
        doubleFaces[tag]!.layer.borderWidth = 8.0
        doubleFaces[tag]!.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            doubleFaces[tag]!.layer.borderWidth = 0
            doubleFaces[tag]!.isUserInteractionEnabled = true
        })
    }
    
// Plays 'wrong' audio and highlights 'wrong' button
    func wrongAnswer (sender: UIButton) {
        selectedSoundFileName = "Uhoh.mp3"
        playAudio()
        doubleAnswerLabel.text = "Wrong...     "
        doubleAnswerLabel.textColor = UIColor(rgb: 0xFB2B11)
        let doubleFaces = [doubleFace01, doubleFace02, doubleFace03, doubleFace04, doubleFace05, doubleFace06]
        let tag = sender.tag - 1
        doubleFaces[tag]!.layer.cornerRadius = 5
        doubleFaces[tag]!.layer.borderColor = UIColor(rgb: 0xFB2B11).cgColor
        doubleFaces[tag]!.layer.borderWidth = 8.0
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3, execute: {
            self.doubleAnswerLabel.text = ""
            doubleFaces[tag]!.layer.borderWidth = 0
        })
    }
    
    
    
// New question audio setup and play
    func newQuestion() {
        randomDouble()
        selectedSoundFileName = "WhichOneIs.mp3"
        playAudio()
        
        let possibleArray = [doubleFace01.currentTitle, doubleFace02.currentTitle, doubleFace03.currentTitle, doubleFace04.currentTitle, doubleFace05.currentTitle, doubleFace06.currentTitle]
        
        let when = DispatchTime.now() + 1.7
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.selectedSoundFileName = possibleArray[self.randomDoubleIndex]!+".mp3"
            self.playAudio()
        }
    }
    
// Consonant button faces refresh function
    func newFaces() {
        let doubleFaces = [doubleFace01, doubleFace02, doubleFace03, doubleFace04, doubleFace05, doubleFace06]
        for (doubleFace, double) in zip(doubleFaces, doubleArray.shuffled()) {
            doubleFace?.setTitle(double, for: .normal)
        }
    }
    
    
// Establishes correct answer based on consonant audio played
    func newAnswer() {
        let possibleArray = [doubleFace01.currentTitle, doubleFace02.currentTitle, doubleFace03.currentTitle, doubleFace04.currentTitle, doubleFace05.currentTitle, doubleFace06.currentTitle]
        playedDouble = possibleArray[randomDoubleIndex]!
        print(playedDouble)
    }
    
// Combines functions to refresh the whole question and views
    func refreshDoublesWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.newFaces()
            self.newQuestion()
            self.newAnswer()
            self.doubleAnswerLabel.text = ""
        })
    }
    
// Local VC back button function
    @IBAction func dismissDoubleLettersVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
// Local refresh button function (replays double letter audio)
    @IBAction func refreshDoubleAudio(_ sender: Any) {
        selectedSoundFileName = "\(playedDouble).mp3"
        playAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newFaces()
        newQuestion()
        newAnswer()
        
    }
    
    @IBAction func doubleFace01Pressed(_ sender: Any) {
        checkAnswer(sender: doubleFace01)
    }
    
    @IBAction func doubleFace02Pressed(_ sender: Any) {
        checkAnswer(sender: doubleFace02)
    }
    
    @IBAction func doubleFace03Pressed(_ sender: Any) {
        checkAnswer(sender: doubleFace03)
    }
    
    @IBAction func doubleFace04Pressed(_ sender: Any) {
        checkAnswer(sender: doubleFace04)
    }
    
    @IBAction func doubleFace05Pressed(_ sender: Any) {
        checkAnswer(sender: doubleFace05)
    }
    
    @IBAction func doubleFace06Pressed(_ sender: Any) {
        checkAnswer(sender: doubleFace06)
    }
    
    
}

// TO DO
// add soundbites
