//
//  closureDataViewController.swift
//  passingData
//
//  Created by 김민령 on 2022/06/27.
//

import UIKit

class closureDataViewController: UIViewController {
    
    var closure: ((String)->Void)?

    @IBAction func passingData(_ sender: Any) {
        closure?("closure 데이터 전달 완료 !")
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}
