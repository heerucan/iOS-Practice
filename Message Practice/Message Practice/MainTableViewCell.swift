//
//  MainTableViewCell.swift
//  Message Practice
//
//  Created by 김루희 on 2022/02/27.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    let cellID = "MainTableViewCell"
    
    let messageLabel = UILabel()
    
    var myMessage: MessageModel! {
        didSet {
            
            messageLabel.text = myMessage.content
            messageLabel.textColor = .black
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
