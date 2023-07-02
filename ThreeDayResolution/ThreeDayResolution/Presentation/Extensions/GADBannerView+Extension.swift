//
//  GADBannerView.swift
//  ThreeDayResolution
//
//  Created by 유정주 on 2023/07/02.
//

import UIKit
import GoogleMobileAds

extension GADBannerView {
    static func createBannerView() -> GAMBannerView {
        let bannerView = GAMBannerView()
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        
        bannerView.adUnitID = BaseData.shared.adUnitID
        
        return bannerView
    }
    
    func showSmoothly() {
        self.alpha = 0
        UIView.animate(withDuration: 1) {
            self.alpha = 1
        }
    }
}
