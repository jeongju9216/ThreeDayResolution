//
//  SceneDelegate.swift
//  ThreeDayHump
//
//  Created by 유정주 on 2022/01/02.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let sceneWindow = (scene as? UIWindowScene) else {
            return
        }
        
        window = UIWindow(windowScene: sceneWindow)
        
        window?.rootViewController = LaunchViewController.instantiate
        
        window?.makeKeyAndVisible()
    }
}

