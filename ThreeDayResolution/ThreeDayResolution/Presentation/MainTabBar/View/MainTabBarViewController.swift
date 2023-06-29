//
//  MainTabBarViewController.swift
//  ThreeDayResolution
//
//  Created by 유정주 on 2023/06/29.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    typealias TabItem = (vc: UINavigationController, title: String, icon: String)

    //MARK: - Properties
    private let tabItems: [TabItem] = [
        (UINavigationController(rootViewController: GoalViewController.instantiate), "작심삼일", "house"),
        (UINavigationController(rootViewController: MoreViewController.instantiate), "설정", "play.circle"),
    ]

    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    //MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .main
        tabBar.tintColor = .tabBar
    }

    private func configurationViewControllers() {
        tabItems.forEach {
            $0.vc.title = $0.title
            $0.vc.tabBarItem.image = UIImage(systemName: $0.icon)
        }

        setViewControllers(tabItems.map { $0.vc }, animated: false)
    }
}
