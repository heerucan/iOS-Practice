//
//  ViewController.swift
//  Message Practice
//
//  Created by 김루희 on 2022/02/27.
//

import UIKit

import SnapKit
import Then

class ViewController: UIViewController {
    
    var message = [[MessageModel]]()
    
    var isTop = false
    var messageList = [MessageModel]()
    
    lazy var messageArray = [
        MessageModel(content: "오늘은2022년4월12일", time: Date.dateFromCustomString(customString: "04/12/2022")),
        MessageModel(content: "오늘은2022년4월03일", time: Date.dateFromCustomString(customString: "04/3/2022")),
        MessageModel(content: "오늘은2022년8월19일", time: Date.dateFromCustomString(customString: "08/19/2022")),
        MessageModel(content: "오늘은2022년2월23일", time: Date.dateFromCustomString(customString: "02/23/2022")),
        MessageModel(content: "오늘은2022년2월23일", time: Date.dateFromCustomString(customString: "02/23/2022")),
        MessageModel(content: "오늘은2022년2월23일", time: Date.dateFromCustomString(customString: "02/23/2022")),
        MessageModel(content: "오늘은2022년2월23일", time: Date.dateFromCustomString(customString: "02/23/2000"))]
    
    let mainTV = UITableView()
    
    func assembleDateByMonth() {
        //        let groupedDate = Dictionary(grouping: messageArray) { element -> Date in
        //            return element.time
        //        }
        
        let groupedDate = Dictionary(grouping: messageArray) { $0.time.month }
        print("------groupedDate: ", groupedDate)
        
        groupedDate.keys.forEach { key in
            print(key)
            let values = groupedDate[key]
            print(values ?? "")
            print()
            
            message.append(values ?? [])
            
        }
        
        print("-- message: ", message)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupView()
        assembleDateByMonth()
        
    }
    
    private func configureUI() {
        mainTV.delegate = self
        mainTV.dataSource = self
        mainTV.register(MainTableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
    }
    
    private func setupView() {
        view.addSubview(mainTV)
        
        mainTV.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let firstMessageInSection = message[section].first {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy년 M월"
            let dateString = dateFormatter.string(from: firstMessageInSection.time)
            let label = UILabel()
            label.text = dateString
            label.textColor = .black
            
            let containerView = UIView()
            containerView.backgroundColor = .yellow
            containerView.addSubview(label)
            label.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
            }
            
            return containerView
            
        }
        return nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("--- message.count::::  ", message.count)
        return message.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("-------numberOfRowsInSection: ", message[section])
        return message[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        //        let chatMessage = chatMessages[indexPath.row]
        let myMessage = message[indexPath.section][indexPath.row]
//        print(myMessage,"셀 내용")
        cell.myMessage = myMessage
        return cell
    }
}
