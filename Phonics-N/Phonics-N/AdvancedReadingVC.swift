//
//  AdvancedReadingVC.swift
//  Phonics-N
//
//  Created by Billy Boampong on 03/04/2019.
//  Copyright © 2019 BBWave. All rights reserved.
//

import UIKit
import AVFoundation

class AdvancedReadingVC: UIViewController {
    
    
    var audioPlayer : AVAudioPlayer?
    var selectedSoundFileName : String = ""
    var playedAdvanced : String = ""
    var randomAdvancedIndex : Int = 0
    var advancedArray = ["BOIL", "CHEESE", "CHICKEN", "CHURCH", "CLOCK", "CORN", "DRESS", "DUCK", "ELEPHANT", "FOOT", "GOAL", "HISS", "MOUTH", "QUEEN", "RING", "ROOF", "SEED", "SHEEP", "SHOP", "SOAP", "STAR", "TAIL", "TISSUE", "TRAIN", "TROPHY"]
    
    
    @IBOutlet weak var advancedAnswerLabel: UILabel!
    @IBOutlet weak var advancedAnswerImage: UIImageView!

    @IBOutlet weak var advancedFace01: UIButton!
    @IBOutlet weak var advancedFace02: UIButton!
    @IBOutlet weak var advancedFace03: UIButton!
    @IBOutlet weak var advancedFace04: UIButton!
    @IBOutlet weak var advancedFace05: UIButton!
    @IBOutlet weak var advancedFace06: UIButton!
    
    
// Selects a random advanced word for the question
    func randomAdvanced() {
        randomAdvancedIndex = Int.random(in: 0 ... 3)
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
        let advancedFaces = [advancedFace01, advancedFace02, advancedFace03, advancedFace04, advancedFace05, advancedFace06]
        let tag = sender.tag - 1
        if advancedFaces[tag]!.currentTitle == playedAdvanced {
            rightAnswer(sender: advancedFaces[tag]!)
            refreshAdvancedsWithDelay()
        }
        else {
            wrongAnswer(sender: advancedFaces[tag]!)
        }
        
    }
    
// Plays 'correct' audio, highlights 'correct' button and disables/enables 'correct' button
    func rightAnswer (sender: UIButton) {
        selectedSoundFileName = "ThatsCorrect.mp3"
        playAudio()
        advancedAnswerLabel.text = "CORRECT"
        advancedAnswerLabel.textColor = UIColor(rgb: 0x39ff14)
        let advancedFaces = [advancedFace01, advancedFace02, advancedFace03, advancedFace04, advancedFace05, advancedFace06]
        let tag = sender.tag - 1
        advancedFaces[tag]!.layer.cornerRadius = 5
        advancedFaces[tag]!.layer.borderColor = UIColor(rgb: 0x39ff14).cgColor
        advancedFaces[tag]!.layer.borderWidth = 8.0
        advancedFaces[tag]!.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            advancedFaces[tag]!.layer.borderWidth = 0
            advancedFaces[tag]!.isUserInteractionEnabled = true
        })
    }
    
// Plays 'wrong' audio and highlights 'wrong' button
    func wrongAnswer (sender: UIButton) {
        selectedSoundFileName = "Uhoh.mp3"
        playAudio()
        advancedAnswerLabel.text = "Wrong!   "
        advancedAnswerLabel.textColor = UIColor(rgb: 0xFB2B11)
        let advancedFaces = [advancedFace01, advancedFace02, advancedFace03, advancedFace04, advancedFace05, advancedFace06]
        let tag = sender.tag - 1
        advancedFaces[tag]!.layer.cornerRadius = 5
        advancedFaces[tag]!.layer.borderColor = UIColor(rgb: 0xFB2B11).cgColor
        advancedFaces[tag]!.layer.borderWidth = 8.0
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3, execute: {
            self.advancedAnswerLabel.text = ""
            advancedFaces[tag]!.layer.borderWidth = 0
        })
    }
    
    
    
// New question audio setup and play
    func newQuestion() {
        randomAdvanced()
        selectedSoundFileName = "WhichWordIs.mp3"
        playAudio()
        
        let possibleArray = [advancedFace01.currentTitle, advancedFace02.currentTitle, advancedFace03.currentTitle, advancedFace04.currentTitle, advancedFace05.currentTitle, advancedFace06.currentTitle]
        
        let when = DispatchTime.now() + 2.1
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.selectedSoundFileName = possibleArray[self.randomAdvancedIndex]!+".mp3"
            self.playAudio()
        }
    }
    
// Consonant button faces refresh function
    func newFaces() {
        let advancedFaces = [advancedFace01, advancedFace02, advancedFace03, advancedFace04, advancedFace05, advancedFace06]
        for (advancedFace, advanced) in zip(advancedFaces, advancedArray.shuffled()) {
            advancedFace?.setTitle(advanced, for: .normal)
        }
    }
    
    
// Establishes correct answer based on consonant audio played
    func newAnswer() {
        let possibleArray = [advancedFace01.currentTitle, advancedFace02.currentTitle, advancedFace03.currentTitle, advancedFace04.currentTitle, advancedFace05.currentTitle, advancedFace06.currentTitle]
        playedAdvanced = possibleArray[randomAdvancedIndex]!
        print(playedAdvanced)
        advancedAnswerImage.image = UIImage(named: playedAdvanced)
    }
    
// Combines functions to refresh the whole question and views
    func refreshAdvancedsWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.newFaces()
            self.newQuestion()
            self.newAnswer()
            self.advancedAnswerLabel.text = ""
        })
    }
    
// Local VC back button function
    @IBAction func dismissAdvancedReadingVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
// Local refresh button function (replays phonic audio)
    @IBAction func refreshAdvancedAudio(_ sender: Any) {
        selectedSoundFileName = "\(playedAdvanced).mp3"
        playAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newFaces()
        newQuestion()
        newAnswer()
        
    }
    
    
    
    
    
    
    @IBAction func advancedFace01Pressed(_ sender: Any) {
        checkAnswer(sender: advancedFace01)
    }
    
    @IBAction func advancedFace02Pressed(_ sender: Any) {
        checkAnswer(sender: advancedFace02)
    }
    
    
    @IBAction func advancedFace03Pressed(_ sender: Any) {
        checkAnswer(sender: advancedFace03)
    }
    
    @IBAction func advancedFace04Pressed(_ sender: Any) {
        checkAnswer(sender: advancedFace04)
    }
    
    @IBAction func advancedFace05Pressed(_ sender: Any) {
        checkAnswer(sender: advancedFace05)
    }
    
    @IBAction func advancedFace06Pressed(_ sender: Any) {
        checkAnswer(sender: advancedFace06)
    }
    
}
