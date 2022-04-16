//
//  RootViewModel.swift
//  MVVMRxSwift
//
//  Created by Thisisme Hi on 2022/04/11.
//

import Foundation
import RxSwift

final class RootViewModel {
    let title = "Ruhee News"
    
    private let articleService: ArticleServiceProtocol
    
    init(articleService: ArticleServiceProtocol) {
        self.articleService = articleService
    }
    
    func fetchArticles() -> Observable<[ArticleViewModel]> {
        return articleService.fetchNews().map { $0.map { ArticleViewModel(article: $0) } }
    }
}
