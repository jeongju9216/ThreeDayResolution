//
//  UIFont.swift
//  ThreeDayResolution
//
//  Created by 유정주 on 2023/06/30.
//
import UIKit

extension UIFont {
    static func appleSDGothicNeoFont(ofSize: CGFloat, weight: UIFont.Weight = .bold) -> UIFont {
        switch weight {
        case .regular:
            return UIFont(name: "AppleSDGothicNeo-Regular", size: ofSize) ?? .systemFont(ofSize: ofSize)
        case .bold:
            return UIFont(name: "AppleSDGothicNeo-Bold", size: ofSize) ?? .systemFont(ofSize: ofSize)
        default:
            return UIFont(name: "AppleSDGothicNeo-Regular", size: ofSize) ?? .systemFont(ofSize: ofSize)
        }
    }
}
