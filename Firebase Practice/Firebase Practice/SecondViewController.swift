//
//  SecondViewController.swift
//  Firebase Practice
//
//  Created by Thisisme Hi on 2021/10/01.
//

import UIKit

import FirebaseAuth

class SecondViewController: UIViewController {
    
    var text: String?

    @IBOutlet weak var successLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationController?.isNavigationBarHidden = true
        
        if let text = text {
            successLabel.text = text
        }
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        do { // 로그아웃
            try FirebaseAuth.Auth.auth().signOut()
            navigationController?.popViewController(animated: true)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
