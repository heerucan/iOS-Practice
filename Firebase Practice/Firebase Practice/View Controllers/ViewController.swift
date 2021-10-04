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
            // 에러가 나거나 유저가 없을 경우
            if let error = error, user == nil {
                let alert = UIAlertController(
                    title: "로그인 실패",
                    message: error.localizedDescription,
                    preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "확인", style: .default))
                self?.present(alert, animated: true, completion: nil)
                
            } else {
                guard let nextVC = self?.storyboard?.instantiateViewController(withIdentifier: "CompleteViewController")
                        as? CompleteViewController else { return }
                nextVC.text = "로그인"
                self?.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
    
    // MARK: - Apple 로그인
    @IBAction func appleButton(_ sender: UIButton) {
        
    }
        
    // MARK: - 회원가입
    @IBAction func signUpButton(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController")
                as? SignUpViewController else { return }
        navigationController?.pushViewController(nextVC, animated: true)
    }
}


