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
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        print("sceneWillResignActive")
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                    
                    let videoName = "video"
                    let imageName = "icon"
                    guard let videoURL = Bundle.main.url(forResource: videoName, withExtension: ".mov") else { return }
                    guard let imageURL = Bundle.main.url(forResource: imageName, withExtension: ".png") else { return }
                    let attachment = try! UNNotificationAttachment(identifier: videoName, url: videoURL, options: .none)
                    
                    let content = UNMutableNotificationContent()
                    content.badge = 1
                    content.title = "우리 앱 혹시 껐니?"
                    content.subtitle = "왜 껐어? 다시 들어와^^;;"
                    content.body = "들어오라고;"
                    content.sound = .default
                    content.userInfo = ["name": "김루희"]
                    content.attachments = [attachment]
                    
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                    
                    let request = UNNotificationRequest(identifier: "comeback",
                                                        content: content,
                                                        trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                }
            }
        }
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}
