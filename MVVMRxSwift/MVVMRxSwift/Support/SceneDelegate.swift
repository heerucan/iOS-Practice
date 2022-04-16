//
//  SceneDelegate.swift
//  MVVMRxSwift
//
//  Created by Thisisme Hi on 2022/04/11.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        let coordinator = Coordinator(window: self.window!)
        coordinator.start()
    }
}
