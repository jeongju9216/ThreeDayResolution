//
//  Goal.swift
//  ThreeDayHump
//
//  Created by 유정주 on 2022/01/08.
//

import Foundation

final class Goal {
    static let shared: Goal = Goal()
    
    var goal: String?
    var day: Int = 0
    
    var destination: String {
        "작심 \(day)일"
    }
}
