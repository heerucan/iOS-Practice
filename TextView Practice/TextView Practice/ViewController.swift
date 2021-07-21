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
            make.centerX.centerY.equalToSuperview()
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
        activityTextView.text = placeholder
        activityTextView.textColor = .gray200
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) /// 화면을 누르면 키보드 내려가게 하는 것
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        activityTextView.layer.borderWidth = 1
        activityTextView.layer.borderColor = UIColor.pink100.cgColor
        
        /// 플레이스홀더
        if textView.text.isEmpty {
            activityTextView.textColor = .gray200
            activityTextView.text = placeholder
        } else if textView.text == placeholder {
            activityTextView.textColor = .white
            activityTextView.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        activityTextView.layer.borderWidth = 0
        
        /// 플레이스홀더
        if textView.text.isEmpty {
            activityTextView.textColor = .gray200
            activityTextView.text = placeholder
        }
    }
}
