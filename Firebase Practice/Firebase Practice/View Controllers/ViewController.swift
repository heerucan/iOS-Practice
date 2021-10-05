//
//  ViewController.swift
//  Firebase Practice
//
//  Created by Thisisme Hi on 2021/09/30.
//

import UIKit

import AuthenticationServices
import CryptoKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {
    
    fileprivate var currentNonce: String?
    
    // MARK: - Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAppleButton()
    }
    
    // 화면 터치 시에 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func getUserProfile() {
        // 사용자 프로필 가져오기
        if let currentEmail = FirebaseAuth.Auth.auth().currentUser?.email {
            guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "CompleteViewController")
                    as? CompleteViewController else { return }
            nextVC.text = "너의 이메일은\(currentEmail) \n로그인"
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
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
                self?.getUserProfile()
            }
        }
    }
        
    // MARK: - Apple 로그인
    func setUpAppleButton() {
        let button = ASAuthorizationAppleIDButton()
        button.addTarget(self, action: #selector(touchUpAppleButton(_:)), for: .touchUpInside)
        button.center = view.center
        view.addSubview(button)
    }
    
    @objc func touchUpAppleButton(_ sender: UIButton) {
        performSignIn()
    }
    
    func performSignIn() {
        let request = createAppleIDRequest()
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        
        authorizationController.performRequests()
    }
    
    @available(iOS 13, *)
    func createAppleIDRequest() -> ASAuthorizationAppleIDRequest {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        // 애플로그인은 사용자에게서 2가지 정보를 요구함
        request.requestedScopes = [.fullName, .email]

        let nonce = randomNonceString()
        request.nonce = sha256(nonce)
        currentNonce = nonce
        
        return request
    }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
      }.joined()

      return hashString
    }
    
    // MARK: - 회원가입
    @IBAction func signUpButton(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController")
                as? SignUpViewController else { return }
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

// MARK: - ASAuthorizationControllerDelegate
extension ViewController: ASAuthorizationControllerDelegate {
    
}

// MARK: - ASAuthorizationControllerPresentationContextProviding
extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

// Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
private func randomNonceString(length: Int = 32) -> String {
  precondition(length > 0)
  let charset: Array<Character> =
      Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
  var result = ""
  var remainingLength = length

  while remainingLength > 0 {
    let randoms: [UInt8] = (0 ..< 16).map { _ in
      var random: UInt8 = 0
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
      if errorCode != errSecSuccess {
        fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
      }
      return random
    }

    randoms.forEach { random in
      if remainingLength == 0 {
        return
      }

      if random < charset.count {
        result.append(charset[Int(random)])
        remainingLength -= 1
      }
    }
  }

  return result
}
