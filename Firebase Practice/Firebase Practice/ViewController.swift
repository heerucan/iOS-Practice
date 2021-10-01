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
    
    // MARK: - 로그인
    @IBAction func signInButton(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let pw = pwTextField.text, !pw.isEmpty else {
                  print("이메일과 패스워드를 입력해주세요.")
                  return
              }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: pw) { [weak self] user, error in
            if let error = error, user == nil {
                let alert = UIAlertController(
                    title: "로그인 실패",
                    message: error.localizedDescription,
                    preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "확인", style: .default))
                self?.present(alert, animated: true, completion: nil)
                
            } else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let nextVC = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
                        as? SecondViewController else { return }
                nextVC.text = "로그인 성공"
                self?.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
        
    }
    
    // MARK: - 회원가입
    @IBAction func signUpButton(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let pw = pwTextField.text, !pw.isEmpty else {
                  print("텍스트필드에 안써줬다.")
                  return
              }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: pw) { authResult, error in
            if error == nil { // error가 아닌 경우
                FirebaseAuth.Auth.auth().signIn(withEmail: email, password: pw)
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let nextVC = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
                        as? SecondViewController else { return }
                nextVC.text = "회원가입 성공"
                self.navigationController?.pushViewController(nextVC, animated: true)
                
            } else {
                print(error?.localizedDescription ?? "회원가입 실패")
            }
        }
    }
}


