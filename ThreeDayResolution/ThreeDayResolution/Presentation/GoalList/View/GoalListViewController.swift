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
    private var testArr: [Goal] = [Goal(goal: "TEST1", count: 1, createdAt: .init(), lastCompletedDate: .init(timeIntervalSinceNow: -86400)),
                                   Goal(goal: "TEST2", count: 200, createdAt: .init(), lastCompletedDate: .init(timeIntervalSinceNow: 0)),
                                   Goal(goal: "TEST3", count: 30, createdAt: .init(), lastCompletedDate: .init(timeIntervalSinceNow: -10000000)),
                                   Goal(goal: "TEST4", count: 0, createdAt: .init())]
    
    //MARK: - Views
    private let goalListView: GoalListView = GoalListView()
    
    //MARK: - Life Cycles
    override func loadView() {
        view = goalListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    //MARK: - Setup
    private func setupUI() {
        setupNavigationBar()
        setupCollectionView()
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "작심 0일", style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .done, target: self, action: nil),
        ]
        
        navigationController?.navigationBar.tintColor = .white
    }

    private func setupCollectionView() {
        goalListView.collectionView.delegate = self
        goalListView.collectionView.dataSource = self
    }
}

extension GoalListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Logger.log("clicked: \(indexPath.row)")
    }
}

extension GoalListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let defaultCell = DefaultCollectionViewCell()
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoalListCollectionViewCell.identifier, for: indexPath) as? GoalListCollectionViewCell else {
            return defaultCell
        }
        
        cell.configuration(goal: testArr[indexPath.row])
        
        return cell
    }
}
