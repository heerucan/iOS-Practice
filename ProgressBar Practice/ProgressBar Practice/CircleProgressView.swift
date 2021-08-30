//
//  CircleProgressView.swift
//  ProgressBar Practice
//
//  Created by Thisisme Hi on 2021/08/30.
//

import UIKit

class CircleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = .black
        self.snp.makeConstraints { make in
            make.width.height.equalTo(300)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.lineWidth = 10
        path.lineCapStyle = .butt
        path.lineJoinStyle = .round
        path.usesEvenOddFillRule = false
        path.move(to: CGPoint(x: self.frame.width/2, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        path.fill()

        UIColor.systemRed.set()
        path.stroke()
    }
}
