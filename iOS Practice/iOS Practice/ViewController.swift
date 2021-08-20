//
//  ViewController.swift
//  iOS Practice
//
//  Created by Thisisme Hi on 2021/08/20.
//

import UIKit

import SnapKit
import Then

class ViewController: UIViewController {
    // MARK: - Properties
    let blueView = UIView().then {
        $0.backgroundColor = .blue
    }
    
    let pinkView = UIView().then {
        $0.backgroundColor = .systemPink
    }
    
    let greenView = UIView().then {
        $0.backgroundColor = .green
    }
    
    let animationButton = UIButton().then {
        $0.setTitle("  애니메이션  ", for: .normal)
        $0.backgroundColor = .black
        $0.addTarget(self, action: #selector(touchupAnimationButton(_:)), for: .touchUpInside)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupAutoLayout()
        printPoint()
    }
    
    // MARK: - Custom Method
    func configUI() {
        view.backgroundColor = .yellow
        blueView.frame = CGRect(x: 50, y: 100, width: 200, height: 200)
        pinkView.frame = CGRect(x: 100, y: 500, width: 200, height: 200)
        greenView.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
    }
    
    func setupAutoLayout() {
        view.addSubview(animationButton)
        view.addSubview(pinkView)
        pinkView.addSubview(greenView)
        
        animationButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom).inset(50)
        }
    }
    
    func printPoint() {
        print("Bounds ======================")
        print("pink bounds", pinkView.bounds)
        print("green bounds", greenView.bounds)
        print("view bounds", view.bounds)
        print()
        print("Frame ======================")
        print("pink frame", pinkView.frame)
        print("green frame", greenView.frame)
        
    }
    
    // MARK: - objc
    @objc func touchupAnimationButton(_ sender: UIButton) {
        pinkView.bounds = CGRect(x: 100, y: 300, width: 200, height: 200)
//        pinkView.transform = CGAffineTransform(scaleX: 1.5 , y: 1.5)
//        pinkView.transform = CGAffineTransform(rotationAngle: 120)
        print()
        print("bounds 변화 후야!!")
        print()
        printPoint()
    }
}

