//
//  InfoViewController.swift
//  ThreeDayHump
//
//  Created by 유정주 on 2022/01/31.
//

import UIKit

class InfoViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    
    var version: String = "0.0.0", appStoreVersion: String = "0.0.0"
    let appStoreUrl = "http://itunes.apple.com/kr/lookup?bundleId=com.jeong9216.ThreeDayHump"
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "앱 정보"
        self.navigationController?.navigationBar.tintColor = .white
        
        version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        appStoreVersion = loadAppStoreVersion()

        print("version: \(version), appStoreVersion: \(appStoreVersion)")
        
        versionLabel.text = "현재 버전: \(version)\n최신 버전: \(appStoreVersion)"
        
        updateButton.layer.cornerRadius = 10
        updateButton.layer.borderWidth = 1.5
        updateButton.layer.borderColor = UIColor.label.withAlphaComponent(0.5).cgColor
        
        if isNeedUpdate() {
            updateButton.setTitle("최신 버전으로 업데이트", for: .normal)
            updateButton.isEnabled = true
        } else {
            updateButton.setTitle("최신 버전 사용 중", for: .normal)
            updateButton.isEnabled = false
        }
    }
    
    //MARK: - Methods
    func openAppStore() {
        
    }
    
    func isNeedUpdate() -> Bool {
        let compareResult = version.compare(appStoreVersion, options: .numeric)
        switch compareResult {
        case .orderedAscending:
            return true
        case .orderedDescending, .orderedSame:
            return false
        }
    }
    
    func loadAppStoreVersion() -> String {
        
        guard let url = URL(string: appStoreUrl),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
              let results = json["results"] as? [[String: Any]] else {
            return ""
        }
                
        guard let appStoreVersion = results[0]["version"] as? String else {
            return ""
        }
                        
        return appStoreVersion
    }
    
    //MARK: - @IBAction
    @IBAction func clickedUpdateButton(_ sender: UIButton) {
    }
}

enum VersionError: Error {
    case invalidResponse, invalidBundleInfo
}
