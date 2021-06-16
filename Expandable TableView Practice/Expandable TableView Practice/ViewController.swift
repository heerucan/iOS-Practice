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
            return tableViewData[section].sectionData.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
                    as? TableViewCell else { return UITableViewCell() }
            cell.configureUI()
            cell.tableLabel.text = tableViewData[indexPath.section].title
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
                    as? TableViewCell else { return UITableViewCell() }
            cell.configureUI()
            cell.tableLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if tableViewData[indexPath.section].opened == true {
            tableViewData[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
            
        } else {
            tableViewData[indexPath.section].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
            
        }
    }
    
}
