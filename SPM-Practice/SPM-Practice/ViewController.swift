//
//  ViewController.swift
//  SPM-Practice
//
//  Created by heerucan on 2022/04/24.
//

import UIKit
import WALKit

class ViewController: UIViewController {
    
    let myLabel: UILabel = {
        let label = UILabel()
        label.font = WALFont.title1.font
        label.textColor = .black
        label.text = "안녕하세요. 김루희입니다. 요를레이"
        return label
    }()
    
    let secondLabel: UILabel = {
        let label = UILabel()
        label.font = WALFont.body6.font
        label.textColor = .black
        label.text = "Body6/regular | 16px | 22"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myLabel)
        view.addSubview(secondLabel)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        myLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
        
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        secondLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
    }


}

