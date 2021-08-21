//
//  ExampleDataModel.swift
//  Alamofire Practice
//
//  Created by Thisisme Hi on 2021/08/21.
//

import Foundation

// MARK: - ExampleDataModel
struct ExampleDataModel: Codable {
    let a: String
    
    enum CodingKeys: String, CodingKey {
        case a
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        a = (try? values.decode(String.self, forKey: .a)) ?? ""
    }
}
