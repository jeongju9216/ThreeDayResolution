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
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let sceneWindow = (scene as? UIWindowScene) else {
            return
        }
        
        window = UIWindow(windowScene: sceneWindow)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController
        
        let goalViewController = storyboard.instantiateViewController(withIdentifier: "GoalViewController")
        let threeDayViewController = storyboard.instantiateViewController(withIdentifier: "ThreeDayViewController")
        let moreViewController = storyboard.instantiateViewController(withIdentifier: "MoreViewController")
        
        if let goal = UserDefaults.standard.string(forKey: "goal"),
           !goal.isEmpty {
            let day = UserDefaults.standard.integer(forKey: "day")
            
            print("Goal: \(goal) / Day: \(day)")
            Goal.shared.goal = goal
            Goal.shared.day = day

            tabBarController?.setViewControllers([threeDayViewController, moreViewController], animated: false)
        } else {
            print("Goal is nil or Empty")
            tabBarController?.setViewControllers([goalViewController, moreViewController], animated: false)
        }
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
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

