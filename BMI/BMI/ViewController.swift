//
//  ViewController.swift
//  BMI
//
//  Created by 김민령 on 2023/01/30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heightTextField.delegate = self
        weightTextField.delegate = self
        
        initAttribute()
    }
    
    func initAttribute(){
        heightTextField.placeholder = "cm단위로 입력"
        weightTextField.placeholder = "kg단위로 입력"
    }

    @IBAction func tapResultButton(_ sender: Any) {
        guard let result = calculateBMI(height: heightTextField.text!, weight: weightTextField.text!) else {
            return
        }
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "BMI") as! BMIResultViewController
        vc.modalPresentationStyle = .fullScreen
        
        vc.result = result
        present(vc, animated: true)
        
    }
    
    func calculateBMI(height: String, weight: String) -> Float?{
        guard let h = Float(height), let w = Float(weight) else { return nil }
        
        var bmi = w / (h*h) * 10000
        bmi = round(bmi*10) / 10
        return bmi

    }
    
}

extension ViewController : UITextFieldDelegate {
    
    //숫자만 입력 가능하게 조절
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if Int(string) != nil || string == "" {
            return true
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //두개 다 채웠으면 -> 키보드 내려
        //키만 채웠으면 -> 몸무게로 가
        //아니면 false
        if heightTextField.text != "", weightTextField.text != "" {
            self.view.endEditing(true)
        } else if heightTextField.text != "" {
            weightTextField.becomeFirstResponder()
        }
        return true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

