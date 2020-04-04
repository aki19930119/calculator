//
//  ViewController.swift
//  calculator
//
//  Created by 柿沼儀揚 on 2020/03/31.
//  Copyright © 2020 柿沼儀揚. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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
    let cellId = "cellId"
    

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var calcularCollectionView: UICollectionView!
    @IBOutlet weak var calculatorHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        
        calcularCollectionView.delegate = self
        calcularCollectionView.dataSource = self
        calcularCollectionView.register (CalculatorViewCell.self, forCellWithReuseIdentifier: cellId)
        calculatorHeightConstraint.constant = view.frame.width * 1.4
        calcularCollectionView.backgroundColor = .clear
        //両端の幅の修正
        calcularCollectionView.contentInset = .init(top: 0, left: 14, bottom: 0, right: 14)
        
        numberLabel.text = "0"
        
        view.backgroundColor = .black
        
        
    }
    
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
    
    //ボタンのCの機能
    func  clear(){
        firstNumber = ""
        secondNumber = ""
        numberLabel.text = "0"
        calculateStates = .none
    }
}
// MARK: - UICollectionViewDelegate ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
//CollectionViewの拡張
extension ViewController: UICollectionViewDelegate ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //隙間の調整
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    //マスの表示
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = calcularCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CalculatorViewCell
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
            handleFirstNumberSelected(number: number)
        case .plus, .minus, .multiplication, .division:
            handleSecondNumberSelected(number: number)
     
        }
    }
    
    private func handleFirstNumberSelected(number: String){
        switch number {
          case "0"..."9":
              //ナンバーに追加して表示してくれる
              firstNumber += number
              numberLabel.text = firstNumber
              
              if firstNumber.hasPrefix("0"){
                  firstNumber = ""
              }
          //nilなら.を入れられる
          case ".":
              if !comfilmIncludeDecimalPoint(numberString: firstNumber){
                  firstNumber += number
                  numberLabel.text = firstNumber
              }
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
    }
    
    func  handleSecondNumberSelected(number: String){
        switch  number {
             case "0"..."9":
                secondNumber += number
                numberLabel.text = secondNumber
                if secondNumber.hasPrefix("0"){
                    secondNumber = ""
            }
        case ".":
            if !comfilmIncludeDecimalPoint(numberString: secondNumber){
                secondNumber += number
                numberLabel.text = secondNumber
            }
            
        case "=":
            calculateResultNumber()
        case "C":
            clear()
            
        default:
            break
        }
    }
    
    private func calculateResultNumber(){
        
        let firstNum = Double(firstNumber) ?? 0
        let secondNum = Double(secondNumber) ?? 0
        
        var resultString: String?
        switch calculateStates {
        case .plus:
            resultString = String(firstNum + secondNum)
        case .minus:
            resultString = String(firstNum - secondNum)
        case .multiplication:
            resultString = String(firstNum * secondNum)
        case .division:
            resultString = String(firstNum / secondNum)
        default:
            break
        }
        
        if let result = resultString, result.hasSuffix(".0"){
            resultString = result.replacingOccurrences(of: ".0", with: "")
        }
        
        numberLabel.text = resultString
        firstNumber = ""
        secondNumber = ""
        
        firstNumber += resultString ?? ""
        calculateStates = .none
    }
    
    private func comfilmIncludeDecimalPoint(numberString: String) -> Bool {
        if numberString.range(of: ".") != nil || numberString.count == 0 {
            return true
        } else {
            return false
        }
    }
}

