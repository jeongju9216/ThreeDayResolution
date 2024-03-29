//
//  BaseData.swift
//  ThreeDayHump
//
//  Created by 유정주 on 2022/02/19.
//

import Foundation

enum RunAppKey: String {
    case runDateKey = "Rundate"
    case runCountKey = "RunCount"
}

final class BaseData {
    static var shared = BaseData()
    private init() { }
    
    var appleID = ""
    var bundleID = ""
    var appStoreOpenUrlString: String { //앱 스토어 url
        "itms-apps://itunes.apple.com/app/apple-store/\(appleID)"
    }
    
    var currentVersion = "" //현재버전
    var lastetVersion = "" //최신버전
    var forcedUpdateVersion = "" //강제 업데이트 버전
    
    var policyURL: String = ""
    var adUnitID: String = ""
    
    var lastRunDate: Date? {
        get {
            UserDefaults.standard.object(forKey: RunAppKey.runDateKey.rawValue) as? Date
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: RunAppKey.runDateKey.rawValue)
        }
    }
    var runCount: Int {
        get {
            UserDefaults.standard.integer(forKey: RunAppKey.runCountKey.rawValue)
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: RunAppKey.runCountKey.rawValue)
        }
    }
}

extension BaseData {
    var isNeedUpdate: Bool { //업데이트가 필요한가?
        compareVersion(curruent: currentVersion, compare: lastetVersion)
    }
    
    var isNeedForcedUpdate: Bool { //강제 업데이트가 필요한가?
        compareVersion(curruent: currentVersion, compare: forcedUpdateVersion)
    }
    
    private func compareVersion(curruent: String, compare: String) -> Bool {
        let compareResult = curruent.compare(compare, options: .numeric)
        return compareResult == .orderedAscending
    }
}
