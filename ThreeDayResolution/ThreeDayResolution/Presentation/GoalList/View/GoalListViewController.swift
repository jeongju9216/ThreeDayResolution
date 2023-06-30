//
//  GoalListViewController.swift
//  ThreeDayResolution
//
//  Created by 유정주 on 2023/06/29.
//

import UIKit
import Combine

final class GoalListViewController: UIViewController {
    
    //MARK: - Views
    private let goalListView: GoalListView = GoalListView()
    
    //MARK: - Properties
    private let viewModel: GoalListViewModel = GoalListViewModel(fetchUseCase: FetchGoalUseCase())
    
    //MARK: - Life Cycles
    override func loadView() {
        view = goalListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Task {
            viewModel.action(.fetch)
            
            if viewModel.isEmptyList {
                goalListView.showEmptyUI()
            } else {
                goalListView.collectionView.reloadData()
                goalListView.showListUI()
            }
        }
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
            UIBarButtonItem(image: UIImage(systemName: "plus.app.fill"), style: .done, target: self, action: #selector(goGoalVC)),
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
        var section = indexPath.section
        if viewModel.bookmarkedGoals.isEmpty {
            section += 1
        }
        
        switch GoalListSections(rawValue: section) {
        case .bookmark:
            goThreeDayVC(goal: viewModel.bookmarkedGoals[indexPath.row])
        case .goal:
            goThreeDayVC(goal: viewModel.goals[indexPath.row])
        default: break
        }
    }
}

extension GoalListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if viewModel.bookmarkedGoals.isEmpty {
            return 1
        } else {
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var section = section
        if viewModel.bookmarkedGoals.isEmpty {
            section += 1
        }
        
        switch GoalListSections(rawValue: section) {
        case .bookmark:
            return viewModel.bookmarkedGoals.count
        case .goal:
            return viewModel.goals.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let defaultCell = DefaultCollectionViewCell()
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoalListCollectionViewCell.identifier, for: indexPath) as? GoalListCollectionViewCell else {
            return defaultCell
        }
        
        var section = indexPath.section
        if viewModel.bookmarkedGoals.isEmpty {
            section += 1
        }
        
        switch GoalListSections(rawValue: section) {
        case .bookmark:
            cell.configuration(goal: viewModel.bookmarkedGoals[indexPath.row])
        case .goal:
            cell.configuration(goal: viewModel.goals[indexPath.row])
        default: break
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
        
        var section = indexPath.section
        if viewModel.bookmarkedGoals.isEmpty {
            section += 1
        }
        
        switch GoalListSections(rawValue: section) {
        case .bookmark:
            if viewModel.bookmarkedGoals.isEmpty {
                headerCell.configuration("")
            } else {
                headerCell.configuration(GoalListSections.bookmark.title)
            }
        case .goal:
            headerCell.configuration(GoalListSections.goal.title)
        default: break
        }
        
        return headerCell
    }
}
