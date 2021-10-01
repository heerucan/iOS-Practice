//
//  SignUpViewController.swift
//  Firebase Practice
//
//  Created by Thisisme Hi on 2021/10/02.
//

import UIKit

import FirebaseAuth

class SignUpViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = ""
    }

    // 회원가입
    @IBAction func signUpButton(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let pw = pwTextField.text, !pw.isEmpty else {
                  print("다 입력해주세요.")
                  return
              }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: pw) { authResult, error in
            if error == nil { // error가 아닌 경우
                FirebaseAuth.Auth.auth().signIn(withEmail: email, password: pw)
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let nextVC = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
                        as? CompleteViewController else { return }
                nextVC.text = "회원가입 성공"
                self.navigationController?.pushViewController(nextVC, animated: true)
                
            } else {
                print(error?.localizedDescription ?? "회원가입 실패")
            }
        }
    }
}
