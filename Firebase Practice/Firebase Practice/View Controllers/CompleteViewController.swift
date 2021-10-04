//
//  SecondViewController.swift
//  Firebase Practice
//
//  Created by Thisisme Hi on 2021/10/01.
//

import UIKit

import FirebaseAuth

class CompleteViewController: UIViewController {
    
    // MARK: - Properties
    var text: String?

    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var label: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationItem.title = ""
        
        if let text = text {
            label.text = "\(text) 성공이다. 환영한다. 마코카. 자. 이제 나가도록 하자. 잘가라."
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
