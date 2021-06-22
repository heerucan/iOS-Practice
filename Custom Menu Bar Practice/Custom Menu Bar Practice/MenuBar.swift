//
//  MenuBar.swift
//  Custom Menu Bar Practice
//
//  Created by Thisisme Hi on 2021/06/16.
//

import UIKit

import SnapKit

class MenuBar: UIView {
    
    let menuArray = ["컬리추천", "신상품", "베스트", "알뜰쇼핑", "특가/혜택"]
    
    var nowPage = Int()
    
    var vc = ViewController()
    
    // MARK: - Property
    
    lazy var menuCV : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .orange
        return cv
    }()
    
    let slideBarView : UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        return view
    }()

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        
        menuCV.delegate = self
        menuCV.dataSource = self
        
        menuCV.register(MenuCollectionCell.self, forCellWithReuseIdentifier: "MenuCollectionCell")
    }
    
    // MARK: - UI
    
    func configureUI() {
        
        addSubview(menuCV)
        addSubview(slideBarView)
        
        menuCV.snp.makeConstraints { (make) in
            make.top.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(55)
        }
        
        slideBarView.snp.makeConstraints { (make) in
            make.leading.equalTo(15)
            make.bottom.equalToSuperview()
            make.width.equalTo(69)
            make.height.equalTo(3)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UICollectionViewDelegate

extension MenuBar : UICollectionViewDelegate {
    
    // menuBar 선택 시 slideBar도 같이 스크롤
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        
        let width = UIScreen.main.bounds.width
        let slideBarWidth = slideBarView.frame.width
        
        // menuBar 메뉴 선택 시 아래 mainVC 이동하는 건 아직 안됨
        
        if indexPath.item == 0 {
            nowPage = 0
            UIView.animate(withDuration: 0.3) {
                self.slideBarView.frame.origin.x = width * (15/width)
                self.vc.mainCV.scrollToItem(at:IndexPath(item: indexPath.item, section: 0), at: .init(), animated: false)
            }
            
        } else if indexPath.item == 1 {
            nowPage = 1
            UIView.animate(withDuration: 0.3) {
                self.slideBarView.frame.origin.x = width * (15/width) + slideBarWidth
                self.vc.mainCV.scrollToItem(at:IndexPath(item: indexPath.item, section: 0), at: .init(), animated: false)


            }
            
        } else if indexPath.item == 2 {
            nowPage = 2
            UIView.animate(withDuration: 0.3) {
                self.slideBarView.frame.origin.x = width * (15/width) + slideBarWidth * 2
                self.vc.mainCV.scrollToItem(at:IndexPath(item: indexPath.item, section: 0), at: .init(), animated: false)


            }
            
        } else if indexPath.item == 3 {
            nowPage = 3
            UIView.animate(withDuration: 0.3) {
                self.slideBarView.frame.origin.x = width * (15/width) + slideBarWidth * 3
                self.vc.mainCV.scrollToItem(at:IndexPath(item: indexPath.item, section: 0), at: .init(), animated: false)

            }
            
        } else {
            nowPage = 4
            UIView.animate(withDuration: 0.3) {
                self.slideBarView.frame.origin.x = width * (15/width) + slideBarWidth * 4
                self.vc.mainCV.scrollToItem(at:IndexPath(item: indexPath.item, section: 0), at: .init(), animated: false)

            }
        }
        menuCV.reloadData()
    }
    
        
}

// MARK: - UICollectionViewDataSource

extension MenuBar : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionCell", for: indexPath) as? MenuCollectionCell else { return UICollectionViewCell() }
        cell.backgroundColor = .white
        cell.configureUI()
        
        // 메뉴 선택 시 메뉴 자체 색 변경
        if nowPage == indexPath.row {
            cell.setData(title: menuArray[indexPath.row], selected: true)
        } else {
            cell.setData(title: menuArray[indexPath.row], selected: false)
        }
        
        
        // menuBar 메뉴 선택 시에 첫 번째 메뉴가 계속 선택되어 있는 오류 해결을 위한 코드
        if indexPath.row == 0 {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
            cell.isSelected = true
        }
        
        return cell
    }
    
    
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MenuBar : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let cellWidth = width * (69/width)

        return CGSize(width: cellWidth, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
    }
}
