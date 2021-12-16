//
//  TabCVC.swift
//  SlideMenuBar Practice
//
//  Created by Thisisme Hi on 2021/12/17.
//

import UIKit

import SnapKit
import Then

class TabCVC: UICollectionViewCell {
    
    static let identifier = "TabCVC"
        
    override var isSelected: Bool {
        didSet{
            tabMenuLabel.textColor = isSelected ? .purple : .lightGray
        }
    }
    
    override func prepareForReuse() {
        isSelected = false
    }

    public let tabMenuLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textAlignment = .center
        $0.textColor = .lightGray
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAutoLayout() {
        contentView.addSubview(tabMenuLabel)
        
        tabMenuLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
