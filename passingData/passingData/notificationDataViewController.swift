//
//  notificationDataViewController.swift
//  passingData
//
//  Created by 김민령 on 2022/06/27.
//

import UIKit

class notificationDataViewController: UIViewController {
    
    
    
    @IBAction func passingData(_ sender: Any) {
        
        let noti = Notification.Name("sendNoti")
        NotificationCenter.default.post(name: noti, object: nil, userInfo: ["str" : "notification 데이터 전달 완료 !"])
        self.dismiss(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
