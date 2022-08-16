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
        textView.text = "오늘 우체국에서 한바탕했어 너에게 내 사랑을 담아 보내려고했는데 그정도 크기의 박스는 없대"
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
        
        utterance.pitchMultiplier = 1
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        utterance.rate = 0.5
        synthesizer.speak(utterance)
        
    }
    
    @IBAction func touchupStopButton(_ sender: Any) {
        player?.pause()
    }
}
