//
//  BMIResultViewController.swift
//  NewWord
//
//  Created by 쌩 on 5/21/24.
//

import UIKit

class BMIResultViewController: UIViewController {
    
    var myBMI = 0.0
    var myHeight = 0
    var myWeight = 0
    var myBMIResult = ""
    
    @IBOutlet var heightAndWeghtLabel: UILabel!
    @IBOutlet var bmiResultLabel: UILabel!
    @IBOutlet var bmiValueLabel: UILabel!
    @IBOutlet var pointImageViewCollection: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkBMI()
        setUI()
        // Do any additional setup after loading the view.
    }
    
    private func setUI() {
        heightAndWeghtLabel.text = "신장 \(myHeight) / 체중 \(myWeight)"
        bmiResultLabel.text = "\(myBMIResult)입니다."
        bmiValueLabel.text = "\(myBMI)"
        
    }
    
    private func checkBMI() {
        switch myBMI {
        case 0..<18.5:
            myBMIResult = "저체중"
            pointImageViewCollection[0].image = UIImage(systemName: "hand.point.down.fill")
        case 18.5..<23:
            myBMIResult = "정상"
            pointImageViewCollection[1].image = UIImage(systemName: "hand.point.down.fill")
        case 23..<25:
            myBMIResult = "과체중"
            pointImageViewCollection[2].image = UIImage(systemName: "hand.point.down.fill")
        case 25...:
            myBMIResult = "비만"
            pointImageViewCollection[3].image = UIImage(systemName: "hand.point.down.fill")
        default:
            print("Error")
        }
    }
    
    //화면 돌아가기.
    @IBAction func viewControllerDismiss(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
