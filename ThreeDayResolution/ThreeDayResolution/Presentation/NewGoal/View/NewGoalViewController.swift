//
//  NewGoalViewController.swift
//  ThreeDayHump
//
//  Created by 유정주 on 2022/01/02.
//

import UIKit

final class NewGoalViewController: UIViewController {

    //MARK: - Views
    @IBOutlet weak var goalBackgroundView: UIView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var goalTextField: UITextField!
    @IBOutlet weak var textCountLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    
    //MARK: - Properties
    private let viewModel: NewGoalViewModel = NewGoalViewModel(saveUseCase: .init())
    private let maxGoalLength = 15
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        
        goalTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        goalTextField.endEditing(true)
    }
    
    //MARK: - IBActions
    @IBAction func clickedStartButton(_ sender: UIButton) {
        goThreeDayVC()
    }
    
    //MARK: - Setup
    private func setupUI() {
        setupNavigationBar()
        setupTipLabel()
        textCountLabel.text = "(0/\(maxGoalLength))"
        goalBackgroundView.layer.cornerRadius = 10
        setupStartButton()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupStartButton() {
        startButton.setTitleColor(.buttonTitleColor, for: .normal)
        startButton.setTitleColor(.lightGray, for: .disabled)
        startButton.layer.cornerRadius = 5
        startButton.createShadow()
        
        disableStartButton()
    }
    
    private func setupTipLabel() {
        let tip1 = "짧은 목표는,"
        let tip2 = """
        단기간에 달성할 수 있어요.
        성취감을 더 자주 느낄 수 있습니다.
        
        명확하고 구체적이에요.
        집중력과 몰입도를 느낄 수 있습니다.
        
        실패 부담이 적어요.
        중간에 실패해도 다시 도전할 수 있습니다.
        """
        
        let tipTitles = [
            "단기간에 달성할 수 있어요.",
            "명확하고 구체적이에요.",
            "실패 부담이 적어요.",
        ]
        let tips = [
            "성취감을 더 자주 느낄 수 있습니다.",
            "집중력과 몰입도를 느낄 수 있습니다.",
            "중간에 실패해도 다시 도전할 수 있습니다."
        ]
        
        let tip = tip1 + "\n\n" + tip2
        
        let attributeString = NSMutableAttributedString(string: tip)
        let font = UIFont.appleSDGothicNeoFont(ofSize: 24)
        attributeString.addAttributes([.font: font], range: (tip as NSString).range(of: tip1))
        
        let font2 = UIFont.appleSDGothicNeoFont(ofSize: 18)
        tipTitles.forEach {
            attributeString.addAttributes([.font: font2], range: (tip as NSString).range(of: $0))
        }
        
        let font3 = UIFont.appleSDGothicNeoFont(ofSize: 15, weight: .regular)
        tips.forEach {
            attributeString.addAttributes([.font: font3], range: (tip as NSString).range(of: $0))
        }
        
        
        tipLabel.attributedText = attributeString
        
        tipLabel.textColor = .white
    }
    
    //MARK: - Methods
    private func goThreeDayVC() {
        guard let goalText = goalTextField.text,
              let threeDayVC = ThreeDayViewController.instantiate as? ThreeDayViewController else {
            return
        }
        
        let goal = Goal(goal: goalText, createdAt: .init())
        
        saveGoal(with: goal)
        
        threeDayVC.goal = goal
        navigationController?.pushViewController(threeDayVC, animated: true)
    }
    
    private func saveGoal(with goal: Goal) {
        viewModel.action(.save(goal))
    }
    
    private func enableStartButton() {
        startButton.alpha = 1
        startButton.isEnabled = true
    }
    
    private func disableStartButton() {
        startButton.alpha = 0.5
        startButton.isEnabled = false
    }
}

extension NewGoalViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return false
        }
        
        if text.count == 1 && string.isEmpty {
            disableStartButton()
        } else {
            enableStartButton()
        }
        
        // 초과되는 텍스트 제거
        let newLength = text.count + string.count - range.length
        textCountLabel.text = "(\(min(newLength, maxGoalLength))/\(maxGoalLength))"
        return newLength <= (maxGoalLength + 1)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        goalTextField.endEditing(true)
        return true
    }
    
}
