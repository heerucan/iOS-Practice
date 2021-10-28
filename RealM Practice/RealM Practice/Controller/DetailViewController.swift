//
//  DetailViewController.swift
//  RealM Practice
//
//  Created by Thisisme Hi on 2021/10/29.
//

import UIKit

import RealmSwift

class DetailViewController: UIViewController {

    // MARK: - @IBOutlet, Properties
    
    // Realm 준비
    private let realm = try! Realm()
    
    public var todoList: ToDoListItem?
    public var deletionHandler: (() -> Void)?
    
    @IBOutlet var listLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    static let dateFormatter: DateFormatter = {
       let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listLabel.text = todoList?.list
        dateLabel.text = Self.dateFormatter.string(from: todoList!.dueDate)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash,
                                                            target: self,
                                                            action: #selector(deleteButtonDidTap(_:)))
    }
    
    // MARK: - @objc
    
    @objc private func deleteButtonDidTap(_ sender: UIButton) {
        guard let list = self.todoList else { return }
        
        /// Delete : 객체 삭제하기
        realm.beginWrite()
        realm.delete(list)
        try! realm.commitWrite()
        
        deletionHandler?()
        navigationController?.popToRootViewController(animated: true)
    }
}

