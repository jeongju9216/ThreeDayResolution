//
//  GoalRepository.swift
//  ThreeDayResolution
//
//  Created by 유정주 on 2023/06/30.
//

import Foundation

final class GoalRepository: GoalRepositoryProtocol {
    private let storage = GoalStorage()
    
    func fetch() throws -> [Goal] {
        try storage.fetch()
    }
    
    func save(goal: Goal) throws {
        try storage.save(goal: goal)
    }
    
    func update(goal: Goal) throws {
        try storage.update(goal: goal)
    }
    
    func delete(goal: Goal) throws {
        try storage.delete(goal: goal)
    }
}
