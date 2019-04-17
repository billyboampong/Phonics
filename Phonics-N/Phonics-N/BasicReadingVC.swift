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
    var correctArray = ["ThatsCorrect", "Amazing", "WellDone", "Wow"]
    var wrongArray = ["Uhoh", "TryAgain", "Wrong", "No"]
    var randomResponse : Int = 0
    
    
    @IBOutlet weak var basicAnswerLabel: UILabel!
    @IBOutlet weak var basicAnswerImage: UIImageView!
    
    @IBOutlet weak var basicFace01: UIButton!
    @IBOutlet weak var basicFace02: UIButton!
    @IBOutlet weak var basicFace03: UIButton!
    @IBOutlet weak var basicFace04: UIButton!
    @IBOutlet weak var basicFace05: UIButton!
    @IBOutlet weak var basicFace06: UIButton!
    
    
    
// Selects a random basic word for the question
    func randomBasic() {
        randomBasicIndex = Int.random(in: 0 ... 5)
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
        let basicFaces = [basicFace01, basicFace02, basicFace03, basicFace04, basicFace05, basicFace06]
        let tag = sender.tag - 1
        if basicFaces[tag]!.currentTitle == playedBasic {
            rightAnswer(sender: basicFaces[tag]!)
            perform(#selector(refreshBasicsWithDelay), with: nil, afterDelay: 3.0)
        }
        else {
            wrongAnswer(sender: basicFaces[tag]!)
        }
        
    }
    
// Plays 'correct' audio, highlights 'correct' button and disables/enables 'correct' button
    func rightAnswer (sender: UIButton) {
        randomResponse = Int.random(in: 0 ... 3)
        selectedSoundFileName = "\(correctArray[randomResponse]).mp3"
        playAudio()
        basicAnswerLabel.text = "CORRECT"
        basicAnswerLabel.textColor = UIColor(rgb: 0x39ff14)
        let basicFaces = [basicFace01, basicFace02, basicFace03, basicFace04, basicFace05, basicFace06]
        let tag = sender.tag - 1
        basicFaces[tag]!.layer.cornerRadius = 5
        basicFaces[tag]!.layer.borderColor = UIColor(rgb: 0x39ff14).cgColor
        basicFaces[tag]!.layer.borderWidth = 8.0
        basicFaces[0]!.isUserInteractionEnabled = false
        basicFaces[1]!.isUserInteractionEnabled = false
        basicFaces[2]!.isUserInteractionEnabled = false
        basicFaces[3]!.isUserInteractionEnabled = false
        basicFaces[4]!.isUserInteractionEnabled = false
        basicFaces[5]!.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            basicFaces[tag]!.layer.borderWidth = 0
            basicFaces[0]!.isUserInteractionEnabled = true
            basicFaces[1]!.isUserInteractionEnabled = true
            basicFaces[2]!.isUserInteractionEnabled = true
            basicFaces[3]!.isUserInteractionEnabled = true
            basicFaces[4]!.isUserInteractionEnabled = true
            basicFaces[5]!.isUserInteractionEnabled = true
        })
    }
    
// Plays 'wrong' audio and highlights 'wrong' button
    func wrongAnswer (sender: UIButton) {
        randomResponse = Int.random(in: 0 ... 3)
        selectedSoundFileName = "\(wrongArray[randomResponse]).mp3"
        playAudio()
        basicAnswerLabel.text = "Wrong...     "
        basicAnswerLabel.textColor = UIColor(rgb: 0xFB2B11)
        let basicFaces = [basicFace01, basicFace02, basicFace03, basicFace04, basicFace05, basicFace06]
        let tag = sender.tag - 1
        basicFaces[tag]!.layer.cornerRadius = 5
        basicFaces[tag]!.layer.borderColor = UIColor(rgb: 0xFB2B11).cgColor
        basicFaces[tag]!.layer.borderWidth = 8.0
        basicFaces[0]!.isUserInteractionEnabled = false
        basicFaces[1]!.isUserInteractionEnabled = false
        basicFaces[2]!.isUserInteractionEnabled = false
        basicFaces[3]!.isUserInteractionEnabled = false
        basicFaces[4]!.isUserInteractionEnabled = false
        basicFaces[5]!.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3, execute: {
            basicFaces[0]!.isUserInteractionEnabled = true
            basicFaces[1]!.isUserInteractionEnabled = true
            basicFaces[2]!.isUserInteractionEnabled = true
            basicFaces[3]!.isUserInteractionEnabled = true
            basicFaces[4]!.isUserInteractionEnabled = true
            basicFaces[5]!.isUserInteractionEnabled = true
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3, execute: {
            self.basicAnswerLabel.text = ""
            basicFaces[tag]!.layer.borderWidth = 0
        })
    }
    
    
    
// New question audio setup and play
    func newQuestion() {
        randomBasic()
        selectedSoundFileName = "WhichWordIs.mp3"
        playAudio()
        
        let possibleArray = [basicFace01.currentTitle, basicFace02.currentTitle, basicFace03.currentTitle, basicFace04.currentTitle, basicFace05.currentTitle, basicFace06.currentTitle]
        
        let when = DispatchTime.now() + 2.1
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.selectedSoundFileName = possibleArray[self.randomBasicIndex]!+".mp3"
            self.playAudio()
        }
    }
    
// Consonant button faces refresh function
    func newFaces() {
        let basicFaces = [basicFace01, basicFace02, basicFace03, basicFace04, basicFace05, basicFace06]
        for (basicFace, basic) in zip(basicFaces, basicArray.shuffled()) {
            basicFace?.setTitle(basic, for: .normal)
        }
    }
    
    
// Establishes correct answer based on basic audio played
    func newAnswer() {
        let possibleArray = [basicFace01.currentTitle, basicFace02.currentTitle, basicFace03.currentTitle, basicFace04.currentTitle, basicFace05.currentTitle, basicFace06.currentTitle]
        playedBasic = possibleArray[randomBasicIndex]!
        print(playedBasic)
        basicAnswerImage.image = UIImage(named: playedBasic)
    }
    
// Combines functions to refresh the whole question and views
    @objc func refreshBasicsWithDelay() {
            self.newFaces()
            self.newQuestion()
            self.newAnswer()
            self.basicAnswerLabel.text = ""
    }
    
// Local VC back button function
    @IBAction func dismissBasicReadingVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        NSObject.cancelPreviousPerformRequests(withTarget: self)
    }
    
// Local refresh button function (replays phonic audio)
    @IBAction func refreshBasicAudio(_ sender: Any) {
        selectedSoundFileName = "\(playedBasic).mp3"
        playAudio()
    }
    
// Image press function (replays word audio)
    @IBAction func basicImagePressed(_ sender: Any) {
        selectedSoundFileName = "\(playedBasic).mp3"
        playAudio()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        basicFace01.titleLabel?.adjustsFontSizeToFitWidth = true
        basicFace01.titleLabel?.minimumScaleFactor = 0.5
        basicFace01.contentEdgeInsets = UIEdgeInsets(top: 7,left: 7,bottom: 7,right: 7)
        
        basicFace02.titleLabel?.adjustsFontSizeToFitWidth = true
        basicFace02.titleLabel?.minimumScaleFactor = 0.5
        basicFace02.contentEdgeInsets = UIEdgeInsets(top: 7,left: 7,bottom: 7,right: 7)
        
        basicFace03.titleLabel?.adjustsFontSizeToFitWidth = true
        basicFace03.titleLabel?.minimumScaleFactor = 0.5
        basicFace03.contentEdgeInsets = UIEdgeInsets(top: 7,left: 7,bottom: 7,right: 7)
        
        basicFace04.titleLabel?.adjustsFontSizeToFitWidth = true
        basicFace04.titleLabel?.minimumScaleFactor = 0.5
        basicFace04.contentEdgeInsets = UIEdgeInsets(top: 7,left: 7,bottom: 7,right: 7)
        
        basicFace05.titleLabel?.adjustsFontSizeToFitWidth = true
        basicFace05.titleLabel?.minimumScaleFactor = 0.5
        basicFace05.contentEdgeInsets = UIEdgeInsets(top: 7,left: 7,bottom: 7,right: 7)
        
        basicFace06.titleLabel?.adjustsFontSizeToFitWidth = true
        basicFace06.titleLabel?.minimumScaleFactor = 0.5
        basicFace06.contentEdgeInsets = UIEdgeInsets(top: 7,left: 7,bottom: 7,right: 7)
        
        
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
    
    @IBAction func basicFace05Pressed(_ sender: Any) {
        checkAnswer(sender: basicFace05)
    }
    
    @IBAction func basicFace06Pressed(_ sender: Any) {
        checkAnswer(sender: basicFace06)
    }
    
}
