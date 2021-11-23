import UIKit

protocol Subscriber {
    var googleId: String { get }
    func update(_ videoName: String)
}

protocol Youtuber {
    func registerSubscriber(_ subscriber: Subscriber)
    func removeSubscriber(_ subscriber: Subscriber)
    func notifySubscriber()
}

class 꼬꼬무채널: Youtuber {
    private var subscribers = [Subscriber]()
    private var recentVideoName = String()
    
    func registerSubscriber(_ subscriber: Subscriber) {
        subscribers.append(subscriber)
    }
    
    func removeSubscriber(_ subscriberToRemove: Subscriber) {
        subscribers.removeAll { (subscriber) -> Bool in
            subscriberToRemove.googleId == subscriber.googleId
        }
    }
    
    func notifySubscriber() {
        for subscriber in subscribers {
            subscriber.update(recentVideoName)
        }
    }

    func uploadVideo(_ videoName: String) {
        recentVideoName = videoName
        notifySubscriber()
    }
}

class Sokite: Subscriber {
    var googleId: String = "sokite"
    func update(_ videoName: String) {
        print("소카이트는 \(videoName) 영상 업로드 알림을 받았습니다.")
    }
}

class Npchong: Subscriber {
    var googleId: String = "npchong"
    func update(_ videoName: String) {
        print("NPC홍은 \(videoName) 영상 업로드 알림을 받았습니다.")
    }
}

var 꼬꼬무 = 꼬꼬무채널()
var sokite = Sokite()
var npchong = Npchong()

print("\nsokite 구독-----------------------")
꼬꼬무.registerSubscriber(sokite)
꼬꼬무.uploadVideo("Ep.1 : 경성 피스톨 김상옥")
꼬꼬무.uploadVideo("Ep.2 : 형제복지원 그날의 이야기")
print("\nnpchong 구독-----------------------")
꼬꼬무.registerSubscriber(npchong)
꼬꼬무.uploadVideo("Ep.3 : 삼풍백화점 붕괴사건")
print("\nsokite 구독취소-----------------------")
꼬꼬무.removeSubscriber(sokite)
꼬꼬무.uploadVideo("Ep.4 : 김구 암살범 안두희")

