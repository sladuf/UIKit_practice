//
//  instanceDataViewController.swift
//  example
//
//  Created by 김민령 on 2022/06/25.
//

import UIKit

class instanceDataViewController: UIViewController {

    var mainVC: ViewController?

    @IBAction func sendInstanceData(_ sender: Any) {
        mainVC?.dataLabel.text = "instance 데이터 전달 완료 !"
        
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
