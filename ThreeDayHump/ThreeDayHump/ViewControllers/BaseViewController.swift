//
//  BaseViewController.swift
//  ThreeDayHump
//
//  Created by 유정주 on 2022/01/19.
//

import UIKit

class BaseViewController: UIViewController {
    func showGoalViewController() {
        Goal.shared.goal = ""
        Goal.shared.day = 0
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = self.tabBarController
        
        let goalViewController = storyboard.instantiateViewController(withIdentifier: "GoalViewController")
        let moreViewController = storyboard.instantiateViewController(withIdentifier: "MoreViewController")
        
        tabBarController?.setViewControllers([goalViewController, moreViewController], animated: false)
    }
    
    func showThreeDayViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = self.tabBarController
        
        let threeDayViewController = storyboard.instantiateViewController(withIdentifier: "ThreeDayViewController")
        let moreViewController = storyboard.instantiateViewController(withIdentifier: "MoreViewController")
        
        tabBarController?.setViewControllers([threeDayViewController, moreViewController], animated: false)
    }
    
    
    func resetUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "goal")
        UserDefaults.standard.removeObject(forKey: "day")
    }
}
