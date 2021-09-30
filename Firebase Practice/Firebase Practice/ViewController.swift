//
//  ViewController.swift
//  Firebase Practice
//
//  Created by Thisisme Hi on 2021/09/30.
//

import UIKit

import FirebaseAuth

class ViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let pw = pwTextField.text, !pw.isEmpty else {
                  print("텍스트필드에 안써줬다.")
                  return
              }
        
        // 회원가입
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: pw) { authResult, error in
            guard let user = authResult?.user else { return }
            if error == nil { // error가 아닌 경우
                print("user------------------------")
                print(user)
            } else {
                print(error?.localizedDescription ?? "회원가입 실패")
            }
        }
    }
}

