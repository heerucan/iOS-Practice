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
        self.backgroundColor = .brown
        self.snp.makeConstraints { make in
            make.width.height.equalTo(300)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 가장 기본적인 draw 함수
//    override func draw(_ rect: CGRect) {
//        let path = UIBezierPath()
//        path.lineWidth = 10
//        path.lineCapStyle = .butt
//        path.lineJoinStyle = .round
//        path.usesEvenOddFillRule = false
//        path.move(to: CGPoint(x: self.frame.width/2, y: 0))
//        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
//        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
//        path.close()
//        UIColor.systemRed.set()
//        path.stroke()
//        path.fill()
//    }
    
    
    // 원을 만들어 줄 수 있는 이니셜라이저
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0,
                                               width: self.frame.width,
                                               height: self.frame.width/2))
        path.lineWidth = 3
        path.fill()
        UIColor.green.set()
        path.stroke()
        path.close()
        
    }
}
