//
//  ViewController.swift
//  Alamofire Practice
//
//  Created by Thisisme Hi on 2021/08/21.
//

import UIKit

import Alamofire
import SnapKit
import Then

class ViewController: UIViewController {
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupAutoLayout()
        getData()
        
    }
    
    // MARK: - Custom Method
    func configUI() {
        
    }
    
    func setupAutoLayout() {
        
    }
    
    func getData() {
        ExampleService.shared.getExampleData()
    }
}

