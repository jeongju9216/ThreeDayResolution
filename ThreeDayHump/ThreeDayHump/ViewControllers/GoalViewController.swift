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
        goalTextView.delegate = self
        goalTextView.backgroundColor = .white
        goalTextView.layer.cornerRadius = 15
        goalTextView.textContainer.maximumNumberOfLines = 2
        goalTextView.textContainer.lineBreakMode = .byTruncatingTail
        
        startButton.layer.cornerRadius = 5
        startButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        startButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        startButton.layer.shadowOpacity = 1
        startButton.layer.masksToBounds = false
    }

}

extension GoalViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.centerVerticalText()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        goalTextView.centerVerticalText()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        goalTextView.centerVerticalText()

        
        guard let text = textView.text else {
            return
        }
        
        let maxLength = 20
        // 초과되는 텍스트 제거
        if text.count >= maxLength {
            let index = text.index(text.startIndex, offsetBy: maxLength)
            let newString = text[text.startIndex..<index]
            textView.text = String(newString)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            goalTextView.endEditing(true)
        }
        
        return true
    }
}

extension UITextView {
    func centerVerticalText() {
        self.textAlignment = .center
        let fitSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fitSize)
        let calculate = (bounds.size.height - size.height * zoomScale) / 2
        let offset = max(1, calculate)
        contentOffset.y = -offset
    }
}
