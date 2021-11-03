//
//  ViewController.swift
//  RealM Practice
//
//  Created by Thisisme Hi on 2021/10/28.
//

import UIKit

import RealmSwift

/*
 - 현재 할 일 아이템을 보여줌
 - 새로 할 일을 입력함
 - 이전에 입력한 할 일 목록을 보여줌
 */

class ViewController: UIViewController {

    // MARK: - @IBOutlet, Properties
    
    /// Realm 준비
    private let realm = try! Realm()
    private var todoList = [ToDoListItem]()
    
    @IBOutlet weak var mainTableView: UITableView!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        /// Realm 파일경로 출력
        /// print(Realm.Configuration.defaultConfiguration.fileURL)
        print("Home Directory : \(NSHomeDirectory())")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        refresh() /// 이 부분은 처음 화면이 떴을 때도 테이블 뷰에 데이터 세팅되어있기 위함
    }
    
    // MARK: - @IBAction
    
    @IBAction func addButtonDidTap(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "enter") as? EntryViewController
        else { return }
        
        /// 리로드
        vc.completionHandler = { [weak self] in
            guard let self = self else { return }
            self.refresh()
        }
        vc.title = "할 일 추가"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Custom Method
    
    func setTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func refresh() {
        /// Read :  객체 얻기
        todoList = realm.objects(ToDoListItem.self).map { $0 }
        mainTableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let list = todoList[indexPath.row]
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "detail") as? DetailViewController
        else { return }
        
        vc.todoList = list
        vc.deletionHandler = { [weak self] in
            self?.refresh()
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = list.list
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = todoList[indexPath.row].list
        return cell
    }
}
