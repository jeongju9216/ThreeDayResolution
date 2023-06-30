//
//  GoalListView.swift
//  ThreeDayResolution
//
//  Created by 유정주 on 2023/06/29.
//

import UIKit

enum GoalListSections: Int, CaseIterable {
    case bookmark, goal
    
    var title: String {
        switch self {
        case .bookmark: return "즐겨찾기"
        case .goal: return "목표"
        }
    }
}

final class GoalListView: UIView {
    
    //MARK: - Views
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.backgroundColor = .tabBackground
        collectionView.contentInset = .init(top: 20, left: 0, bottom: 0, right: 0) //상단 여백 추가
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.register(GoalListCollectionViewCell.self, forCellWithReuseIdentifier: GoalListCollectionViewCell.identifier)
        collectionView.register(DefaultCollectionViewCell.self, forCellWithReuseIdentifier: DefaultCollectionViewCell.identifier)
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)
        
        return collectionView
    }()
    
    private var emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "도전 중인 목표가 없습니다.\n새로운 목표에 도전하세요."
        label.numberOfLines = 2
        label.textColor = .tabBarItem
        label.font = UIFont.appleSDGothicNeoFont(ofSize: 18)
        label.textAlignment = .center
        
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    private func setupUI() {
        self.backgroundColor = .tabBackground
        
        setupCollectionView()
        setupEmptyLabel()
    }
    
    private func setupCollectionView() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupEmptyLabel() {
        addSubview(emptyLabel)
        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor)
        ])
    }
    
    //MARK: - Methods
    func showEmptyUI() {
        collectionView.isHidden = true
        emptyLabel.isHidden = false
    }
    
    func showListUI() {
        collectionView.isHidden = false
        emptyLabel.isHidden = true
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            let itemWidth: CGFloat
            if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
                itemWidth = 0.49
            } else {
                itemWidth = 1.0
            }
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(itemWidth),
                                                  heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 0)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .absolute(100))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
            group.interItemSpacing = .fixed(20)
            
            let section = NSCollectionLayoutSection(group: group)
            let sectionInset = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 40, trailing: 15)
            section.contentInsets = sectionInset
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                    heightDimension: .estimated(24))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
            
            return section
        }
        
        return layout
    }

}
