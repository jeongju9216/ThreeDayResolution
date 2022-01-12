//
//  UIButton.swift
//  ThreeDayHump
//
//  Created by 유정주 on 2022/01/08.
//

import Foundation
import UIKit

extension UIButton {
    func createShadow() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
    }
}
