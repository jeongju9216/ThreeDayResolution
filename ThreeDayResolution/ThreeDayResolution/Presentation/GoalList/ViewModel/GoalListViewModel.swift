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
    private(set) var goals: [Goal] = []
    private(set) var bookmarkedGoals: [Goal] = []
    var isEmptyList: Bool {
        return goals.isEmpty && bookmarkedGoals.isEmpty
    }
    
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
        } catch {
            goals = []
        }
    }
}
