//
//  GoalListViewModel.swift
//  ThreeDayResolution
//
//  Created by 유정주 on 2023/06/29.
//

import Foundation
import Combine

enum GoalListViewModelActions {
    case fetch
}

final class GoalListViewModel {
    private let fetchUseCase: FetchGoalUseCase
    @Published private(set) var goals: [Goal] = []
    @Published private(set) var bookmarkedGoals: [Goal] = []
    
    init(fetchUseCase: FetchGoalUseCase) {
        self.fetchUseCase = fetchUseCase
    }
    
    func action(_ actions: GoalListViewModelActions) {
        switch actions {
        case .fetch:
            fetch()
        }
    }
}

extension GoalListViewModel {
    private func fetch() {
        do {
            let result = try fetchUseCase.excute()
            goals = result.filter { !$0.isBookmarked }
            bookmarkedGoals = result.filter { $0.isBookmarked }
            
            print("fetch result: \(result)")
        } catch {
            goals = []
        }
    }
}
