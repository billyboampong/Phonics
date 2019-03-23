//
//  ViewController.swift
//  Phonics-N
//
//  Created by Billy Boampong on 25/01/2019.
//  Copyright © 2019 BBWave. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer : AVAudioPlayer?
    var selectedSoundFileName : String = ""

    @IBOutlet weak var basicPracticeImage: UIImageView!
    @IBOutlet weak var advancedPracticeImage: UIImageView!
    @IBOutlet weak var basicPracticeLabel: UILabel!
    @IBOutlet weak var advancedPracticeLabel: UILabel!
    
    
    let phonicSoundArray = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "ai", "ar", "ch", "ck", "ee", "ie", "ng", "oa", "oi", "oo", "or", "ou", "ph", "qu", "sh", "ss", "th", "ue"]
    
    let basicWordArray = ["BAG", "BAT", "BED", "BIN", "BOY", "BUS", "CAR", "CAT", "CUP", "DOG", "FOX", "HAT", "HEN", "JAR", "LOG", "MAP", "PAN", "PEN", "PIG", "RUN", "SIT", "SUN", "TAP", "VAN", "WET"]
    
    let advancedWordArray = ["BOIL", "CHEESE", "CHICKEN", "CHURCH", "CLOCK", "CORN", "DRESS", "DUCK", "ELEPHANT", "FOOT", "GOAL", "HISS", "MOUTH", "QUEEN", "RING", "ROOF", "SEED", "SHEEP", "SHOP", "SOAP", "STAR", "TAIL", "TISSUE", "TRAIN", "TROPHY"]
    
    let altbasicWordArray = ["B-A-G", "B-A-T", "B-E-D", "B-I-N", "B-O-Y", "B-U-S", "C-A-R", "C-A-T", "C-U-P", "D-O-G", "F-O-X", "H-A-T", "H-E-N", "J-A-R", "L-O-G", "M-A-P", "P-A-N", "P-E-N", "P-I-G", "R-U-N", "S-I-T", "S-U-N", "T-A-P", "V-A-N", "W-E-T"]
    
    let altadvancedWordArray = ["B-OI-L", "CH-EE-SE", "CH-I-CK-E-N", "CH-U-R-CH", "C-L-O-CK", "C-OR-N", "D-R-E-SS", "D-U-CK", "E-L-E-PH-A-N-T", "F-OO-T", "G-OA-L", "H-I-SS", "M-OU-TH", "QU-EE-N", "R-I-NG", "R-OO-F", "S-EE-D", "SH-EE-P", "SH-O-P", "S-OA-P", "S-T-AR", "T-AI-L", "T-I-SS-UE", "T-R-AI-N", "T-R-O-PH-Y"]
    
    let consonantArray = ["B", "C", "D", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "X", "Y", "Z"]
    
    let doubleletterArray = ["ai", "ar", "ch", "ck", "ee", "ie", "ng", "oa", "oi", "oo", "or", "ou", "ph", "qu", "sh", "ss", "th", "ue"]
    
    var randomConsonantIndex : Int = 0
    var randomDoubleLettersIndex : Int = 0
    
    
    func playAudio() {
        let path = Bundle.main.path(forResource: selectedSoundFileName, ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Couldn't load audio") }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

// Global back button function for VCs without a .swift file
    @IBAction func dismissCurrentView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    
// Phonics practice audio playback
    @IBAction func phonicPracticeButtonPressed(_ sender: AnyObject) {
        
        selectedSoundFileName = phonicSoundArray[sender.tag - 1]+".mp3"
        
        playAudio()
    }

    
// Basic practice audio response
    @IBAction func basicPracticeButtonPressed(_ sender: AnyObject) {
        
        selectedSoundFileName = basicWordArray[sender.tag - 1]+".mp3"
        
        playAudio()
        
// Basic practice image response
    basicPracticeImage.image = UIImage(named: basicWordArray[sender.tag - 1])
        
// Basic practice label response
        basicPracticeLabel.text = basicWordArray[sender.tag - 1] }
    
// Basic practice label hyphen switch
    @IBAction func basicLabelPressed(_ sender: Any) {
        if let index = basicWordArray.firstIndex(of:basicPracticeLabel.text!) {
            basicPracticeLabel.text = altbasicWordArray[index] } }
    
    
// Advanced practice audio response
    @IBAction func advancedPracticeButtonPressed(_ sender: AnyObject) {
    
        selectedSoundFileName = advancedWordArray[sender.tag - 1]+".mp3"
        
      playAudio()
        
// Advanced practice image response
        advancedPracticeImage.image = UIImage(named: advancedWordArray[sender.tag - 1])
        
// Advanced practice label response
        advancedPracticeLabel.text = advancedWordArray[sender.tag - 1] }
    
// Advanced practice label hyphen switch
    @IBAction func advancedLabelPressed(_ sender: Any) {
        if let index = advancedWordArray.firstIndex(of:advancedPracticeLabel.text!) {
            advancedPracticeLabel.text = altadvancedWordArray[index] } }

    
}



