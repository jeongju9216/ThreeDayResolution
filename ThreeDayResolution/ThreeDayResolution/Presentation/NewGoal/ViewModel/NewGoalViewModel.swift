//
//  NewGoalViewModel.swift
//  ThreeDayResolution
//
//  Created by 유정주 on 2023/06/30.
//

import Foundation

enum NewGoalViewModelActions {
    case save(Goal)
}

struct NewGoalViewModel {
    private let saveUseCase: SaveGoalUseCase
    
    init(saveUseCase: SaveGoalUseCase) {
        self.saveUseCase = saveUseCase
    }
    
    func action(_ actions: NewGoalViewModelActions) {
        switch actions {
        case .save(let goal):
            save(goal: goal)
        }
    }
}

extension NewGoalViewModel {
    private func save(goal: Goal) {
        do {
            try saveUseCase.excute(requestValue: goal)
            Logger.log("Success Save: \(goal)")
        } catch {
            Logger.error(error.localizedDescription)
        }
    }
}
