//
//  ArticleCell.swift
//  MVVMRxSwift
//
//  Created by Thisisme Hi on 2022/04/11.
//

import UIKit
import RxSwift
import SDWebImage

class ArticleCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    
    var viewModel = PublishSubject<ArticleViewModel>()
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 8
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.widthAnchor.constraint(equalToConstant: 60).isActive = true
        image.heightAnchor.constraint(equalToConstant: 60).isActive = true
        image.backgroundColor = .secondarySystemBackground
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 3
        return label
    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        subscribe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        contentView.backgroundColor = .white
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        [imageView, titleLabel, descriptionLabel ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -40).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: 20).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 20).isActive = true
    }
    
    // MARK: - Custom Method

    func subscribe() {
        self.viewModel.subscribe(onNext: { articleViewModel in
            if let urlString = articleViewModel.imageURL {
                self.imageView.sd_setImage(with: URL(string: urlString), completed: nil)
            }
            
            self.titleLabel.text = articleViewModel.title
            self.descriptionLabel.text = articleViewModel.description
            
        }).disposed(by: disposeBag)
    }
}
