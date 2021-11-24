import UIKit

enum DollType {
    case potato
    case grape
}

protocol MyDollFactory {
    func makeDoll()
}

class PotatoDoll: MyDollFactory {
    func makeDoll() {
        print("감자인형")
    }
}

class GrapeDoll: MyDollFactory {
    func makeDoll() {
        print("포도인형")
    }
}

/// 정의해둔 인형 생성을 전문으로 하는 팩토리 타입 만들기
/// 인스턴스를 생성하는 역할을 여기서 함
//class DollFactory {
//     func produce(_ type: DollType) -> MyDollFactory {
//        switch(type) {
//        case .potato:
//            return PotatoDoll()
//        case .grape:
//            return GrapeDoll()
//        }
//    }
//}

//let factory = DollFactory()
//let potato = factory.produce(.potato).makeDoll()

struct DollInfo {
    let name: String
    let count: Int
    let dollType: DollType
    
    enum DollType {
        case potato, grape
    }
}

protocol DollFactoryProtocol {
    func makeDoll()
}

struct Potato: DollFactoryProtocol {
    let dollInfo: DollInfo
    func makeDoll() {
        print("\(dollInfo.name) \(dollInfo.count)개 만들었다.")
    }
}

struct Grape: DollFactoryProtocol {
    let dollInfo: DollInfo
    func makeDoll() {
        print("\(dollInfo.name) \(dollInfo.count)개 만들었다.")
    }
}

struct DollFactory {
     func make(to doll: DollInfo) -> DollFactoryProtocol {
        switch doll.dollType {
        case .potato:
            return Potato(dollInfo: doll)
        case .grape:
            return Grape(dollInfo: doll)
        }
    }
}

let factory = DollFactory()
let newDoll = factory.make(to: DollInfo(name: "감자인형", count: 3, dollType: .potato))
newDoll.makeDoll()
