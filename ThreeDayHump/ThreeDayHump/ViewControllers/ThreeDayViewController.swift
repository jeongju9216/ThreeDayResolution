//
//  ThreeDayViewController.swift
//  ThreeDayHump
//
//  Created by 유정주 on 2022/01/08.
//

import UIKit
import AVFoundation

class ThreeDayViewController: BaseViewController {
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    //MARK: - IBOutlets
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    
    //MARK: - Properties
    private lazy var dayViews: [UIView] = [firstView, secondView, thirdView]
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(onForegroundAction), name: UIApplication.willEnterForegroundNotification, object: nil)

        initView()
        
        resetGoalViews()
        updateSquares()
        
        if checkAlreadyDone() {
            setupDoneStyle()
        } else {
            setupNotDoneStyle()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //alert 상태에서 앱을 재시작했을 때 Alert
        if Goal.shared.isAlert {
            alertSuccessThreeDay()
        }
    }
    
    //MARK: - IBActions
    @IBAction func onGiveUpClicked(_ sender: UIButton) {
        AudioServicesPlaySystemSound(1519)
        alertGiveUp()
    }
    
    @IBAction func onDoneClicked(_ sender: Any) {
        if checkAlreadyDone() {
            AudioServicesPlaySystemSound(1519)
            alert(message: "이미 완료했습니다.\n내일도 파이팅!")
        } else {
            addDay()
            
            let day = Goal.shared.day
            if day % 3 == 0 {
                AudioServicesPlaySystemSound(1520)
                fillAllSquares()
                alertSuccessThreeDay()
            } else {
                AudioServicesPlaySystemSound(1519)
                fillSquares(day % 3)
                alert(message: "작심 \(Goal.shared.day)일을 달성했어요.")
            }
        }
    }
    
    //MARK: - Methods
    private func addDay() {
        let date = Date()
        Goal.shared.clickDate = date
        
        animateSquare()
        setupDoneStyle()
        
        Goal.shared.day += 1
        dayLabel.text = Goal.shared.destination
    }
    
    @objc private func onForegroundAction() {        
        if checkAlreadyDone() {
            setupDoneStyle()
        } else {
            setupNotDoneStyle()
        }
    }
    
    
    private func initView() {
        goalLabel.text = Goal.shared.goal ?? ""
        dayLabel.text = Goal.shared.destination

        doneButton.layer.cornerRadius = 5
        doneButton.createShadow()
    }
    
    private func checkAlreadyDone() -> Bool {
        guard let clickDate = UserDefaults.standard.object(forKey: "clickDate") as? Date else {
            return false
        }
        
        return Calendar.current.isDateInToday(clickDate)
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
    
    private func animateSquare() {
        let animateIndex = Goal.shared.day % 3
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.dayViews[animateIndex].transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1) { [weak self] in
                self?.dayViews[animateIndex].transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        })
    }
    
    private func updateSquares() {
        if Goal.shared.day > 0 {
            let fillCount = Goal.shared.day % 3
            if fillCount == 0 && Goal.shared.isAlert {
                fillAllSquares()
            } else {
                fillSquares(fillCount)
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
    
    private func fillAllSquares() {
        for i in 0 ..< 3 {
            dayViews[i].backgroundColor = .white
        }
    }
    
    private func fillSquares(_ number: Int) {
        for i in 0 ..< number {
            dayViews[i].backgroundColor = .white
        }
    }
    
    private func alert(message: String) {
        let alertViewController = AlertViewController(titleText: "안내", messageText: message, doneText: "확인", doneAction: UIAction { [weak self] _ in
            self?.dismiss(animated: false, completion: nil)
        })
        present(alertViewController, animated: false, completion: nil)
    }
    
    private func alertSuccessThreeDay() {
        Goal.shared.isAlert = true
        
        let titleText = "성공"
        let messageText = "축하합니다!\n작심 \(Goal.shared.day)일을 성공했어요🥳"
        
        let doneAction = UIAction { [weak self] _ in
            self?.dismiss(animated: false, completion: nil)

            Goal.shared.isAlert = false
            self?.resetGoalViews()
        }
        
        let cancelAction = UIAction { [weak self] _ in
            self?.dismiss(animated: false, completion: nil)

            Goal.shared.isAlert = false
            self?.resetUserDefaults()
            self?.showGoalViewController()
        }
        
        let alertViewController = AlertViewController(titleText: titleText, messageText: messageText, doneText: "계속 도전하기", cancelText: "그만하기", doneAction: doneAction, cancelAction: cancelAction)
        present(alertViewController, animated: false, completion: nil)
    }
    
    private func alertGiveUp() {
        let titleText = "경고"
        let messageText = "작심 \(Goal.shared.day)일입니다.\n여기에서 포기하시겠습니까?"
        
        let doneAction = UIAction { [weak self] _ in
            self?.dismiss(animated: false, completion: nil)

            self?.resetUserDefaults()
            self?.showGoalViewController()
        }
        
        let cancelAction = UIAction { [weak self] _ in
            self?.dismiss(animated: false, completion: nil)
        }
        
        let alertViewController = AlertViewController(titleText: titleText, messageText: messageText, doneText: "포기하기", cancelText: "취소", doneAction: doneAction, cancelAction: cancelAction)
        present(alertViewController, animated: false, completion: nil)
    }
}
