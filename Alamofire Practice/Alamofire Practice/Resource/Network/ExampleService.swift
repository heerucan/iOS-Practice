//
//  ExampleService.swift
//  Alamofire Practice
//
//  Created by Thisisme Hi on 2021/08/21.
//

import Foundation

import Alamofire

struct ExampleService {
    static let shared = ExampleService()
    
    func getExampleData() {
        AF.request("https://httpbin.org/get",
                   method: .get, parameters: [:],
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                if let JSON = response.data {
                    print(JSON)
                }
            }
    }
}




