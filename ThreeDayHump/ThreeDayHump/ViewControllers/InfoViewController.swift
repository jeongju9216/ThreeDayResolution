//
//  InfoViewController.swift
//  ThreeDayHump
//
//  Created by 유정주 on 2022/01/31.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var versionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "앱 정보"
        self.navigationController?.navigationBar.tintColor = .white
        
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        let appStoreVersion = checkAppVersion()
        
        print("version: \(version), appStoreVersion: \(appStoreVersion)")
        
        versionLabel.text = "현재 버전: \(version)\n최신 버전: \(appStoreVersion)"
    }
    
    func checkAppVersion() -> String {
        let bundleID = "com.jeong9216.ThreeDayHump"
        guard let url = URL(string: "http://itunes.apple.com/kr/lookup?bundleId=\(bundleID)"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
              let results = json["results"] as? [[String: Any]],
              let appStoreVersion = results[0]["version"] as? String else {
                  return ""
              }
                        
        return appStoreVersion
    }
}

enum VersionError: Error {
    case invalidResponse, invalidBundleInfo
}
