//
//  BasicReadingVC.swift
//  Phonics-N
//
//  Created by Billy Boampong on 03/04/2019.
//  Copyright © 2019 BBWave. Basic rights reserved.
//

import UIKit
import AVFoundation

class BasicReadingVC: UIViewController {


    var audioPlayer : AVAudioPlayer?
    var selectedSoundFileName : String = ""
    var playedBasic : String = ""
    var randomBasicIndex : Int = 0
    var basicArray = ["BAG", "BAT", "BED", "BIN", "BOY", "BUS", "CAR", "CAT", "CUP", "DOG", "FOX", "HAT", "HEN", "JAR", "LOG", "MAP", "PAN", "PEN", "PIG", "RUN", "SIT", "SUN", "TAP", "VAN", "WET"]
    
    
    @IBOutlet weak var basicAnswerLabel: UILabel!
    @IBOutlet weak var basicAnswerImage: UIImageView!
    
    @IBOutlet weak var basicFace01: UIButton!
    @IBOutlet weak var basicFace02: UIButton!
    @IBOutlet weak var basicFace03: UIButton!
    @IBOutlet weak var basicFace04: UIButton!
    
    
// Selects a random basic word for the question
    func randomBasic() {
        randomBasicIndex = Int.random(in: 0 ... 3)
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
        let basicFaces = [basicFace01, basicFace02, basicFace03, basicFace04]
        let tag = sender.tag - 1
        if basicFaces[tag]!.currentTitle == playedBasic {
            rightAnswer(sender: basicFaces[tag]!)
            refreshBasicsWithDelay()
        }
        else {
            wrongAnswer(sender: basicFaces[tag]!)
        }
        
    }
    
// Plays 'correct' audio, highlights 'correct' button and disables/enables 'correct' button
    func rightAnswer (sender: UIButton) {
        selectedSoundFileName = "ThatsCorrect.mp3"
        playAudio()
//
        let basicFaces = [basicFace01, basicFace02, basicFace03, basicFace04]
        let tag = sender.tag - 1
        basicFaces[tag]!.layer.cornerRadius = 5
        basicFaces[tag]!.layer.borderColor = UIColor(rgb: 0x39ff14).cgColor
        basicFaces[tag]!.layer.borderWidth = 8.0
        basicFaces[tag]!.isUserInteractionEnabled = false
        basicAnswerLabel.text = basicFaces[tag]!.currentTitle
        basicAnswerLabel.textColor = UIColor(rgb: 0x000000)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            basicFaces[tag]!.layer.borderWidth = 0
            basicFaces[tag]!.isUserInteractionEnabled = true
        })
    }
    
// Plays 'wrong' audio and highlights 'wrong' button
    func wrongAnswer (sender: UIButton) {
        selectedSoundFileName = "Uhoh.mp3"
        playAudio()
        basicAnswerLabel.text = "WRONG :("
        basicAnswerLabel.textColor = UIColor(rgb: 0xFB2B11)
        let basicFaces = [basicFace01, basicFace02, basicFace03, basicFace04]
        let tag = sender.tag - 1
        basicFaces[tag]!.layer.cornerRadius = 5
        basicFaces[tag]!.layer.borderColor = UIColor(rgb: 0xFB2B11).cgColor
        basicFaces[tag]!.layer.borderWidth = 8.0
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3, execute: {
            self.basicAnswerLabel.text = ""
            basicFaces[tag]!.layer.borderWidth = 0
        })
    }
    
    
    
// New question audio setup and play
    func newQuestion() {
        randomBasic()
        selectedSoundFileName = "WhichOneIs.mp3"
        playAudio()
        
        let possibleArray = [basicFace01.currentTitle, basicFace02.currentTitle, basicFace03.currentTitle, basicFace04.currentTitle]
        
        let when = DispatchTime.now() + 1.7
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.selectedSoundFileName = possibleArray[self.randomBasicIndex]!+".mp3"
            self.playAudio()
        }
    }
    
// Consonant button faces refresh function
    func newFaces() {
        let basicFaces = [basicFace01, basicFace02, basicFace03, basicFace04]
        for (basicFace, basic) in zip(basicFaces, basicArray.shuffled()) {
            basicFace?.setTitle(basic, for: .normal)
        }
    }
    
    
// Establishes correct answer based on consonant audio played
    func newAnswer() {
        let possibleArray = [basicFace01.currentTitle, basicFace02.currentTitle, basicFace03.currentTitle, basicFace04.currentTitle]
        playedBasic = possibleArray[randomBasicIndex]!
        print(playedBasic)
        basicAnswerImage.image = UIImage(named: playedBasic)
    }
    
// Combines functions to refresh the whole question and views
    func refreshBasicsWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.newFaces()
            self.newQuestion()
            self.newAnswer()
            self.basicAnswerLabel.text = ""
        })
    }
    
// Local VC back button function
    @IBAction func dismissBasicReadingVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
// Local refresh button function (replays phonic audio)
    @IBAction func refreshBasicAudio(_ sender: Any) {
        selectedSoundFileName = "\(playedBasic).mp3"
        playAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newFaces()
        newQuestion()
        newAnswer()
        
    }
    
    
    
    
    
    
    @IBAction func basicFace01Pressed(_ sender: Any) {
        checkAnswer(sender: basicFace01)
    }
    
    @IBAction func basicFace02Pressed(_ sender: Any) {
        checkAnswer(sender: basicFace02)
    }
    
    
    @IBAction func basicFace03Pressed(_ sender: Any) {
        checkAnswer(sender: basicFace03)
    }
    
    @IBAction func basicFace04Pressed(_ sender: Any) {
        checkAnswer(sender: basicFace04)
    }
    
    
    
}
