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
    
    // 화면 터치 시에 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
              let pw = pwTextField.text, !pw.isEmpty,
              let name = nameTextField.text, !name.isEmpty,
              let nickname = nicknameTextField.text, !nickname.isEmpty else {
                  print("다 입력해주세요.")
                  return
              }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: pw) { (result, error) in
            if error != nil { // error가 nil이 아니다 => error에 뭐가 있다? => error가 있다는 뜻
                print("회원가입 실패")
                
            } else {
                // 데이터 추가
                let db = Firestore.firestore()
                var ref: DocumentReference? = nil
                ref = db.collection("users").addDocument(data: ["이름":name,
                                                                "닉네임":nickname,
                                                                "이메일":email,
                                                                "uid":result!.user.uid]) { (error) in
                    
                    if error != nil {
                        print(error?.localizedDescription ?? "사용자 데이터 저장 오류")
                    } else {
                        print("데이터 추가", ref!.documentID)
                    }
                }
                // home으로 화면전환
                guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "CompleteViewController") as? CompleteViewController
                else { return }
                nextVC.text = "회원가입"
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
}



