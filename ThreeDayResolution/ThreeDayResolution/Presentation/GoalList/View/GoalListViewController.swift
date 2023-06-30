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
    private var testArr: [Goal] = [
        Goal(goal: "TEST3", count: 3, createdAt: .init(), lastCompletedDate: .init(timeIntervalSinceNow: 0)),
        Goal(goal: "TEST1", count: 1, createdAt: .init(), lastCompletedDate: .init(timeIntervalSinceNow: -86400)),
        Goal(goal: "TEST2", count: 2, createdAt: .init(), lastCompletedDate: .init(timeIntervalSinceNow: 0)),
        Goal(goal: "TEST3", count: 2, createdAt: .init(), lastCompletedDate: .init(timeIntervalSinceNow: -10000000)),
        Goal(goal: "TEST4", count: 0, createdAt: .init())
    ]
    
    private var bookmarkedList: [Goal] = []
    
    
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
        //네비게이션바 백그라운드색 적용
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .main
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        
        //네비게이션바 아이템 적용
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "작심 0일", style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .done, target: self, action: #selector(goGoalVC)),
        ]
        
        //네비게이션바 아이템 색상 적용
        navigationController?.navigationBar.tintColor = .white
    }

    private func setupCollectionView() {
        goalListView.collectionView.delegate = self
        goalListView.collectionView.dataSource = self
    }
    
    //MARK: - Methods
    @objc private func goGoalVC() {
        let goalVC = NewGoalViewController.instantiate
        navigationController?.pushViewController(goalVC, animated: true)
    }
    
    private func goThreeDayVC(goal: Goal) {
        guard let threeDayVC = ThreeDayViewController.instantiate as? ThreeDayViewController else {
            return
        }
        
        threeDayVC.goal = goal
        navigationController?.pushViewController(threeDayVC, animated: true)
    }
}

extension GoalListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        goThreeDayVC(goal: testArr[indexPath.row])
    }
}

extension GoalListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if bookmarkedList.isEmpty {
            return 1
        } else {
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if bookmarkedList.isEmpty {
            return testArr.count
        } else {
            if section == 0 {
                return bookmarkedList.count
            } else {
                return testArr.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let defaultCell = DefaultCollectionViewCell()
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoalListCollectionViewCell.identifier, for: indexPath) as? GoalListCollectionViewCell else {
            return defaultCell
        }
        
        if bookmarkedList.isEmpty {
            cell.configuration(goal: testArr[indexPath.row])
        } else {
            if indexPath.section == 0 {
                cell.configuration(goal: bookmarkedList[indexPath.row])
            } else {
                cell.configuration(goal: testArr[indexPath.row])
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let defaultCell = DefaultCollectionViewCell()
        guard kind == UICollectionView.elementKindSectionHeader else {
            return defaultCell
        }
        
        guard let headerCell = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SectionHeaderView.identifier,
            for: indexPath) as? SectionHeaderView else {
            return defaultCell
        }
        
        
        if bookmarkedList.isEmpty {
            headerCell.configuration("목표")
        } else {
            headerCell.configuration(indexPath.section == 0 ? "즐겨찾기" : "목표")
        }
        
        
        return headerCell
    }
}
