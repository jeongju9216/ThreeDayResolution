//
//  UIColor.swift
//  ThreeDayResolution
//
//  Created by 유정주 on 2023/06/29.
//

import UIKit

extension UIColor {
    static var main: UIColor {
        UIColor(named: "MainColor") ?? .label
    }
    
    static var tabBarItem: UIColor {
        UIColor(named: "TabColor") ?? .label
    }
    
    static var tabBackground: UIColor {
        UIColor(named: "TabBackgroundColor") ?? .systemBackground
    }
}
