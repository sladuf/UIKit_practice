//
//  ThirdViewController.swift
//  ConvertVC
//
//  Created by 김민령 on 2023/01/30.
//

import UIKit

class ThirdViewController: UIViewController {
    
    
    @IBOutlet weak var label: UILabel!
    
    var senderString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = senderString ?? "ThirdViewController"
    }

    @IBAction func tapBackButton(_ sender: Any) {
        dismiss(animated: true)
    }
}
