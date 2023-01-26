//
//  ViewController.swift
//  FoundationApp
//
//  Created by 김민령 on 2023/01/26.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    var randomNumber = Int.random(in: 1...10)
    
    
    @IBAction func selectNumber(_ sender: UIButton) {
        let select = sender.currentTitle!
        
        numberLabel.text = select
        
    }
    
    
    
    @IBAction func tapReset(_ sender: UIButton) {
        mainLabel.text = "선택하세요"
        numberLabel.text = ""
        randomNumber = Int.random(in: 1...10)
    }
    
    
    @IBAction func tapSelect(_ sender: UIButton) {
        guard let select = Int(numberLabel.text!) else {
            return
        }
        
        if randomNumber == select {
            mainLabel.text = "BINGO😄"
        } else if randomNumber > select {
            mainLabel.text = "UP"
        } else {
            mainLabel.text = "DOWN"
        }
        
    }
    
}

