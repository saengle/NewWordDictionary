//
//  BmiCalculatorViewController.swift
//  NewWord
//
//  Created by 쌩 on 5/21/24.
//

import UIKit

class BmiCalculatorViewController: UIViewController {
    
    let bmiResultVC = BMIResultViewController()
    
    var userBMI = Double()
    var userHeight = Int()
    var userWeight = Int()
    
    @IBOutlet var doubleLineLabel: UILabel!
    
    @IBOutlet var heightTextFeild: UITextField!
    @IBOutlet var weightTextField: UITextField!
    
    @IBOutlet var nextButtonCollection: [UIButton]!
    
    @IBOutlet var pushBMIResultPageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doubleLineLabel.numberOfLines = 2
        doubleLineLabel.text = "당신의 BMI지수를\n알려드릴게요."
        
        heightTextFeild.tag = 0
        weightTextField.tag = 1
        configureButton()
    }
    
    private func configureButton() {
        makeButtonHide()
        nextButtonCollection.forEach{$0.layer.cornerRadius = 10}
        pushBMIResultPageButton.layer.cornerRadius = 10
    }
    
    private func makeButtonHide() {
        nextButtonCollection.forEach{$0.isHidden = true}
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        resetTextField()
    }
    
    private func resetTextField() {
        heightTextFeild.text = ""
        weightTextField.text = ""
        //뷰 넘어갈 때 텍스트필드 포커스 없애기.
        heightTextFeild.resignFirstResponder()
        weightTextField.resignFirstResponder()
    }
    
    private func calculateBMI() {
        // height, weight optional binding
        guard let myHeight = heightTextFeild.text else {
            return errorAlert()
        }
        guard let myWeight = weightTextField.text else {
            return errorAlert()
        }
        //계산이 용이하게 Double화
        guard let tempHeight = Double(myHeight) else {
            return errorAlert()
        }
        guard let weight = Double(myWeight) else {
            return errorAlert()
        }
        userHeight = Int(tempHeight)
        userWeight = Int(weight)
        //height 에 소수점 찍어주기
        let height = tempHeight / 100
        var bmi = weight / (height * height)
        bmi = round(bmi * 100) / 100
        userBMI = bmi
    }
    
    // Mark: validation Check & show next / push Button
    @IBAction func validationCheck(_ sender: UITextField) {
        guard let myText = sender.text else {
            return
        }
        if myText.first == "0" {
            sender.text = ""
        }
        
        if myText.count >= 2 {
            nextButtonCollection[sender.tag].isHidden = false
        }
        
        if myText.count >= 4 {
            sender.text = ""
            validationAlert(sender)
        }
    }
    
    // Mark: textfield에 4자리 이상 입력시
    private func validationAlert(_ sender: UITextField) {
        let alert = UIAlertController(title: "수치는 최대 3자리까지 입력 가능합니다.", message: "", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .destructive)
        alert.addAction(confirm)
        present(alert, animated: true)
    }
    
    // Mark: BMI계산시 입력값이 잘못되었을 때
    private func errorAlert() {
        let alert = UIAlertController(title: "올바른 수치를 입력해주세요", message: "", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .destructive)
        alert.addAction(confirm)
        present(alert, animated: true)
    }
    
    @IBAction func checkRandomBMI(_ sender: UIButton) {
        heightTextFeild.text = "\(Int.random(in: 1...999))"
        weightTextField.text = "\(Int.random(in: 1...250))"
        calculateBMI()
    }
    
    // Move Textfield Focus
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        makeButtonHide()
        weightTextField.becomeFirstResponder()
    }
    
    // if user end editing
    @IBAction func editingDidEnd(_ sender: UITextField) {
        makeButtonHide()
    }
    
    @IBAction func checkMyBMI(_ sender: UIButton) {
        calculateBMI()
        makeButtonHide()
    }
    
    @IBAction func returnKeyboardDismiss(_ sender: UITextField) {
    }
    
    @IBAction func tapEndTextEditing(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // segue 통해서 데이터 전달
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.destination is BMIResultViewController {
              guard let vc = segue.destination as? BMIResultViewController else { return }
              vc.myBMI = userBMI
              vc.myHeight = userHeight
              vc.myWeight = userWeight
          }
      }
 
}
