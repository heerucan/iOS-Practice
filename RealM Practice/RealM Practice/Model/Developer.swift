//
//  Developer.swift
//  RealM Practice
//
//  Created by Thisisme Hi on 2021/11/07.
//

import Foundation

import RealmSwift

class Developer: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var mbti: String = ""
    @objc dynamic var birthday: Date = Date()
}
