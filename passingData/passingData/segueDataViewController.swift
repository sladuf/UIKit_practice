//
//  segueDataViewController.swift
//  example
//
//  Created by 김민령 on 2022/06/25.
//

import UIKit

class segueDataViewController: UIViewController {

    var passingData = ""
    @IBOutlet weak var dataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataLabel.text = passingData

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
