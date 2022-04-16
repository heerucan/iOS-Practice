//
//  ArticleService.swift
//  MVVMRxSwift
//
//  Created by Thisisme Hi on 2022/04/11.
//

import Foundation
import Alamofire
import RxSwift

protocol ArticleServiceProtocol {
    func fetchNews() -> Observable<[Article]>
}

class ArticleServcie: ArticleServiceProtocol {
    
    func fetchNews() -> Observable<[Article]> {
        return Observable.create { (observer) -> Disposable in
            
            self.fetchNews { (error, articles) in
                if let error = error {
                    observer.onError(error)
                }
                
                if let articles = articles {
                    observer.onNext(articles)
                }
                
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    private func fetchNews(completion: @escaping((Error?, [Article]?) -> Void)) {
        let urlString = "https://newsapi.org/v2/everything?q=tesla&from=2022-03-11&sortBy=publishedAt&apiKey=96aeb218411746a4a309aafc14fced54#"
        
        guard let url = URL(string: urlString) else { return completion(NSError(domain: "에러", code: 404, userInfo: nil), nil)}
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: nil, interceptor: nil,
                   requestModifier: nil).responseDecodable(of: ArticleResponse.self) { response in
            
            if let error = response.error {
                return completion(error, nil)
            }
            
            if let articles = response.value?.articles {
                return completion(nil, articles)
            }
        }
    }
}
