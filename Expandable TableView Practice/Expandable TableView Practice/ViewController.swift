//
//  ViewController.swift
//  Expandable TableView Practice
//
//  Created by Thisisme Hi on 2021/06/16.
//

import UIKit

import SnapKit

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}

class ViewController : UIViewController {
    
    // MARK: - Data
    
    var tableViewData = [cellData]()
    
    
    // MARK: - Property

    var tableView = UITableView()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewData = [cellData(opened: false, title: "Section1", sectionData: ["Cell1", "Cell2", "Cell3"]),
                         cellData(opened: false, title: "Section2", sectionData: ["Cell1", "Cell2", "Cell3"]),
                         cellData(opened: false, title: "Section3", sectionData: ["Cell1", "Cell2", "Cell3"]),
                         cellData(opened: false, title: "Section4", sectionData: ["Cell1", "Cell2", "Cell3"])]
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        configureUI()
        
    }
    
    
    // MARK: - UI
    
    func configureUI() {
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }
}


// MARK: - UITableViewDelegate

extension ViewController : UITableViewDelegate {
    
}


// MARK: - UITableViewDataSource

extension ViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true {
            // tableView Section이 열려있으면 Section Cell 하나에 sectionData 개수만큼 추가해줘야 함
            return tableViewData[section].sectionData.count + 1
        } else {
            // tableView Section이 닫혀있을 경우에는 Section Cell 하나만 보여주면 됨
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // section 부분 코드
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
                    as? TableViewCell else { return UITableViewCell() }
            cell.configureUI()
            cell.tableLabel.text = tableViewData[indexPath.section].title
            return cell
            
        // sectionData 부분 코드
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
                    as? TableViewCell else { return UITableViewCell() }
            cell.configureUI()
            cell.tableLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 셀 선택 시 회색에서 다시 변하게 해주는 것
        tableView.deselectRow(at: indexPath, animated: true)
        
        // section 부분 선택하면 열리게 설정
        if indexPath.row == 0 {
            // section이 열려있다면 다시 닫힐 수 있게 해주는 코드
            tableViewData[indexPath.section].opened = !tableViewData[indexPath.section].opened
            
//            if tableViewData[indexPath.section].opened == true {
//                // 그리고 펼쳐져 있을 때 셀을 누르면 다시 닫혀줘야 하기 때문에 false로 바꿔줘야 함..
//                tableViewData[indexPath.section].opened = false
//
//            } else {
//                // 처음 기본값이 false니까 얘를 펼쳐주려면 true로 바꿔줘야 함..
//                tableViewData[indexPath.section].opened = true
//
//            }
            
            // 모든 데이터를 새로고침하는 것이 아닌 해당하는 섹션 부분만 새로고침
            tableView.reloadSections([indexPath.section], with: .none)
        
        // sectionData 부분을 선택하면 아무 작동하지 않게 설정
        } else {
            print("이건 sectionData 선택한 거야")
        }
        
        print(tableViewData[indexPath.section].opened)
        print([indexPath.section], [indexPath.row])

        
    }
    
}


