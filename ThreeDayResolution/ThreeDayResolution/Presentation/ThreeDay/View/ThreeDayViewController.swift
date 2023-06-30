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

        setupUI()
        
        resetGoalViews()
        paintSquares()
        
        if goal.isCompleted {
            applyCompleteStyle()
        } else {
            applyNotCompleteStyle()
        }
    }
    
    //MARK: - Actions
    @objc private func giveUp() {
        Logger.log("Click Give Up")
        
        weakVibration()
        alertGiveUp()
    }
    
    @IBAction func clickedDoneButton(_ sender: Any) {
        if goal.isCompleted {
            weakVibration()
            alert(message: "오늘은 이미 해내셨어요.\n내일도 파이팅!")
        } else {
            completeGoal()

            let day = goal.count
            var fillCount: Int
            if day % 3 == 0 {
                strongVibration()
                fillCount = 3
                alertSuccessThreeDayResolution()
            } else {
                weakVibration()
                fillCount = day % 3
                alert(message: "작심 \(day)일을 달성했어요.")
            }

            for i in 0..<fillCount {
                dayViews[i].backgroundColor = .white
            }
        }
    }
    
    //MARK: - Setup
    private func setupUI() {
        setupNavigationBar()
        
        goalLabel.text = goal.goal
        dayLabel.text = goal.displayCount
        
        doneButton.layer.cornerRadius = 5
        doneButton.createShadow()
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "flag.fill"), style: .done, target: self, action: #selector(giveUp)),
        ]
    }
    
    //MARK: - Methods
    private func applyCompleteStyle() {
        UIView.animate(withDuration: 0.05, animations: { [weak self] in
            self?.doneButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        })
        
        doneButton.removeShadow()
        doneButton.backgroundColor = .none
        doneButton.titleLabel?.textColor = UIColor(named: "TabColor")
    }
    
    private func applyNotCompleteStyle() {
        doneButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        doneButton.createShadow()
        doneButton.backgroundColor = .textField
        doneButton.titleLabel?.textColor = .buttonTitleColor
    }

    private func completeGoal() {
        //마지막 달성 날짜를 현재로 설정
        animateSquare()
        applyCompleteStyle()
        
        goal.lastCompletedDate = Date()
        goal.count += 1
        dayLabel.text = goal.displayCount
    }
    
    private func animateSquare() {
        let animateIndex = goal.count % 3
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.dayViews[animateIndex].transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1) { [weak self] in
                self?.dayViews[animateIndex].transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        })
    }
    
    private func paintSquares() {
        if goal.count > 0 {
            var fillCount = goal.count % 3
            if fillCount == 0 && goal.isCompleted {
                fillCount = 3
            }

            for i in 0..<fillCount {
                dayViews[i].backgroundColor = .white
            }
        }
    }
    
    private func resetGoalViews() {
        for i in 0..<3 {
            dayViews[i].layer.cornerRadius = 10
            dayViews[i].layer.borderWidth = 5
            dayViews[i].layer.borderColor = UIColor.white.cgColor
            dayViews[i].layer.backgroundColor = .none
        }
    }
    
    private func alertSuccessThreeDayResolution() {
        let title = "성공"
        let message = "축하합니다!\n작심 \(goal.count)일을 성공했어요🥳"

        let doneAction = UIAction { [weak self] _ in
            self?.dismiss(animated: false, completion: nil)
        }

        let cancelAction = UIAction { [weak self] _ in
            self?.dismiss(animated: false, completion: nil)
            self?.navigationController?.popViewController(animated: true) //ThreeDayVC 삭제
        }
        
        alert(title: title, message: message, doneTitle: "계속 도전하기", doneAction: doneAction, cancelTitle: "그만하기", cancelAction: cancelAction)
    }
    
    private func alertGiveUp() {
        let title = "경고"
        let message = "작심 \(goal.count)일입니다.\n여기에서 포기하시겠습니까?"

        let doneAction = UIAction { [weak self] _ in
            self?.dismiss(animated: false, completion: nil) //알람 VC 삭제
            self?.navigationController?.popViewController(animated: true) //ThreeDayVC 삭제
        }

        let cancelAction = UIAction { [weak self] _ in
            self?.dismiss(animated: false, completion: nil) //알람 VC 삭제
        }

        alert(title: title, message: message, doneTitle: "포기", doneAction: doneAction, cancelAction: cancelAction)
    }
    
    private func strongVibration() {
        AudioServicesPlaySystemSound(1520) //강한 진동
    }
    
    private func weakVibration() {
        AudioServicesPlaySystemSound(1519)
    }
}
