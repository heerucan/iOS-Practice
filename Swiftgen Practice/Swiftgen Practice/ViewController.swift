//
//  ViewController.swift
//  Swiftgen Practice
//
//  Created by Thisisme Hi on 2021/11/27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Asset.Colors.catchmePink.color
        
        nextButton.setTitle("화면이동하자", for: .normal)
        nextButton.titleLabel?.font = FontFamily.NeoDunggeunmo.regular.font(size: 15)
        nextButton.backgroundColor = Asset.Colors.Rainbow.powerBlack.color
        nextButton.setTitleColor(Asset.Colors.Rainbow.peachPink.color, for: .normal)
    }

    @IBAction func nextButton(_ sender: Any) {
        let vc = StoryboardScene.Main.secondViewController.instantiate()
        vc.view.backgroundColor = Asset.Colors.btobBlue.color
        present(vc, animated: true, completion: nil)
    }
    
}
