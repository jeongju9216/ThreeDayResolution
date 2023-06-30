//
//  GoalUseCaseProtocol.swift
//  ThreeDayResolution
//
//  Created by 유정주 on 2023/06/30.
//

import Foundation

protocol GoalUseCaseProtocol {
    var repository: GoalRepositoryProtocol { get }
}

protocol FetchGoalUseCaseProtocol: GoalUseCaseProtocol {
    associatedtype ResponseType
    
    func excute() throws -> ResponseType
}

protocol SaveGoalUseCaseProtocol: GoalUseCaseProtocol {
    associatedtype RequestType
    
    func excute(requestValue: RequestType) throws
}

protocol UpdateGoalUseCaseProtocol: GoalUseCaseProtocol {
    associatedtype RequestType
    
    func excute(requestValue: RequestType) throws
}

protocol DeleteGoalUseCaseProtocol: GoalUseCaseProtocol {
    associatedtype RequestType
    
    func excute(requestValue: RequestType) throws
}

