//
//  Logger.swift
//  ThreeDayResolution
//
//  Created by 유정주 on 2023/06/29.
//

import Foundation
import OSLog

final class Logger {
    static func log<T>(level: OSLogType = .default, _ object: T?) {
        guard let object = object else {
            os_log(level, "%@", "object is nil")
            return
        }
        
        let message = "\(String(describing: object))"
        os_log(level, "%@", message)
    }
    
    static func error<T>(level: OSLogType = .error, _ object: T?) {
        guard let object = object else {
            os_log(level, "%@", "object is nil")
            return
        }
        
        let message = "\(String(describing: object))"
        os_log(level, "%@", message)
    }
}
