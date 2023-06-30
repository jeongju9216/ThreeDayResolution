//
//  InfoView.swift
//  ThreeDayResolution
//
//  Created by 유정주 on 2023/06/30.
//

import UIKit

final class InfoView: UIView {
    
    //MARK: - Views
    var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("닫기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        
        return button
    }()
    
    private var iconImageView: UIImageView = {
        let imageView: UIImageView
        if let iconImage = UIImage(named: "AppIconImage") {
            imageView = UIImageView(image: iconImage)
        } else {
            imageView = UIImageView()
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 120 / 5
        
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "작심삼일"
        label.font = UIFont.appleSDGothicNeoFont(ofSize: 32)

        return label
    }()
    
    private var versionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        label.text = "현재 버전 : \(BaseData.shared.currentVersion)\n최신 버전 : \(BaseData.shared.lastetVersion)"
        label.font = UIFont.appleSDGothicNeoFont(ofSize: 16)
        
        return label
    }()
    
    var policyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        button.setTitle("개인정보처리방침", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.systemBlue, for: .normal)
        
        button.alpha = 0.8
        
        return button
    }()
    
    var updateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let title: String = BaseData.shared.isNeedUpdate ? "최신 버전으로 업데이트" : "최신 버전"
        
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        
        button.setBackgroundColor(UIColor.main, for: .normal)
        button.layer.cornerRadius = 20 //heigth: 40 고정
        
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        
        if UITraitCollection.current.userInterfaceStyle == .light {
            button.setTitleColor(.white, for: .disabled)
        } else {
            button.setTitleColor(.lightGray, for: .disabled)
        }
        
        button.isEnabled = BaseData.shared.isNeedUpdate

        return button
    }()
    
    
    //MARK: - Properties
    private let iconSize: CGFloat = 120
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Setup
    private func setupUI() {
        setupCloseButton()
        setupIconImage()
        setupTitleLabel()
        setupVersionLabel()
        
        setupUpdateButton()
        setupPolicyButton()
    }
    
    private func setupCloseButton() {
        addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
    }
    
    private func setupIconImage() {
        addSubview(iconImageView)
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: iconSize),
            iconImageView.heightAnchor.constraint(equalToConstant: iconSize),
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 20)
        ])
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 20)
        ])
    }
    
    private func setupVersionLabel() {
        addSubview(versionLabel)
        NSLayoutConstraint.activate([
            versionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            versionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        ])
    }
    
    private func setupUpdateButton() {
        addSubview(updateButton)
        
        let width = min(self.frame.width - 80, 800)
        NSLayoutConstraint.activate([
            updateButton.widthAnchor.constraint(equalToConstant: width),
            updateButton.heightAnchor.constraint(equalToConstant: 40),
            versionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            versionLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupPolicyButton() {
        addSubview(policyButton)
        NSLayoutConstraint.activate([
            policyButton.centerXAnchor.constraint(equalTo: updateButton.centerXAnchor),
            policyButton.bottomAnchor.constraint(equalTo: updateButton.topAnchor, constant: -5)
        ])
    }
}
