//
//  ToDoListItem.swift
//  RealM Practice
//
//  Created by Thisisme Hi on 2021/10/28.
//

import Foundation

import RealmSwift

class ToDoListItem: Object {
    @objc dynamic var list: String = ""
    @objc dynamic var dueDate: Date = Date()
}

