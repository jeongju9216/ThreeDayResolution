//
//  ThreeDayViewController.swift
//  ThreeDayHump
//
//  Created by 유정주 on 2022/01/08.
//

import UIKit

class ThreeDayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = Goal.shared.goal ?? ""
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
