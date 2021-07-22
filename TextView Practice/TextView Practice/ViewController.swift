//
//  ViewController.swift
//  TextView Practice
//
//  Created by Thisisme Hi on 2021/07/20.
//

import UIKit

import Then
import SnapKit

class ViewController: UIViewController {
    // MARK: - Properties
    let placeholder = "(예 : 오늘 아침에 일어나서 중랑천 2.5km 뛰었음)"
    
    let activityTextView = UITextView().then {
        $0.font = .systemFont(ofSize: 14)
        $0.layer.cornerRadius = 18
        $0.backgroundColor = .black200
        $0.tintColor = .pink100
        $0.textContainerInset = UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
    }
    
    let letterNumLabel = UILabel().then {
        $0.text = "0/150"
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .gray200
        $0.textAlignment = .right
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupAutoLayout()
        setupTextView()
    }
    
    // MARK: - Custom Method
    func configUI() {
        view.backgroundColor = .black
    }
    
    func setupAutoLayout() {
        view.addSubview(activityTextView)
        view.addSubview(letterNumLabel)
        
        activityTextView.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.centerX.equalToSuperview()
            make.height.equalTo(190)
            make.width.equalTo(319)
        }
        
        letterNumLabel.snp.makeConstraints { make in
            make.top.equalTo(activityTextView.snp.bottom).offset(6)
            make.trailing.equalToSuperview().inset(28)
        }
    }
    
    func setupTextView() {
        activityTextView.delegate = self
        activityTextView.text = placeholder /// 초반 placeholder 생성
        activityTextView.textColor = .gray200 /// 초반 placeholder 색상 설정
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) /// 화면을 누르면 키보드 내려가게 하는 것
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        /// 텍스트뷰 입력 시 테두리 생기게 하기
        activityTextView.layer.borderWidth = 1
        activityTextView.layer.borderColor = UIColor.pink100.cgColor
        
        /// 플레이스홀더
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            activityTextView.textColor = .gray200
            activityTextView.text = placeholder
        } else if textView.text == placeholder {
            activityTextView.textColor = .white
            activityTextView.text = nil
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        /// 글자 수 제한
        if activityTextView.text.count > 150 {
            activityTextView.deleteBackward()
        }
        
        /// 아래 글자 수 표시되게 하기
        letterNumLabel.text = "\(activityTextView.text.count)/150"
        
        /// 글자 수 부분 색상 변경
        let attributedString = NSMutableAttributedString(string: "\(activityTextView.text.count)/150")
        attributedString.addAttribute(.foregroundColor, value: UIColor.pink100, range: ("\(activityTextView.text.count)/150" as NSString).range(of:"\(activityTextView.text.count)"))
        letterNumLabel.attributedText = attributedString
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        /// 텍스트뷰 입력 완료시 테두리 없애기
        activityTextView.layer.borderWidth = 0
        
        /// 플레이스홀더
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || textView.text == placeholder {
            activityTextView.textColor = .gray200
            activityTextView.text = placeholder
            letterNumLabel.textColor = .gray200 /// 텍스트 개수가 0일 경우에는 글자 수 표시 색상이 모두 gray 색이게 설정
            letterNumLabel.text = "0/150"
        }
    }
}
