//
//  ViewController.swift
//  Custom Menu Bar Practice
//
//  Created by Thisisme Hi on 2021/06/16.
//

import UIKit

import SnapKit

class ViewController: UIViewController {
    
    var colorArray = [UIColor.red, UIColor.orange, UIColor.yellow, UIColor.green, UIColor.purple]
    
    // MARK: - Property
    
    let upperView : UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        return view
    }()
    
    lazy var menuBar : MenuBar = {
        let mb = MenuBar()
        mb.vc = self
        return mb
    }()
        
    let mainCV : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainCV.delegate = self
        mainCV.dataSource = self
        
        mainCV.register(MainCollectionCell.self, forCellWithReuseIdentifier: "MainCollectionCell")
        
        configureUI()
    }
    
    // MARK: - UI
    
    func configureUI() {
        
        view.addSubview(upperView)
        view.addSubview(menuBar)
        view.addSubview(mainCV)
        
        upperView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(88)
        }
        
        menuBar.snp.makeConstraints { (make) in
            make.top.equalTo(upperView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        mainCV.snp.makeConstraints { (make) in
            make.top.equalTo(menuBar.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
    }
    
}

// MARK: - UICollectionViewDelegate

extension ViewController : UICollectionViewDelegate {
    
    // mainCV 스크롤하면 slideBar도 같이 스크롤
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let slideBar = menuBar.slideBarView
        
        let width = UIScreen.main.bounds.width
        let slideBarWidth = menuBar.slideBarView.frame.width
        
        
        if scrollView.contentOffset == CGPoint(x: 0.0, y: 0.0) {
            UIView.animate(withDuration: 0.3) {
                // mainCV 이동하면 slideBar 위치도 같이 이동
                slideBar.frame.origin.x = width * (15/width)
                
                // mainCV 이동하면 menuBar 메뉴 색상도 같이 변경
                self.menuBar.menuCV.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .init())
                
            }

        } else if scrollView.contentOffset == CGPoint(x: width, y: 0.0) {
            UIView.animate(withDuration: 0.3) {
                slideBar.frame.origin.x = width * (15/width) + slideBarWidth
                self.menuBar.menuCV.selectItem(at: IndexPath(item: 1, section: 0), animated: true, scrollPosition: .init())
                
            }

        } else if scrollView.contentOffset == CGPoint(x: width * 2, y: 0.0) {
            UIView.animate(withDuration: 0.3) {
                slideBar.frame.origin.x = width * (15/width) + slideBarWidth * 2
                self.menuBar.menuCV.selectItem(at: IndexPath(item: 2, section: 0), animated: true, scrollPosition: .init())

            }

        } else if scrollView.contentOffset == CGPoint(x: width * 3, y: 0.0) {
            UIView.animate(withDuration: 0.3) {
                slideBar.frame.origin.x = width * (15/width) + slideBarWidth * 3
                self.menuBar.menuCV.selectItem(at: IndexPath(item: 3, section: 0), animated: true, scrollPosition: .init())
               
            }

        } else if scrollView.contentOffset == CGPoint(x: width * 4, y: 0.0) {
            UIView.animate(withDuration: 0.3) {
                slideBar.frame.origin.x = width * (15/width) + slideBarWidth * 4
                self.menuBar.menuCV.selectItem(at: IndexPath(item: 4, section: 0), animated: true, scrollPosition: .init())
               
            }
        }

    }
}

// MARK: - UICollectionViewDataSource
extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionCell", for: indexPath) as? MainCollectionCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = colorArray[indexPath.row]
        
        return cell
    }
        
}


// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        return CGSize(width: width, height: UIScreen.main.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}
