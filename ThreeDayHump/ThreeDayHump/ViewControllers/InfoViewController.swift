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
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        versionLabel.text = "version \(version ?? "0.0.0")"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
