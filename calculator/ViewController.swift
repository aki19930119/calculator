//
//  ViewController.swift
//  calculator
//
//  Created by 柿沼儀揚 on 2020/03/31.
//  Copyright © 2020 柿沼儀揚. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UICollectionViewDelegate ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers[section].count
    }
    //ブロックの間に隙間を作成
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) ->CGSize {
        return .init(width: collectionView.frame.width, height: 10)
        
    }
    
    //セルの長さを４分割する
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 3 * 10) / 4
        return .init(width: width, height: width)
    }
    
    //隙間の調整
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    //マスの表示
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = calcularCollectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CalculatorViewCell
        //numbersの配列の文字の呼び出し
        cell.numberLabel.text = numbers[indexPath.section][indexPath.row]
        
        return cell
    }
    
    let numbers = [
        ["C","%","$","+"],
        ["7","8","0","*"],
        ["4","5","6","-"],
        ["1","2","3","+"],
        ["0",".","="],
    ]

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var calcularCollectionView: UICollectionView!
    @IBOutlet weak var calculatorHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calcularCollectionView.delegate = self
        calcularCollectionView.dataSource = self
        calcularCollectionView.register (CalculatorViewCell.self, forCellWithReuseIdentifier: "cellId")
        calculatorHeightConstraint.constant = view.frame.width * 1.4
        calcularCollectionView.backgroundColor = .clear
        view.backgroundColor = .black
        
    }
}
//電卓専用のビュー
class CalculatorViewCell: UICollectionViewCell{
    //UILabelの作成
    let numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.text = "1"
        label.font = .boldSystemFont(ofSize: 32)
        label.clipsToBounds = true
        label.backgroundColor = .orange
        return label
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(numberLabel)
        //セルの大きさと同じ大きさに
        numberLabel.frame.size = self.frame.size
        numberLabel.layer.cornerRadius = self.frame.height / 2
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
