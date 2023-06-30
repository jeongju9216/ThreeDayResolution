//
//  ThreeDayViewController.swift
//  ThreeDayHump
//
//  Created by 유정주 on 2022/01/08.
//

import UIKit
import AVFoundation

final class ThreeDayViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    
    //MARK: - Properties
    private lazy var dayViews: [UIView] = [firstView, secondView, thirdView]
    var goal = Goal(goal: "", createdAt: .init())
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(onForegroundAction), name: UIApplication.willEnterForegroundNotification, object: nil)

        setupUI()
        
        resetGoalViews()
        paintSquares()
        
//        if Goal.shared.isDone {
//            setupDoneStyle()
//        } else {
//            setupNotDoneStyle()
//        }
    }
    
    //MARK: - Actions
    @IBAction func clickedGiveUpButton(_ sender: UIButton) {
        AudioServicesPlaySystemSound(1519)
        alertGiveUp()
    }
    
    @IBAction func clickedDoneButton(_ sender: Any) {
//        if Goal.shared.isDone {
//            AudioServicesPlaySystemSound(1519)
//            alert(message: "이미 완료했습니다.\n내일도 파이팅!")
//        } else {
//            addDay()
//
//            let day = Goal.shared.day
//            var fillCount: Int
//            if day % 3 == 0 {
//                AudioServicesPlaySystemSound(1520)
//                fillCount = 3
//                alertSuccessThreeDay()
//            } else {
//                AudioServicesPlaySystemSound(1519)
//                fillCount = day % 3
//                alert(message: "작심 \(Goal.shared.day)일을 달성했어요.")
//            }
//
//            for i in 0 ..< fillCount {
//                dayViews[i].backgroundColor = .white
//            }
//        }
    }
    
    //MARK: - Setup
    private func setupUI() {
        goalLabel.text = goal.goal
        dayLabel.text = goal.displayCount
        
        doneButton.layer.cornerRadius = 5
        doneButton.createShadow()
    }
    
    private func setupDoneStyle() {
        UIView.animate(withDuration: 0.05, animations: { [weak self] in
            self?.doneButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        })
        
        doneButton.removeShadow()
        doneButton.backgroundColor = .none
        doneButton.titleLabel?.textColor = UIColor(named: "TabColor")
    }
    
    private func setupNotDoneStyle() {
        doneButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        doneButton.createShadow()
        doneButton.backgroundColor = UIColor(named: "TextFieldColor")
        doneButton.titleLabel?.textColor = UIColor(named: "LabelColor")
    }
    
    //MARK: - Methods
    private func addDay() {
        let date = Date()
//        Goal.shared.clickDate = date
        
        animateSquare()
        setupDoneStyle()
        
//        Goal.shared.day += 1
//        dayLabel.text = Goal.shared.destination
    }
    
    @objc private func onForegroundAction() {        
//        if Goal.shared.isDone {
//            setupDoneStyle()
//        } else {
//            setupNotDoneStyle()
//        }
    }
    
    func showGoalViewController() {
        let tabBarController = self.tabBarController
        
        let goalViewController = NewGoalViewController.instantiate
        let moreViewController = MoreViewController.instantiate
        
        tabBarController?.setViewControllers([goalViewController, moreViewController], animated: false)
    }
    
    private func animateSquare() {
//        let animateIndex = Goal.shared.day % 3
//        UIView.animate(withDuration: 0.1, animations: { [weak self] in
//            self?.dayViews[animateIndex].transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
//        }, completion: { _ in
//            UIView.animate(withDuration: 0.1) { [weak self] in
//                self?.dayViews[animateIndex].transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//            }
//        })
    }
    
    private func paintSquares() {
//        if Goal.shared.day > 0 {
//            var fillCount = Goal.shared.day % 3
//            if fillCount == 0 && Goal.shared.isAlert {
//                fillCount = 3
//            }
//
//            for i in 0 ..< fillCount {
//                dayViews[i].backgroundColor = .white
//            }
//        }
    }
    
    private func resetGoalViews() {
        for i in 0..<3 {
            dayViews[i].layer.cornerRadius = 10
            dayViews[i].layer.borderWidth = 5
            dayViews[i].layer.borderColor = UIColor.white.cgColor
            dayViews[i].layer.backgroundColor = .none
        }
    }
    
    private func alert(message: String) {
        let alertViewController = AlertViewController(titleText: "안내", messageText: message, doneText: "확인", doneAction: UIAction { [weak self] _ in
            self?.dismiss(animated: false, completion: nil)
        })
        present(alertViewController, animated: false, completion: nil)
    }
    
    private func alertSuccessThreeDay() {
//        Goal.shared.isAlert = true
//
//        let title = "성공"
//        let message = "축하합니다!\n작심 \(Goal.shared.day)일을 성공했어요🥳"
//
//        let doneAction = UIAction { [weak self] _ in
//            self?.dismiss(animated: false, completion: nil)
//
//            Goal.shared.isAlert = false
//            self?.resetGoalViews()
//        }
//
//        let cancelAction = UIAction { [weak self] _ in
//            self?.dismiss(animated: false, completion: nil)
//
//            Goal.shared.isAlert = false
//            self?.resetUserDefaults()
//            self?.showGoalViewController()
//        }
//
//        let alertViewController = AlertViewController(titleText: title, messageText: message, doneText: "계속 도전하기", cancelText: "그만하기", doneAction: doneAction, cancelAction: cancelAction)
//        present(alertViewController, animated: false, completion: nil)
    }
    
    private func alertGiveUp() {
//        let titleText = "경고"
//        let messageText = "작심 \(Goal.shared.day)일입니다.\n여기에서 포기하시겠습니까?"
//
//        let doneAction = UIAction { [weak self] _ in
//            self?.dismiss(animated: false, completion: nil)
//
//            self?.resetUserDefaults()
//            self?.showGoalViewController()
//        }
//
//        let cancelAction = UIAction { [weak self] _ in
//            self?.dismiss(animated: false, completion: nil)
//        }
//
//        let alertViewController = AlertViewController(titleText: titleText, messageText: messageText, doneText: "포기하기", cancelText: "취소", doneAction: doneAction, cancelAction: cancelAction)
//        present(alertViewController, animated: false, completion: nil)
    }
    
    func resetUserDefaults() {
//        Goal.shared.goal = ""
//        Goal.shared.day = 0
//
//        UserDefaults.standard.removeObject(forKey: "goal")
//        UserDefaults.standard.removeObject(forKey: "day")
    }

}
