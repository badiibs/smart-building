//
//  SecondDashboardViewController.swift
//  Smart Building
//
//  Created by admin on 10/12/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class SecondDashboardViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    let iconsTable = ["temperature","humidity","rainfull","speed","direction","time","position"]
    let titleLabel = ["Temperature","Humidity","Rainfull","Speed","Direction","12:15:15 17 12 12","Position"]
    var deviceValues = ["12","13","14","15","14","",""]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.register(UINib(nibName: "FirstTableViewCell", bundle: nil), forCellReuseIdentifier: "firstCell")

    }
    

}
extension SecondDashboardViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iconsTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath) as! FirstTableViewCell
        cell.firstCellIcon.image = UIImage(named: "\(iconsTable[indexPath.row])")
        cell.firstCellLabel.text = titleLabel[indexPath.row]
        cell.firstCellValueLabel.text = deviceValues[indexPath.row]
        cell.firstCellView.layer.cornerRadius = 10
        return cell
    }
    
    
}
