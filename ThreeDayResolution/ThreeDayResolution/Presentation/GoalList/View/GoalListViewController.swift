//
//  GoalListViewController.swift
//  ThreeDayResolution
//
//  Created by 유정주 on 2023/06/29.
//

import UIKit

final class GoalListViewController: UIViewController {
    
    //MARK: - Properties
    private let viewModel: GoalListViewModel = GoalListViewModel()
    
//    private typealias DataSource = UICollectionViewDiffableDataSource<GoalListSections, Goal>
//    private typealias SnapShot = NSDiffableDataSourceSnapshot<GoalListSections, Goal>
    
    //MARK: - Life Cycles
    override func loadView() {
        view = GoalListView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "작심 0일", style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .done, target: self, action: nil),
        ]
        
        navigationController?.navigationBar.tintColor = .white
    }

}
