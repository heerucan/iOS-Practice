//
//  SecondViewController.swift
//  prac
//
//  Created by Thisisme Hi on 2021/07/29.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var dataTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func dataSendButtonClicked(_ sender: Any) {
        
        if let text = dataTextField.text {
            
            NotificationCenter.default.post(name: NSNotification.Name("sample"), object: text)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
