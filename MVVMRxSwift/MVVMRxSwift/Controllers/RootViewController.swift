//
//  RootViewController.swift
//  MVVMRxSwift
//
//  Created by Thisisme Hi on 2022/04/11.
//

import UIKit

class RootViewController: UIViewController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .systemBackground
    }
}
