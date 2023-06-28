//
//  Goal.swift
//  ThreeDayHump
//
//  Created by 유정주 on 2022/01/08.
//

import Foundation

final class Goal {
    static let shared: Goal = Goal()
    
    var goal: String? {
        didSet {
            UserDefaults.standard.set(self.goal, forKey: "goal")
            UserDefaults.standard.synchronize()
        }
    }
    
    var day: Int = 0 {
        didSet {
            UserDefaults.standard.set(self.day, forKey: "day")
            UserDefaults.standard.synchronize()
        }
    }
    
    var destination: String {
        "작심 \(day)일"
    }
    
    var clickDate: Date? {
        didSet {
            UserDefaults.standard.set(self.clickDate, forKey: "clickDate")
            UserDefaults.standard.synchronize()
            
            print("Set Date: \(UserDefaults.standard.object(forKey: "clickDate") ?? "nil")")
        }
    }
    
    var isAlert: Bool {
        get {
            UserDefaults.standard.bool( forKey: "isAlert")
        }
        set (newValue) {
            UserDefaults.standard.set(newValue, forKey: "isAlert")
            UserDefaults.standard.synchronize()
        }
    }
    
    var isDone: Bool {
        get {
            guard let clickDate = UserDefaults.standard.object(forKey: "clickDate") as? Date else {
                return false
            }
            
            return Calendar.current.isDateInToday(clickDate)
        }
    }
}
