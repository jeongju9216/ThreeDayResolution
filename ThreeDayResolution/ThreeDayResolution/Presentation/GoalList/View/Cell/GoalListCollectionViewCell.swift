//
//  GoalListCollectionViewCell.swift
//  ThreeDayResolution
//
//  Created by 유정주 on 2023/06/29.
//

import UIKit

final class GoalListCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Views
    private var maskingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.layer.cornerRadius = 10
        view.backgroundColor = .black
        view.alpha = 0.3
        
        return view
    }()
    
    //왼쪽 칸 이미지
    private var completeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    //제목, 마지막 달성 날짜 label 스택
    private lazy var labelStackView: UIStackView = {
        let stackView: UIStackView = .init(arrangedSubviews: [titleLabel, lastCompletedDateLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.backgroundColor = .textField
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return stackView
    }()
    
    //제목 label
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        label.adjustsFontSizeToFitWidth = true //글자 크기 유동적으로 변경
        label.numberOfLines = 1
        
        return label
    }()
    
    //마지막 달성 날짜 label
    private var lastCompletedDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.numberOfLines = 1
        
        return label
    }()
    
    //달성 횟수 label
    private var countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = .white
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        label.adjustsFontSizeToFitWidth = true //글자 크기 유동적으로 변경
        label.textAlignment = .center
        label.numberOfLines = 1
        
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        resetUI()
    }
    
    //MARK: - Setup
    private func setupUI() {
        setupContentView()
        setupCompleteImageView()
        setupCountLabel()
        setupLabelStackView()
        
        setupMaskingView()
    }
    
    private func resetUI() {
        maskingView.isHidden = true
        completeImageView.image = nil
        titleLabel.text = ""
        lastCompletedDateLabel.text = ""
        countLabel.text = ""
    }
    
    private func setupContentView() {
        contentView.backgroundColor = .main
        
        //그림자
        contentView.layer.masksToBounds = false
        contentView.layer.shadowOpacity = 0.8
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowColor = UIColor.darkGray.cgColor
        
        //모서리 둥글게
        contentView.layer.cornerRadius = 10
    }
    
    private func setupMaskingView() {
        addSubview(maskingView)
        NSLayoutConstraint.activate([
            maskingView.widthAnchor.constraint(equalTo: widthAnchor),
            maskingView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    private func setupCompleteImageView() {
        addSubview(completeImageView)
        NSLayoutConstraint.activate([
            completeImageView.widthAnchor.constraint(equalToConstant: 40),
            completeImageView.heightAnchor.constraint(equalToConstant: 40),
            completeImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            completeImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
        ])
    }
    
    private func setupLabelStackView() {
        addSubview(labelStackView)
        NSLayoutConstraint.activate([
            labelStackView.heightAnchor.constraint(equalTo: heightAnchor),
            labelStackView.leftAnchor.constraint(equalTo: completeImageView.rightAnchor, constant: 10),
            labelStackView.rightAnchor.constraint(equalTo: countLabel.leftAnchor, constant: -15)
        ])
    }
    
    private func setupCountLabel() {
        addSubview(countLabel)
        NSLayoutConstraint.activate([
            countLabel.widthAnchor.constraint(equalToConstant: 40),
            countLabel.heightAnchor.constraint(equalToConstant: 40),
            countLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            countLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
        ])
    }
    
    //MARK: - Methods
    func configuration(goal: Goal) {
        resetUI()
        
        //0, 1, 2, 3일차에 맞는 이미지 표시
        let completeImageName: String
        if goal.isCompleted && goal.count % 3 == 0 {
            completeImageName = "CompleteImage4"
        } else {
            completeImageName = "CompleteImage\(goal.count % 3 + 1)"
        }
        let completeImage = UIImage(named: completeImageName)
        completeImageView.image = completeImage
        
        titleLabel.text = goal.goal
        lastCompletedDateLabel.text = goal.displayLastCompleteDate
        countLabel.text = "\(goal.count)일"
        
        //오늘 완료한 목표는 회색으로 표시
        if goal.isCompleted {
            maskingCompleteGoal()
        }
    }
    
    private func maskingCompleteGoal() {
        maskingView.isHidden = false
        
        completeImageView.alpha = 0.5
        labelStackView.alpha = 0.5
        countLabel.alpha = 0.5
        
        contentView.layer.shadowOpacity = 0
    }
}
