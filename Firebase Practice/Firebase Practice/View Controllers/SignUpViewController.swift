//
//  SignUpViewController.swift
//  Firebase Practice
//
//  Created by Thisisme Hi on 2021/10/02.
//

import UIKit

import FirebaseAuth
import Firebase
import FirebaseFirestore

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

    // Validate the TextFields
    func validateField() -> String? {
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            nicknameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            pwTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "빈 칸을 모두 입력해주세요"
        }
        return nil // 모든 게 괜찮으면 nil을 반환
    }
    
    // 회원가입
    @IBAction func signUpButton(_ sender: UIButton) {
        
//        let error = validateField()
        
        guard let email = emailTextField.text, !email.isEmpty,
              let pw = pwTextField.text, !pw.isEmpty else {
                  print("다 입력해주세요.")
                  return
              }
        
        let name = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let nickname = nicknameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: pw) { (result, error) in

            if error != nil {
                print("회원가입 실패")
            } else {
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: ["이름":name,
                                                          "닉네임":nickname,
                                                          "uid":result!.user.uid]) { (error) in
                    
                    if error != nil {
                        print(error?.localizedDescription ?? "사용자 데이터 저장 오류")
                    }
                    
                }
               // home으로 화면전환
                guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "CompleteViewController") as? CompleteViewController else { return }
                nextVC.text = "회원가입"
                self.navigationController?.pushViewController(nextVC, animated: true)
                
            }
        }
    }
}
