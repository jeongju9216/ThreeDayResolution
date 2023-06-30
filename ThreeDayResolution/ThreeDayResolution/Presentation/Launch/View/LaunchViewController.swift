//
//  LaunchViewController.swift
//  ThreeDayHump
//
//  Created by 유정주 on 2023/06/29.
//

import UIKit

final class LaunchViewController: UIViewController {
    
    //MARK: - Properties
    private var launchVM: LaunchViewModel = LaunchViewModel()
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        launch()
    }
    
    //MARK: - Methods
    private func launch() {
        Task {
            let state = await launchVM.launch()
            switch state.state {
            case .ok:
                goHomeVC()
            case .fail:
                alert(message: state.notice, doneAction: UIAction { _ in
                    exit(0)
                })
            }
        }
    }
    
    private func goHomeVC() {
        let mainTabBarVC = MainTabBarViewController()
        mainTabBarVC.modalPresentationStyle = .fullScreen

        dismiss(animated: false)
        present(mainTabBarVC, animated: false)
    }
}
