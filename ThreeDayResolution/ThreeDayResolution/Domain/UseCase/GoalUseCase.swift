//
//  GoalUseCase.swift
//  ThreeDayResolution
//
//  Created by 유정주 on 2023/06/30.
//

import Foundation

class GoalUseCase: GoalUseCaseProtocol {
    //todo: DI
    var repository: GoalRepositoryProtocol = GoalRepository()
}

final class FetchGoalUseCase: GoalUseCase, FetchGoalUseCaseProtocol {
    func excute() throws -> [Goal] {
        return try repository.fetch()
    }
}

final class SaveGoalUseCase: GoalUseCase, SaveGoalUseCaseProtocol {
    func excute(requestValue: Goal) throws {
        return try repository.save(goal: requestValue)
    }
}

final class UpdateGoalUseCase: GoalUseCase, UpdateGoalUseCaseProtocol {
    func excute(requestValue: Goal) throws {
        return try repository.update(goal: requestValue)
    }
}

final class DeleteGoalUseCase: GoalUseCase, DeleteGoalUseCaseProtocol {
    func excute(requestValue: Goal) throws {
        return try repository.delete(goal: requestValue)
    }
}
