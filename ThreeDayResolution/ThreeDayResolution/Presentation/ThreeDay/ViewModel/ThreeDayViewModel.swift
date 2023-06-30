//
//  ThreeDayViewModel.swift
//  ThreeDayResolution
//
//  Created by 유정주 on 2023/06/30.
//

import Foundation

enum ThreeDayViewModelActions {
    case update(Goal)
}

struct ThreeDayViewModel {
    private let updateUseCase: UpdateGoalUseCase
    init(updateUseCase: UpdateGoalUseCase) {
        self.updateUseCase = updateUseCase
    }
    
    func action(_ actions: ThreeDayViewModelActions) {
        switch actions {
        case .update(let goal):
            update(goal: goal)
        }
    }
}

extension ThreeDayViewModel {
    private func update(goal: Goal) {
        do {
            try updateUseCase.excute(requestValue: goal)
        } catch {
            Logger.error(error.localizedDescription)
        }
    }
}
