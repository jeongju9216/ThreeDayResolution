//
//  BaseViewController.swift
//  ThreeDayHump
//
//  Created by 유정주 on 2022/01/19.
//

import UIKit

class BaseViewController: UIViewController {
    static let storyboard: UIStoryboard = UIStoryboard(name: String(describing: BaseViewController.self), bundle: nil)
    static let instantiate = storyboard.instantiateViewController(withIdentifier: String(describing: BaseViewController.self))
}
