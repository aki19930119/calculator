//
//  calculaterViewCell.swift
//  calculator
//
//  Created by 柿沼儀揚 on 2020/04/04.
//  Copyright © 2020 柿沼儀揚. All rights reserved.
//

import Foundation
import UIKit
//電卓専用のビュー
class CalculatorViewCell: UICollectionViewCell{
    //ボタンを押したとき色を薄くする
    override var isHighlighted: Bool{
        didSet{
            if isHighlighted {
                self.numberLabel.alpha = 0.3
            } else {
                self.numberLabel.alpha = 1
            }
        }
    }
    
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
