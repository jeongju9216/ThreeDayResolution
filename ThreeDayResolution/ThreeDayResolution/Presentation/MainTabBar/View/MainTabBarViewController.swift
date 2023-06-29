//
//  MainTabBarViewController.swift
//  ThreeDayResolution
//
//  Created by 유정주 on 2023/06/29.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    typealias TabItem = (vc: UIViewController, title: String, icon: String)

    //MARK: - Properties
    private let tabItems: [TabItem] = [
        (UINavigationController(rootViewController: GoalViewController.instantiate), "홈", "square.grid.2x2.fill"),
        (MoreViewController.instantiate, "설정", "gearshape.fill"),
    ]

    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        configurationViewControllers()
    }
    
    //MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .tabBackground
        tabBar.isTranslucent = false //탭바 불투명 해제
        tabBar.tintColor = .tabBarItem
    }

    private func configurationViewControllers() {
        tabItems.forEach {
            $0.vc.title = $0.title
            $0.vc.tabBarItem.image = UIImage(systemName: $0.icon)
        }

        setViewControllers(tabItems.map { $0.vc }, animated: false)
    }
}
