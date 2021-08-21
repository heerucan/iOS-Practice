//
//  UIView + Extension.swift
//  Alamofire Practice
//
//  Created by Thisisme Hi on 2021/08/21.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}
