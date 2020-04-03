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
        //定数だと変更できないのでvar
        var width: CGFloat = 0
        width = ((collectionView.frame.width - 10) - 14 * 5) / 4
        //縦の大きさも変更されることを防ぐため
        let height = width
        //0のテキストの変更
        if indexPath.section == 4 && indexPath.row == 0 {
            width = width * 2 + 14 + 9
            }
        return .init(width: width, height: height)
        
    }
    
    //隙間の調整
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
    //マスの表示
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = calcularCollectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CalculatorViewCell
        //numbersの配列の文字の呼び出し
        cell.numberLabel.text = numbers[indexPath.section][indexPath.row]
        //numbersの中の中の数字にそれぞれの処理を行う
        numbers[indexPath.section][indexPath.row].forEach{ (numberString) in
            if "0"..."9" ~= numberString || numberString.description == "."{
                cell.numberLabel.backgroundColor = .darkGray
            }else if numberString == "C" || numberString == "%" || numberString == "$" {
                    cell.numberLabel.backgroundColor = UIColor.init(white: 1, alpha: 0.7)
                cell.numberLabel.textColor = .black
                }
            }
        return cell
    }
    //それぞれの数字の情報を取得しナンバー表示させる
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let number = numbers[indexPath.section][indexPath.row]
        
        switch  calculateStates {
        case .none:
            switch number {
            case "0"..."9":
                //ナンバーに追加して表示してくれる
                firstNumber += number
                numberLabel.text = firstNumber
            case "+":
                calculateStates = .plus
            case "-":
                calculateStates = .minus
            case "×":
                calculateStates = .multiplication
            case "÷":
                calculateStates = .division
            case "C":
                clear()
            default:
                break
            }
        case .plus, .minus, .multiplication, .division:
            switch  number {
            case "0"..."9":
            secondNumber += number
            numberLabel.text = secondNumber
            case "=":
                
                
                let firstNum = Double(firstNumber) ?? 0
                let secondNum = Double(secondNumber) ?? 0
                
                switch calculateStates {
                case .plus:
                    numberLabel.text = String(firstNum + secondNum)
                case .minus:
                    numberLabel.text = String(firstNum - secondNum)
                case .multiplication:
                    numberLabel.text = String(firstNum * secondNum)
                case .division:
                    numberLabel.text = String(firstNum / secondNum)
                default:
                    break
                }
                
            case "C":
                clear()
                
            default:
                break
            }
        default:
            break
        }
        
    }
    //ボタンのCの機能
    func  clear(){
        firstNumber = ""
        secondNumber = ""
        numberLabel.text = "0"
        calculateStates = .none
    }

    //状態の管理
    enum CaluclateStates {
        case none, plus, minus, multiplication, division
    }
    var firstNumber = ""
    var secondNumber = ""
    var calculateStates: CaluclateStates = .none
    
    
    let numbers = [
        ["C","%","$","÷"],
        ["7","8","9","×"],
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
        //両端の幅の修正
        calcularCollectionView.contentInset = .init(top: 0, left: 14, bottom: 0, right: 14)
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
