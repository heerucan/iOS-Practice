//
//  ViewController.swift
//  SlideMenuBar Practice
//
//  Created by Thisisme Hi on 2021/12/17.
//

import UIKit

import SnapKit
import Then

class ViewController: UIViewController, SelectCustomTabDelegate {
    
    // MARK: - Properties
        
    private var colorList: [UIColor] = [.lightGray, .systemGray, .systemGray2]
    
    private var customTabBarView = CustomTabBarView()
    
    private let layout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }
    
    private lazy var pageCV = UICollectionView(
        frame: .zero, collectionViewLayout: layout).then {
        $0.showsHorizontalScrollIndicator = false
        $0.isScrollEnabled = true
        $0.isPagingEnabled = true
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupAutoLayout()
        setupCollectionView()
    }
    
    // MARK: - UI & Layout
    
    func configUI() {
        navigationItem.title = "마켓컬리"
        customTabBarView.selectCustomTabDelegate = self
    }
    
    func setupAutoLayout() {
        view.addSubview(customTabBarView)
        view.addSubview(pageCV)
        
        customTabBarView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(70)
        }
        
        pageCV.snp.makeConstraints { make in
            make.top.equalTo(customTabBarView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func setupCollectionView() {
        pageCV.delegate = self
        pageCV.dataSource = self
        pageCV.register(PageCVC.self, forCellWithReuseIdentifier: PageCVC.identifier)
    }
    
    // MARK: - Custom Method
    
    func selectTabMenu(index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        self.pageCV.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

// MARK: - UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        customTabBarView.indicatorView.snp.updateConstraints { make in
            make.leading.equalToSuperview().inset(round(scrollView.contentOffset.x)/3)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let itemAt = Int(targetContentOffset.pointee.x / self.view.frame.width)
        let indexPath = IndexPath(item: itemAt, section: 0)
        customTabBarView.tabCV.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
}

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCVC.identifier, for: indexPath) as? PageCVC else { return UICollectionViewCell() }
        cell.backgroundColor = colorList[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.pageCV.frame.height)
    }
}
