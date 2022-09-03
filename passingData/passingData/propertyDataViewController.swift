//
//  propertyDataViewController.swift
//  example
//
//  Created by 김민령 on 2022/06/25.
//

import UIKit

class propertyDataViewController: UIViewController {
    
    
    var passingData = ""
    @IBOutlet weak var setPassingData: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPassingData.text = passingData
        
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
