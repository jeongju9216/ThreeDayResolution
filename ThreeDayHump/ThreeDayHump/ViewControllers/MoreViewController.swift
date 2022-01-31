//
//  MoreViewController.swift
//  ThreeDayHump
//
//  Created by 유정주 on 2022/01/06.
//

import UIKit

class MoreViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    let moreCellIdentifier: String = "moreCell"
    let settings: [String] = ["앱 정보"]
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
        
        print("indexPath: \(indexPath.row)")
        var viewController = UIViewController()
        switch indexPath.row {
        case 0:
            viewController = self.storyboard?.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
        default:
            print("Default")
        }
        print("viewController: \(viewController)")
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
