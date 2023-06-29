//
//  InfoViewController.swift
//  ThreeDayHump
//
//  Created by 유정주 on 2022/01/31.
//

import UIKit

final class InfoViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!
        
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "앱 정보"
        self.navigationController?.navigationBar.tintColor = .white
        
        versionLabel.text = "현재 버전: \(BaseData.shared.currentVersion)\n최신 버전: \(BaseData.shared.lastetVersion)"
        
        createUpdateButton()
    }
    
    //MARK: - Methods
    func createUpdateButton() {
        updateButton.layer.cornerRadius = 10
        updateButton.layer.borderWidth = 1.5
        updateButton.layer.borderColor = UIColor.label.withAlphaComponent(0.5).cgColor
        
        if BaseData.shared.isNeedUpdate {
            updateButton.setTitle("최신 버전으로 업데이트", for: .normal)
            updateButton.isEnabled = true
        } else {
            updateButton.setTitle("최신 버전 사용 중", for: .normal)
            updateButton.isEnabled = false
        }
    }
    
    func openAppStore() {
        guard let url = URL(string: BaseData.shared.appStoreOpenUrlString) else {
            print("invalid app store url")
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            return
        } else {
            print("Can't open app store url")
            return
        }
    }
    
    //MARK: - @IBAction
    @IBAction func clickedUpdateButton(_ sender: UIButton) {
        openAppStore()
    }
}
