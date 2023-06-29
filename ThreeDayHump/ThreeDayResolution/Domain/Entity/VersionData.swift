//
//  VersionData.swift
//  ThreeDayResolution
//
//  Created by 유정주 on 2023/06/29.
//

import Foundation

struct VersionData: Codable {
    let forced: String //강제 업데이트 버전
    let lasted: String //최신 버전
    let appleID: String //앱 애플 아이디
    let bundleID: String //번들 아이디
}

struct StateData: Codable {
    enum StateResult: String, Codable {
        case ok = "ok"
        case fail = "fail"
    }

    let state: StateResult //서버 상태 정상: ok, 비정상: fail
    let notice: String //서버 공지(안내 메시지)
}
