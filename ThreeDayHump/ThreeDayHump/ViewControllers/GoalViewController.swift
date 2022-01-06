//
//  ViewController.swift
//  ThreeDayHump
//
//  Created by 유정주 on 2022/01/02.
//

import UIKit

class GoalViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var startButton: UIButton!

    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        initVies()
    }

    //MARK: - Overrides
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        goalTextView.endEditing(true)
    }
    
    
    //MARK: - Methods
    private func initVies() {
        goalTextView.backgroundColor = .white
        goalTextView.layer.cornerRadius = 15
        
        startButton.layer.cornerRadius = 5
        startButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        startButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        startButton.layer.shadowOpacity = 1
        startButton.layer.masksToBounds = false
    }

}

