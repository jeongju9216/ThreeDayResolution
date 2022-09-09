//
//  MoreViewController.swift
//  ThreeDayHump
//
//  Created by 유정주 on 2022/01/06.
//

import UIKit

final class MoreViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    let moreCellIdentifier: String = "moreCell"
    let settings: [String] = ["앱 정보", "개인정보 취급방침"]
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MoreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.moreCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = settings[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            let viewController = InfoViewController.instantiate
            self.present(viewController, animated: true)
        case 1:
            guard let url = URL(string: "https://jeong9216.tistory.com/210") else {
                return
            }
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        default:
            break
        }
    }
}
