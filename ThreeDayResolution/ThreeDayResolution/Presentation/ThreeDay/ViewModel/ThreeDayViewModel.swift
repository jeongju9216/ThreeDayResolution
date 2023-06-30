//
//  ThreeDayViewModel.swift
//  ThreeDayResolution
//
//  Created by 유정주 on 2023/06/30.
//

import Foundation

enum ThreeDayViewModelActions {
    case update(Goal)
    case delete(Goal)
}

struct ThreeDayViewModel {
    private let updateUseCase: UpdateGoalUseCase
    private let deleteUseCase: DeleteGoalUseCase
    
    init(updateUseCase: UpdateGoalUseCase, deleteUseCase: DeleteGoalUseCase) {
        self.updateUseCase = updateUseCase
        self.deleteUseCase = deleteUseCase
    }
    
    func action(_ actions: ThreeDayViewModelActions) {
        switch actions {
        case .update(let goal):
            update(goal: goal)
        case .delete(let goal):
            delete(goal: goal)
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
    
    private func delete(goal: Goal) {
        do {
            try deleteUseCase.excute(requestValue: goal)
        } catch {
            Logger.error(error.localizedDescription)
        }
    }
}
