//
//  ViewController.swift
//  Delegate Practice
//
//  Created by Thisisme Hi on 2021/11/03.
//

import UIKit

import SnapKit
import Then

class ViewController: UIViewController, CustomViewDelegate {
    
    private lazy var customView = CustomView().then {
        $0.backgroundColor = .systemOrange
        $0.delegate = self // customView의 대리인 = VC
        
        
        /// 이렇게 customView에 있는 button을 불러와서 팝업뷰가 열리는 것으로 구현해줄 수 있지만
        /// delegate를 써서 구현해보겠음
        // $0.button.addTarget(self, action: #selector(작동메소드), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        view.addSubview(customView)
        
        customView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func clickButtonToPresentPopup() {
        let alert = UIAlertController(title: "열렸니???",
                                      message: "그럼 델리게이트 성공한겨..",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인",
                                     style: .default,
                                     handler: { _ in })
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

