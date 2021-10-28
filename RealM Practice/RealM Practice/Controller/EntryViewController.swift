//
//  EntryViewController.swift
//  RealM Practice
//
//  Created by Thisisme Hi on 2021/10/28.
//

import UIKit

import RealmSwift

class EntryViewController: UIViewController {
    
    // MARK: - @IBOutlet, Properties
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    /// Realm 준비
    private let realm = try! Realm()
    public var completionHandler: (() -> Void)?

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviBar()
        setTextField()
        setDatePicker()
    }
    
    // MARK: - Custom Method
    
    private func setNaviBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(saveButtonDidTap(_:)))
    }
    
    private func setTextField() {
        textField.delegate = self
        textField.becomeFirstResponder()
    }
    
    private func setDatePicker() {
        datePicker.setDate(Date(), animated: true)
    }
    
    // MARK: - @objc

    @objc func saveButtonDidTap(_ sender: UIButton) {
        if let text = textField.text, !text.isEmpty {
            let date = datePicker.date
            
            /// Create : 새로운 할 일 추가하기
            let newTodoList = ToDoListItem()
            newTodoList.dueDate = date
            newTodoList.list = text
            
            try! realm.write {
            realm.add(newTodoList)
            }
            
            completionHandler?()
            navigationController?.popToRootViewController(animated: true)
            
        } else {
            print("할 일을 적으세요")
        }
    }
}

// MARK: - UITextFieldDelegate

extension EntryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
