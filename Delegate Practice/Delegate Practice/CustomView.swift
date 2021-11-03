//
//  CustomView.swift
//  Delegate Practice
//
//  Created by Thisisme Hi on 2021/11/03.
//

import UIKit

import SnapKit
import Then

// 
protocol CustomViewDelegate: AnyObject {
    func clickButtonToPresentPopup()
}

class CustomView: UIView {
    
    weak var delegate: CustomViewDelegate?

    private lazy var button = UIButton().then {
        $0.layer.cornerRadius = 20
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        $0.backgroundColor = .brown
        $0.setTitle("CustomView 안에 있는 버튼인 나를 눌러봐..", for: .normal)
        $0.addTarget(self, action: #selector(touchupButton(_:)), for: .touchUpInside)
    }

    override init(frame: CGRect) {
            super.init(frame: frame)
        
        self.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 팝업을 띄우는 버튼
    // 그러나 현재로써는 팝업을 띄울 수 없음 왜냐하면 UIView에 속해있기 때문
    @objc func touchupButton(_ sender: UIButton) {
        delegate?.clickButtonToPresentPopup()
    }
}
