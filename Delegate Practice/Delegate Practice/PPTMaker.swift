//
//  PPTMaker.swift
//  Delegate Practice
//
//  Created by Thisisme Hi on 2021/11/03.
//

import Foundation

struct PPT {
    var page: Int = 20
    var hasVideo: Bool = false
}

// TextFieldDelegate
protocol PPTMakerDelegate {
    // 텍스트필드shouldReturn 함수
    func pptIsAlreadyPrepared(_ ppt: PPT)
}

// LoginVC
class PPTMaker {
    var delegate: PPTMakerDelegate?

    func makePPT() {
        var ppt = PPT()
        ppt.page = 20
        ppt.hasVideo = true
        
        delegate?.pptIsAlreadyPrepared(ppt)
    }
}


class Presenter: PPTMakerDelegate {
    func pptIsAlreadyPrepared(_ ppt: PPT) {
        print("음 오늘 받은 발표자료는 총 \(ppt.page)페이지군...")
    }
}
