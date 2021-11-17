//
//  SceneDelegate.swift
//  Local Notification Practice
//
//  Created by Thisisme Hi on 2021/11/17.
//

import UIKit

import UserNotifications

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let navigationController = ViewController()
        window?.rootViewController?.view.backgroundColor = .white
        window?.rootViewController = navigationController // 루트 뷰컨트롤러 생성
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        print("sceneWillResignActive")
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                    
                    let videoName = "video"
                    // let imageName = "icon"
                    guard let videoURL = Bundle.main.url(forResource: videoName, withExtension: ".mov") else { return }
                    // guard let imageURL = Bundle.main.url(forResource: imageName, withExtension: ".png") else { return }
                    let attachment = try! UNNotificationAttachment(identifier: videoName, url: videoURL, options: .none)
                    
                    let content = UNMutableNotificationContent()
                    content.badge = 1
                    content.title = "우리 앱 혹시 껐니?"
                    content.subtitle = "왜 껐어? 다시 들어와^^;;"
                    content.body = "들어오라고;"
                    content.sound = .default
                    content.userInfo = ["name": "김루희"]
                    content.attachments = [attachment]
                    
                    /// 일정 시간 이후에 알림 발생
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
                    
                    /// 일정 날짜와 시간에 알림 발생
                    //  let date = Date(timeIntervalSinceNow: 3600*5)
                    //  let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: date), repeats: false)
                    
                    let request = UNNotificationRequest(identifier: "comeback",
                                                        content: content,
                                                        trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                }
            }
        }
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                    
                    // let videoName = "video"
                    let imageName = "icon"
                    // guard let videoURL = Bundle.main.url(forResource: videoName, withExtension: ".mov") else { return }
                    guard let imageURL = Bundle.main.url(forResource: imageName, withExtension: ".png") else { return }
                    let attachment = try! UNNotificationAttachment(identifier: imageName, url: imageURL, options: .none)
                    
                    let content = UNMutableNotificationContent()
                    content.badge = 1
                    content.title = "우리 앱 혹시 켰니?"
                    content.subtitle = "옹 다시 돌아왔네"
                    content.body = "환영한당"
                    content.sound = .default
                    content.userInfo = ["name": "김루희"]
                    content.attachments = [attachment]
                    
                    /// 일정 시간 이후에 알림 발생
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                    
                    /// 일정 날짜와 시간에 알림 발생
//                     let date = Date(timeIntervalSinceNow: 3600*5)
//                     let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: date), repeats: false)
                    
                    let request = UNNotificationRequest(identifier: "foreground",
                                                        content: content,
                                                        trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                }
            }
        }
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

