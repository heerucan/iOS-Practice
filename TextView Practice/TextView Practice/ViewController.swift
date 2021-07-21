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
    let textView = UITextView().then {
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
    }
    
    // MARK: - Custom Method
    func configUI() {
        view.backgroundColor = .black
    }
    
    func setupAutoLayout() {
        view.addSubview(textView)
        view.addSubview(letterNumLabel)

        textView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(190)
            make.width.equalTo(319)
        }
        
        letterNumLabel.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(6)
            make.trailing.equalToSuperview().inset(28)
        }
    }
}

extension ViewController: UITextViewDelegate {
    
}
