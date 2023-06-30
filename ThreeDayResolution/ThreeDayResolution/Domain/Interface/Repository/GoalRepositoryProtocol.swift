//
//  GoalRepositoryProtocol.swift
//  ThreeDayResolution
//
//  Created by 유정주 on 2023/06/30.
//

import Foundation

protocol GoalRepositoryProtocol {
    func fetch() throws -> [Goal]
    func save(goal: Goal) throws
    func update(goal: Goal) throws
    func delete(goal: Goal) throws
}
