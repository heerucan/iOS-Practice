//
//  ViewController.swift
//  AVAudioPlayerPractice
//
//  Created by Thisisme Hi on 2022/04/15.
//

import UIKit

import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = "체이준 바보 똥쟁이 잼민이 ㅋㅋㅋ"
    }

    @IBAction func touchupPlayButton(_ sender: Any) {
        let url = Bundle.main.url(forResource: "runningman", withExtension: "mp3")
        if let url = url {
            do {
                player?.volume = 0.5
                player = try AVAudioPlayer(contentsOf: url)
                player?.prepareToPlay()
                player?.play()
            } catch {
                print(error)
            }
        }
    }
    
    @IBAction func readButton(_ sender: Any) {
        
        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: textView.text)
        
        utterance.pitchMultiplier = 0.5
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        utterance.rate = 0.5
        synthesizer.speak(utterance)
        
    }
    
    @IBAction func touchupStopButton(_ sender: Any) {
        player?.pause()
    }
}
