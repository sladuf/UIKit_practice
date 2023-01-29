//
//  BMIResultViewController.swift
//  BMI
//
//  Created by 김민령 on 2023/01/30.
//

import UIKit

class BMIResultViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    
    var result : Float?
    var bmi : BMI?

    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = result?.description
        BMIresult(result!)
        initAttribute()
    }

    @IBAction func tapBackButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func initAttribute(){
        
        switch bmi {
        case .under:
            resultLabel.backgroundColor = .green
            subLabel.text = "저체중"
        case .standard:
            resultLabel.backgroundColor = .yellow
            subLabel.text = "표준"
        case .over:
            resultLabel.backgroundColor = .systemPink
            subLabel.text = "과체중"
        case .moderate:
            resultLabel.backgroundColor = .cyan
            subLabel.text = "중도 비만"
        case .severe:
            resultLabel.backgroundColor = .red
            subLabel.text = "고도 비만"
        case .none:
            return
        }
    }
    
    
    func BMIresult(_ num : Float) {
        
        switch num {
        case ...18.5 :
            bmi = .under
        case ...22.9 :
            bmi = .standard
        case ...24.9 :
            bmi = .over
        case ...29.9 :
            bmi = .moderate
        default :
            bmi = .severe
        }
        
    }
}

enum BMI {
    case under
    case standard
    case over
    case moderate //중도비만
    case severe //고도비만
}

