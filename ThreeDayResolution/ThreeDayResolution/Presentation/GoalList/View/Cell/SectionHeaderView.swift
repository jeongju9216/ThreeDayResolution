//
//  SectionHeaderView.swift
//  ThreeDayResolution
//
//  Created by 유정주 on 2023/06/29.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {

    //MARK: - Views
    private var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.appleSDGothicNeoFont(ofSize: 24)
        label.textColor = .white
        
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(headerLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerLabel.frame = bounds
    }
    
    //MARK: - Methods
    func configuration(_ text: String) {
        headerLabel.text = text
    }
}
