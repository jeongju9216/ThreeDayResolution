//
//  AlertViewController.swift
//  ThreeDayHump
//
//  Created by 유정주 on 2022/01/29.
//

import UIKit

enum AlertType: Int {
    case oneButton, twoButton
}

final class AlertViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var alertView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    //MARK: - Properties
    private var titleText:String? = "Title", messageText:String? = "Message"
    private var alertType: AlertType = .oneButton
    private var doneText: String = "", cancelText: String = ""
    private var doneAction: UIAction? = nil, cancelAction: UIAction? = nil
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initView()
        setUpButtonAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.alertView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1) { [weak self] in
                self?.alertView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        })
    }
    
    //MARK: - inits
    convenience init(titleText: String? = nil, messageText: String? = nil, doneText: String = "확인", doneAction: UIAction? = nil) {
        self.init()

        self.titleText = titleText
        self.messageText = messageText
        self.alertType = .oneButton
        self.doneText = doneText
        self.doneAction = doneAction
        
        modalPresentationStyle = .overFullScreen
    }
    
    convenience init(titleText: String? = nil, messageText: String? = nil, doneText: String = "확인", cancelText: String = "취소", doneAction: UIAction? = nil, cancelAction: UIAction? = nil) {
        self.init()
        
        self.titleText = titleText
        self.messageText = messageText
        self.alertType = .twoButton
        
        self.doneText = doneText
        self.doneAction = doneAction
        
        self.cancelText = cancelText
        self.cancelAction = cancelAction
        
        modalPresentationStyle = .overFullScreen
    }
    
    //MARK: - Methods
    private func initView() {
        alertView.isLayoutMarginsRelativeArrangement = true
        alertView.layoutMargins = UIEdgeInsets(top: 15.0, left: 0, bottom: 0, right: 0)
        alertView.layer.cornerRadius = 10
        
        titleLabel.text = titleText
        messageLabel.text = messageText
        
        initButton()
    }
    
    private func initButton() {
        doneButton.setTitle(doneText, for: .normal)
        cancelButton.setTitle(cancelText, for: .normal)
        
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
    }
    
    private func setUpButtonAction() {
        if let doneAction = doneAction {
            doneButton.addAction(doneAction, for: .touchUpInside)
        }
        
        if let cancelAction = cancelAction {
            cancelButton.addAction(cancelAction, for: .touchUpInside)
        }
    }
}
