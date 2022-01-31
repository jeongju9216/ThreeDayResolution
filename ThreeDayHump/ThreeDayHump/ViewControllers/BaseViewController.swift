//
//  BaseViewController.swift
//  ThreeDayHump
//
//  Created by 유정주 on 2022/01/19.
//

import UIKit

class BaseViewController: UIViewController {
    func showGoalViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = self.tabBarController
        
        let goalViewController = storyboard.instantiateViewController(withIdentifier: "GoalViewController")
        
        let navigation = storyboard.instantiateViewController(withIdentifier: "MoreNavigationController") as! UINavigationController
        
        tabBarController?.setViewControllers([goalViewController, navigation], animated: false)
    }
    
    func showThreeDayViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = self.tabBarController
        
        let threeDayViewController = storyboard.instantiateViewController(withIdentifier: "ThreeDayViewController")
        
        let navigation = storyboard.instantiateViewController(withIdentifier: "MoreNavigationController") as! UINavigationController
        
        tabBarController?.setViewControllers([threeDayViewController, navigation], animated: false)
    }
    
    
    func resetUserDefaults() {
        Goal.shared.goal = ""
        Goal.shared.day = 0
        
        UserDefaults.standard.removeObject(forKey: "goal")
        UserDefaults.standard.removeObject(forKey: "day")
    }
}
