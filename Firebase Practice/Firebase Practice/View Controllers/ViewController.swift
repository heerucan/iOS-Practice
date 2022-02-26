//
//  ViewController.swift
//  Firebase Practice
//
//  Created by Thisisme Hi on 2021/09/30.
//

import UIKit

import AuthenticationServices
import CryptoKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import SnapKit
import Then

class ViewController: UIViewController {

    // MARK: - Properties
    fileprivate var currentNonce: String?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    let button = ASAuthorizationAppleIDButton().then {
        $0.addTarget(self, action: #selector(touchUpAppleButton(_:)), for: .touchUpInside)
        $0.layer.cornerRadius = 7
        $0.clipsToBounds = true
    }
    
    let loginButton = FBLoginButton()
    
    private let appleButton = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .whiteOutline).then {
        $0.addTarget(self, action: #selector(touchupAppleLoginButton), for: .touchUpInside)
    }
        
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 이부분
        view.addSubview(loginButton)
        loginButton.center = view.center
//        let facebookToken = AccessToken.current!.tokenString
//        let credential = FacebookAuthProvider.credential(withAccessToken: facebookToken)
//        FirebaseAuth.Auth.auth().signIn(with: credential) { (result, error) in
//          if let error = error {
//            print("Firebase auth fails with error: \(error.localizedDescription)")
//          } else if let result = result {
//            print("Firebase login succeeds")
//          }
//        }
        loginButton.permissions = ["public_profile", "email"]

        view.addSubview(button)
        view.addSubview(appleButton)
        
        button.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(415)
            make.leading.trailing.equalToSuperview().inset(40)
            make.width.equalTo(334)
            make.height.equalTo(50)
        }
        
        appleButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
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
            guard let self = self else { return }
            // 에러가 나거나 유저가 없을 경우
            if let error = error, user == nil {
                let alert = UIAlertController(
                    title: "로그인 실패",
                    message: error.localizedDescription,
                    preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "확인", style: .default))
                self.present(alert, animated: true, completion: nil)
                
            } else { // 성공이면 화면전환하고 프로필 가져오기
                self.getUserProfile()
            }
        }
    }
        
    // MARK: - 애플로그인
    @objc func touchUpAppleButton(_ sender: UIButton) {
        let request = createAppleIDRequest()
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    // MARK: - 파베말고 찐 애플로그인
    @objc func touchupAppleLoginButton() {
        // provider를 만들어서 요청해야하고 원하는 정보도 입력해야 함
        let authorizationProvider = ASAuthorizationAppleIDProvider()
        let request = authorizationProvider.createRequest()
        request.requestedScopes = [.email, .fullName]
        
        /// authorizationController를 만들고 delegate를 현재 뷰컨으로 위임처리한다.
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
@available(iOS 13.0, *)
extension ViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let realAppleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
            let identityToken = String(data: realAppleIDCredential.identityToken ?? Data(), encoding: .utf8),
            let authCode = String(data: realAppleIDCredential.authorizationCode ?? Data(), encoding: .utf8)
        else { return }
        
        print("찐찐찐apple Token : ", identityToken)
        print("찐authCode : ", authCode)
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // 몇 가지 표준 키 검사를 수행
            // 1. 현재 nonce가 설정되어 있는지 확인
            guard let nonce = currentNonce else {
                return print("nonce 에러")
//                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            
            // 2. ID 토큰을 검색하여
            guard let appleIDtoken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            
            // 문자열로 변환
            guard let idTokenString = String(data: appleIDtoken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDtoken.debugDescription)")
                return
            }
            print("ID토큰", appleIDtoken)
            print("문자열로변환", idTokenString)
            
            
            // nonce와 IDToken을 사용하여 OAuth 공급자에게 방금 로그인한 사용자를 나타내는 자격증명을 생성하도록 요청
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            
            // 이 자격증명을 사용하여 Firebase에 로그인할 것이다.
            // Firebase는 자격증명을 확인하고 유효한 경우 사용자를 로그인시켜 줄 것이다.
            // 새 사용자인 경우에 Firebase는 ID 토큰에 제공된 정보를 사용하여 새 사용자 계정을 만들 것이다.
            FirebaseAuth.Auth.auth().signIn(with: credential) { [weak self] (authDataResult, error) in
                guard let self = self else { return }
                // 인증 결과에서 Firebase 사용자를 검색하고 사용자 정보를 표시할 수 있다.
                if let user = authDataResult?.user {
                    print("애플 로그인 성공!", user.uid, user.refreshToken, user.email ?? "-")
                    guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "CompleteViewController")
                            as? CompleteViewController else { return }
                    nextVC.text = "너의 이메일은\(user.email ?? "") \n애플로그인"
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }
                
                if error != nil {
                    print(error?.localizedDescription ?? "error" as Any)
                    return
                }
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("Sign in with Apple errored: \(error)")
      }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding
@available(iOS 13.0, *)
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
