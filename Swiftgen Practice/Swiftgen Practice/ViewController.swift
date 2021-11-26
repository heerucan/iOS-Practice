//
//  ViewController.swift
//  Swiftgen Practice
//
//  Created by Thisisme Hi on 2021/11/27.
//

import UIKit

class ViewController: UIViewController {
    
    let label = UILabel()
    let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Asset.Colors.catchmePink.color
        label.textColor = Asset.Colors.btobBlue.color
        imageView.image = Asset.Assets.icBall.image
        label.font = FontFamily.NeoDunggeunmo.regular.font(size: 23)
    }


}


