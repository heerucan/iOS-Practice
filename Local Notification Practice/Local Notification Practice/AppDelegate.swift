//
//  AppDelegate.swift
//  Local Notification Practice
//
//  Created by Thisisme Hi on 2021/11/17.
//

import UIKit

import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
        
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        if #available(iOS 10.0, *) {
            let notiCenter = UNUserNotificationCenter.current()
            notiCenter.delegate = self
            notiCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (didAllow, error) in
                print(didAllow)
            }
        }
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        guard let rootViewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController else { return }
        
        if response.notification.request.identifier == "comeback" {
            let userInfo = response.notification.request.content.userInfo
            print(userInfo)
            let vc = ViewController()
    
            rootViewController.view.backgroundColor = .orange
        }
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        if notification.request.identifier == "foreground" {
            let userInfo = notification.request.content.userInfo
            print(userInfo)
            window?.rootViewController?.view.backgroundColor = .brown
        }
        
        completionHandler([.banner])
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        if notification!.request.identifier == "comback" {
            let userInfo = notification!.request.content.userInfo
            print(userInfo)
        }
    }
    
}
