//
//  RoomsCollectionViewCell.swift
//  Smart Building
//
//  Created by admin on 06/12/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class RoomsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var roomCellsView: UIView!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var roomTemperature: UILabel!
    @IBOutlet weak var roomHumidity: UILabel!
    @IBOutlet weak var roomPression: UILabel!
    
    
    override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
       }
}
