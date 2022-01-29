//
//  AlertViewController.swift
//  ThreeDayHump
//
//  Created by 유정주 on 2022/01/29.
//

import UIKit

class AlertViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func onDoneClicked(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    
}
