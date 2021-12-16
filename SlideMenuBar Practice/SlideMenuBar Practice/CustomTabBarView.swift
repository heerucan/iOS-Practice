//
//  CustomTabBarView.swift
//  SlideMenuBar Practice
//
//  Created by Thisisme Hi on 2021/12/17.
//

import UIKit

import SnapKit
import Then

protocol SelectCustomTabDelegate: AnyObject {
    func selectTabMenu(index: Int)
}

class CustomTabBarView: UIView {
    
    // MARK: - Properties
    
    public weak var selectCustomTabDelegate: SelectCustomTabDelegate?
    
    private var menuList = ["킴씨", "이준", "모끼"]
    
    public var indicatorViewLeadingConstraint: NSLayoutConstraint!
    
    private var layout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }
    
    public lazy var tabCV = UICollectionView(
        frame: .zero, collectionViewLayout: layout).then {
        $0.showsHorizontalScrollIndicator = false
        $0.isScrollEnabled = false
    }
    
    public var indicatorView = UIView().then {
        $0.backgroundColor = .purple
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setupAutoLayout()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    func configUI() {
        backgroundColor = .gray
    }
    
    func setupAutoLayout() {
        addSubview(tabCV)
        addSubview(indicatorView)
        
        tabCV.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        indicatorView.snp.makeConstraints { make in
            make.top.equalTo(tabCV.snp.bottom)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(round((UIScreen.main.bounds.size.width)/3))
        }
    }
    
    func setupCollectionView() {
        tabCV.delegate = self
        tabCV.dataSource = self
        tabCV.register(TabCVC.self, forCellWithReuseIdentifier: TabCVC.identifier)
    }
}

// MARK: - UICollectionViewDelegate

extension CustomTabBarView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectCustomTabDelegate?.selectTabMenu(index: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TabCVC else { return }
        cell.tabMenuLabel.textColor = .lightGray
    }
}

// MARK: - UICollectionViewDataSource

extension CustomTabBarView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabCVC.identifier, for: indexPath) as? TabCVC else { return UICollectionViewCell() }
        cell.tabMenuLabel.text = menuList[indexPath.item]
        
        return cell
    }
}

// MARK: - UICollectionViewFlowLayout

extension CustomTabBarView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: round((UIScreen.main.bounds.size.width-10)/3), height: self.bounds.height)
    }
}
