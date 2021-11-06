//
//  MainTVC.swift
//  RealM Practice
//
//  Created by Thisisme Hi on 2021/11/07.
//

import UIKit

class MainTVC: UITableViewCell {
    
    static let id = "MainTVC"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
