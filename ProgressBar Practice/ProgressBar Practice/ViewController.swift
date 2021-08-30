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

    let circleView = CircleView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupAutoLayout()
    }
    
    // MARK: - Custom Method
    func configUI() {
        circleView.frame = self.view.frame
//        circleView.backgroundColor = .clear
    }
    
    func setupAutoLayout() {
        view.addSubview(circleView)
        
        circleView.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.centerX.equalToSuperview()
        }
    }
}

