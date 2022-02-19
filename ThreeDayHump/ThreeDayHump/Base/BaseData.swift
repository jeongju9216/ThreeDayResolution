//
//  BaseData.swift
//  ThreeDayHump
//
//  Created by 유정주 on 2022/02/19.
//

import Foundation

struct BaseData {
    static var shared = BaseData()
    
    let appleID = "1604163049"
    let bundleID = "com.jeong9216.ThreeDayHump"
    
    var version = "0.0.0"
    var appStoreVersion = "0.0.0"
    
    var isNeedUpdate: Bool {
        get {
            let compareResult = version.compare(appStoreVersion, options: .numeric)
            switch compareResult {
            case .orderedAscending:
                return true
            case .orderedDescending, .orderedSame:
                return false
            }
        }
    }
}
