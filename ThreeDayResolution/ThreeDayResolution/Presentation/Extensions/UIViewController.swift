//
//  UIViewController.swift
//  ThreeDayHump
//
//  Created by 유정주 on 2022/09/09.
//

import UIKit

extension UIViewController {
    static var storyboard: UIStoryboard {
        UIStoryboard(name: String(describing: self), bundle: nil)
    }
    
    static var instantiate: UIViewController {
        storyboard.instantiateViewController(withIdentifier: String(describing: self))
    }
}

extension UIViewController {
    func alert(title: String = "안내", meesgae: String, doneTitle: String = "확인", doneAction: UIAction? = nil) {
        let alertVC = AlertViewController(titleText: title,
                                          messageText: meesgae,
                                          doneText: doneTitle,
                                          doneAction: doneAction)
        present(alertVC, animated: false, completion: nil)
    }
}
