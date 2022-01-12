//
//  ViewController.swift
//  ThreeDayHump
//
//  Created by 유정주 on 2022/01/02.
//

import UIKit

class GoalViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var goalBackgroundView: UIView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var goalTextField: UITextField!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initVies()
    }
    
    
    //MARK: - Overrides
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        goalTextField.endEditing(true)
    }
    
    //MARK: - IBActions
    @IBAction func clickedStartButton(_ sender: UIButton) {
        Goal.shared.goal = goalTextField.text ?? ""
    }
    
    //MARK: - Methods
    private func initVies() {
        initGoalView()
        initStartButton()
    }
    
    private func initGoalView() {
        goalBackgroundView.layer.cornerRadius = 15
        
        goalTextField.delegate = self
    }
    
    private func initStartButton() {
        startButton.layer.cornerRadius = 5
        
        startButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        startButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        startButton.layer.shadowOpacity = 1
        startButton.layer.masksToBounds = false
    }
}

extension GoalViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return false
        }
        
        if text.count == 1 && string.isEmpty {
            startButton.isEnabled = false
        } else {
            startButton.isEnabled = true
        }
        
        let maxLength = 11
        // 초과되는 텍스트 제거
        let newLength = text.count + string.count - range.length
        return newLength <= maxLength
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        goalTextField.endEditing(true)
        return true
    }
    
}

extension UITextView {
    func centerVerticalText() {
        let fitSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fitSize)
        let calculate = (bounds.size.height - size.height * zoomScale) / 2
        let offset = max(1, calculate)
        contentOffset.y = -offset
    }
}
