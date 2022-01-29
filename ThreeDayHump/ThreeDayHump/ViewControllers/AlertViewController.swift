//
//  AlertViewController.swift
//  ThreeDayHump
//
//  Created by 유정주 on 2022/01/29.
//

import UIKit

class AlertViewController: UIViewController {

    
    //MARK: - IBOutlets
    @IBOutlet weak var alertView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        alertView.layer.cornerRadius = 10
        cancelButton.layer.cornerRadius = 10
        cancelButton.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner)
        
        doneButton.layer.cornerRadius = 10
        doneButton.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner)
        
        doneButton.addTarget(self, action: #selector(onDoneClicked(_:)), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(onCancelClicked(_:)), for: .touchUpInside)
    }
    
    //MARK: - Methods
    @objc private func onDoneClicked(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }

    @objc private func onCancelClicked(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    
    private func setUpDoneButton(title: String, action: (_: UIButton) -> Void) {
        doneButton.titleLabel?.text = title
        doneButton.addTarget(self, action: #selector(action), for: .touchUpInside)
    }
    
    private func setUpCancelButton(title: String, action: UIAction) {
        cancelButton.titleLabel?.text = title
        cancelButton.addTarget(self, action: action, for: .touchUpInside)
    }
}
