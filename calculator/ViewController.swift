//
//  ViewController.swift
//  calculator
//
//  Created by 柿沼儀揚 on 2020/03/31.
//  Copyright © 2020 柿沼儀揚. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UICollectionViewDelegate ,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = calcularCollectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var calcularCollectionView: UICollectionView!
    @IBOutlet weak var calculatorHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calcularCollectionView.delegate = self
        calcularCollectionView.dataSource = self
        calcularCollectionView.register (UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        
    }
}

