//
//  ViewController.swift
//  Smart Building
//
//  Created by admin on 06/12/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let roomName = ["Weather Station","Green Land","Smart Water","Workspace","Salle System","Salle Reunion", "Localisation","Air Conditioner"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "RoomsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "roomCell")
        collectionView.register(UINib(nibName: "MapAndAirCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "extraCell")
    }


}
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roomName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let room = roomName[indexPath.row]
        
        if (indexPath.item < 6) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "roomCell", for: indexPath) as! RoomsCollectionViewCell
            cell.roomNameLabel.text = room
            cell.roomCellsView.layer.cornerRadius = 10
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "extraCell", for: indexPath) as! MapAndAirCollectionViewCell
            cell.title.text = room
            cell.roomExtraCellView.layer.cornerRadius = 10
            return cell
        }
    }
}

extension ViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        performSegue(withIdentifier: "goToSecondDashboard", sender: self)
    }
}
