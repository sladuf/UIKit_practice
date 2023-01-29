//
//  ViewController.swift
//  ConvertVC
//
//  Created by 김민령 on 2023/01/30.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func tapCodeNext(_ sender: Any) {
        let firstVC = FirstViewController()
        firstVC.modalPresentationStyle = .fullScreen
        
//        firstVC.senderString = "change string!"
        present(firstVC, animated: true)
    }
    
    
    @IBAction func tapStoryboardWithCode(_ sender: Any) {
        let secondVC = storyboard?.instantiateViewController(withIdentifier: "secondVC") as! SecondViewController
        secondVC.modalPresentationStyle = .fullScreen
        
//        secondVC.senderString = "change string!"
        present(secondVC, animated: true)


    }
    
    
    @IBAction func tapStoryboardWithSegue(_ sender: Any) {
    
        performSegue(withIdentifier: "toThirdVC", sender: self)
        
    }
    
    
    // segue로 데이터 전달하는 방법 : prepare를 override 해야함!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toThirdVC" {
            let thirdVC = segue.destination as! ThirdViewController
            thirdVC.modalPresentationStyle = .fullScreen
            
//            thirdVC.senderString = "change string!"
        }
        
        if segue.identifier == "toFourthVC" {
            let fourthVC = segue.destination as! FourthViewController
            fourthVC.modalPresentationStyle = .fullScreen
            
//            fourthVC.senderString = "change string!"
        }
        
    }

}
