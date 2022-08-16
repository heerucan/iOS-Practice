//
//  ViewController.swift
//  SPM-Practice
//
//  Created by heerucan on 2022/04/24.
//

import UIKit
import WALKit

class ViewController: UIViewController {
    
    let myLabel: UILabel = {
        let label = UILabel()
        label.font = WALFont.title1.font
        label.textColor = .orange100
        label.text = "안녕하세요. 김루희입니다. 요를레이"
        return label
    }()
    
    let secondLabel: UILabel = {
        let label = UILabel()
        label.font = WALFont.body6.font
        label.textColor = .gray300
        label.text = "Body6/regular | 16px | 22"
        return label
    }()
    
    let deleteImage: UIImageView = {
        let image = UIImageView()
        image.image = WALIcon.icnWarning.image
        return image
    }()
    
    var navigationBar: WALNavigationBar = {
        let view = WALNavigationBar(title: "네비게이션바타이틀")
        view.leftIcon = WALIcon.btnDelete.image
        return view
    }()
    
    lazy var textField: WALTextField = {
        let textField = WALTextField()
        textField.placeholder = "플레이스홀더"
        textField.isFocusing = true
        textField.font 
        return textField
    }()
    
    let myButton: WALPlainButton = {
        let button = WALPlainButton()
        button.title = "메인으로 보내기"
        button.isDisabled = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myLabel)
        view.addSubview(secondLabel)
        view.addSubview(deleteImage)
        view.addSubview(navigationBar)
        view.addSubview(textField)
        view.addSubview(myButton)
        
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 400).isActive = true
        myLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
        
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        secondLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
        
        deleteImage.translatesAutoresizingMaskIntoConstraints = false
        deleteImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300).isActive = true
        deleteImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
        deleteImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        deleteImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        navigationBar.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        navigationBar.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 500).isActive = true
        textField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        textField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 600).isActive = true
        myButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        myButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
    }
}

