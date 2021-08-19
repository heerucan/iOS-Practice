//
//  ViewController.swift
//  prac
//
//  Created by Thisisme Hi on 2021/07/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func nextButton(_ sender: Any) {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(dataReceived(_:)),
                                               name: NSNotification.Name("sample"),
                                               object: nil)
    }
    
    @objc func dataReceived(_ notification: Notification) {
        
        if let text = notification.object as? String {
            dataLabel.text = text
        }
        
    }
}

