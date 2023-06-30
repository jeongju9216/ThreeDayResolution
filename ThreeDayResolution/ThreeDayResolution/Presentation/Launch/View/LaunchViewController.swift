//
//  LaunchViewController.swift
//  ThreeDayHump
//
//  Created by 유정주 on 2023/06/29.
//

import UIKit

final class LaunchViewController: UIViewController {
    
    //MARK: - Properties
    private var viewModel: LaunchViewModel = LaunchViewModel()
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        launch()
    }
    
    //MARK: - Methods
    private func launch() {
        Task {
            let state = await viewModel.launch()
            switch state.state {
            case .ok:
                countingRun()
                goFirstVC()
            case .fail:
                alert(message: state.notice, doneAction: UIAction { _ in
                    exit(0)
                })
            }
        }
    }
    
    private func goFirstVC() {
        let firstVC = UINavigationController(rootViewController: GoalListViewController())
        firstVC.modalPresentationStyle = .fullScreen

        dismiss(animated: false)
        present(firstVC, animated: false)
    }
    
    private func countingRun() {
        if let lastRunDate = BaseData.shared.lastRunDate {
            print("lastRunDate: \(lastRunDate)")
            //하루동안 접속이 없었다면 runCount +1
            if !Calendar.current.isDateInToday(lastRunDate) {
                BaseData.shared.lastRunDate = Date()
                BaseData.shared.runCount += 1
            }
        } else {
            //첫 실행
            Logger.log("First Run App")
            BaseData.shared.lastRunDate = Date()
            BaseData.shared.runCount = 1
        }
    }
}
