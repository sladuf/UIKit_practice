//
//  delegateDataViewController.swift
//  passingData
//
//  Created by 김민령 on 2022/06/26.
//

import UIKit


protocol delegateDateViewControllerDelegate: AnyObject {
    func delegatePassingData(str: String)
    
}


class delegateDataViewController: UIViewController {
    
    weak var delegate: delegateDateViewControllerDelegate?

    @IBAction func passingData(_ sender: Any) {
        delegate?.delegatePassingData(str: "delegate 데이터 전달 완료 !")
        dismiss(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    


}
