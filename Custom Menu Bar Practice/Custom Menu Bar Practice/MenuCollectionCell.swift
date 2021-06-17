//
//  MenuCollectionCell.swift
//  Custom Menu Bar Practice
//
//  Created by Thisisme Hi on 2021/06/16.
//

import UIKit

class MenuCollectionCell: UICollectionViewCell {
    
    static let identifier = "MenuCollectionCell"
        
    // MARK: - Property
    
    let menuLabel : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    // menuBar 선택하면 보라색 / 미선택 시 회색
    override var isSelected: Bool {
        didSet {
            menuLabel.textColor = isSelected ? UIColor.purple : UIColor.gray
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    // MARK: - UI
    
    func configureUI() {
        
        addSubview(menuLabel)
        
        menuLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
