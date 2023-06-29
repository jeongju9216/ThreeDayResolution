//
//  Goal.swift
//  ThreeDayHump
//
//  Created by 유정주 on 2022/01/08.
//

import Foundation

struct Goal: Hashable {
    var id: UUID = UUID()
    
    var goal: String //목표
    var count: Int = 0 //달성 횟수
    var createdAt: Date //생성 날짜
    var lastCompletedDate: Date? //마지막 완료 날짜
}

extension Goal {
    //오늘 완료 했는지
    var isCompleted: Bool {
        guard let lastCompletedDate = lastCompletedDate else {
            return false
        }
        
        return Calendar.current.isDateInToday(lastCompletedDate)
    }
}
