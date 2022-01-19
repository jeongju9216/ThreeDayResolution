//
//  ThreeDayViewController.swift
//  ThreeDayHump
//
//  Created by 유정주 on 2022/01/08.
//

import UIKit
import AVFoundation

class ThreeDayViewController: BaseViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    
    //MARK: - Properties
    private lazy var dayViews: [UIView] = [firstView, secondView, thirdView]
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.        
        initView()
        
        resetGoalViews()
        if Goal.shared.day > 0 {
            fillSquares(Goal.shared.day % 3)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //앱 밖에서 다크모드를 바꾼 경우
        resetGoalViews()
        if Goal.shared.day > 0 {
            fillSquares(Goal.shared.day % 3)
        }
    }
    
    //MARK: - IBActions
    @IBAction func clickedDone(_ sender: Any) {
        AudioServicesPlaySystemSound(1519)
        
        let beforeDay = Goal.shared.day
        UIView.animate(withDuration: 0.1, animations: {
                self.dayViews[beforeDay % 3].transform = CGAffineTransform(scaleX: 1.08, y: 1.08)
            }, completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.dayViews[beforeDay % 3].transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }
            })

        Goal.shared.day += 1
        dayLabel.text = Goal.shared.destination
        
        let day = Goal.shared.day
        print("day: \(day)")

        if day % 3 == 0 {
            fillAllSquares()
            alertSuccess()
        } else {
            fillSquares(day % 3)
        }
    }
    
    
    //MARK: - Methods
    private func initView() {
        goalLabel.text = Goal.shared.goal ?? ""

        doneButton.layer.cornerRadius = 5
        doneButton.createShadow()
    }
    
    private func resetGoalViews() {
        for i in 0..<3 {
            dayViews[i].layer.cornerRadius = 5
            dayViews[i].layer.borderWidth = 4
            dayViews[i].layer.borderColor = UIColor.white.cgColor
            dayViews[i].layer.backgroundColor = UIColor(named: "MainColor")?.cgColor
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
    
    private func alertSuccess() {
        // 메시지창 컨트롤러 인스턴스 생성
        let alert = UIAlertController(title: "알림", message: "알림 샘플 코드 입니다.", preferredStyle: UIAlertController.Style.alert)
        
        // 메시지 창 컨트롤러에 들어갈 버튼 액션 객체 생성
        let defaultAction =  UIAlertAction(title: "Finish", style: UIAlertAction.Style.default) { (action) in
            print("Click Default Button")
            
            self.showGoalViewController()
        }
        
        let destructiveAction = UIAlertAction(title: "Next", style: UIAlertAction.Style.default) { (action) in
            // 버튼 클릭시 실행되는 코드
            print("Click Next Button")
            
            self.resetGoalViews()
        }
        
        //메시지 창 컨트롤러에 버튼 액션을 추가
        alert.addAction(defaultAction)
        alert.addAction(destructiveAction)
        
        //메시지 창 컨트롤러를 표시
        self.present(alert, animated: false)
    }
}
