//
//  ArticleViewModel.swift
//  MVVMRxSwift
//
//  Created by Thisisme Hi on 2022/04/11.
//

import Foundation

struct ArticleViewModel {
    
    private let article: Article
    
    var imageURL: String? {
        return article.urlToImage
    }
    
    var title: String? {
        return article.title
    }
    
    var description: String? {
        return article.description
    }
    
    init(article: Article) {
        self.article = article
    }
}
