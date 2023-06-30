//
//  InfoViewController.swift
//  ThreeDayHump
//
//  Created by 유정주 on 2022/01/31.
//

import UIKit

final class InfoViewController: UIViewController {

    //MARK: - Views
    private let infoView = InfoView()
    
    //MARK: - Life Cycles
    override func loadView() {
        view = infoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTargets()
    }
    
    //MARK: - Actions
    @objc private func clickedCloseButton() {
        self.dismiss(animated: true)
    }
    
    @objc private func clickedUpdateButton() {
        openURL(BaseData.shared.appStoreOpenUrlString)
    }
    
    @objc private func clickedPolicyButton() {
        openURL(BaseData.shared.policyURL)
    }
    
    //MARK: - Methods
    private func addTargets() {
        infoView.closeButton.addTarget(self,
                                              action: #selector(clickedCloseButton),
                                              for: .touchUpInside)
        infoView.updateButton.addTarget(self,
                                              action: #selector(clickedUpdateButton),
                                              for: .touchUpInside)
        infoView.policyButton.addTarget(self,
                                              action: #selector(clickedPolicyButton),
                                              for: .touchUpInside)
    }
    
    private func openURL(_ url: String) {
        guard let url = URL(string: url) else { return }
        
        UIApplication.shared.open(url)
    }
}
