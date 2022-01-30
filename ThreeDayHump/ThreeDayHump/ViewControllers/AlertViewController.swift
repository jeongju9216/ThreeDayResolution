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
    
    //MARK: - Properties
    private var titleText:String? = "Title", messageText:String? = "Message"
    private var alertType: AlertType = .oneButton
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        alertView.isLayoutMarginsRelativeArrangement = true
        alertView.layoutMargins = UIEdgeInsets(top: 15.0, left: 0, bottom: 0, right: 0)
        alertView.layer.cornerRadius = 10
        
        cancelButton.layer.cornerRadius = 10
        doneButton.layer.cornerRadius = 10

        switch alertType {
        case .oneButton:
            cancelButton.isHidden = true
            doneButton.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)

        case .twoButton:
            cancelButton.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner)
            doneButton.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner)
        }
        
        doneButton.addTarget(self, action: #selector(onDoneClicked(_:)), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(onCancelClicked(_:)), for: .touchUpInside)
        
        titleLabel.text = titleText
        messageLabel.text = messageText
    }
    
    convenience init(titleText: String? = nil, messageText: String? = nil, alertType: AlertType) {
        self.init()

        self.titleText = titleText
        self.messageText = messageText
        self.alertType = alertType
        
        modalPresentationStyle = .overFullScreen
    }
    
    //MARK: - Methods
    @objc private func onDoneClicked(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }

    @objc private func onCancelClicked(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    
    public func setUpDoneButton(title: String) {
        doneButton.titleLabel?.text = title
    }
    
    public func setUpCancelButton(title: String) {
        cancelButton.titleLabel?.text = title
    }
}

enum AlertType: Int {
    case oneButton, twoButton
}
