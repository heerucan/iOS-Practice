//
//  ViewController.swift
//  ProgressBar Practice
//
//  Created by Thisisme Hi on 2021/08/30.
//

import UIKit

import SnapKit
import Then

class ViewController: UIViewController {
    // MARK: - Properties

    let catchuView = UIView().then {
        $0.layer.cornerRadius = 90
        $0.backgroundColor = .systemPink
    }
    
    let circleView = CircleView().then {
        $0.backgroundColor = .clear
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupAutoLayout()
    }
    
    // MARK: - Custom Method
    func configUI() {
        circleView.frame = self.view.frame
    }
    
    func setupAutoLayout() {
        view.addSubview(catchuView)
        view.addSubview(circleView)
        
        catchuView.snp.makeConstraints { make in
            make.centerX.equalTo(circleView.snp.centerX)
            make.centerY.equalTo(circleView.snp.centerY)
            make.width.height.equalTo(180)
        }
        
        circleView.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.centerX.equalToSuperview()
        }
    }
}

