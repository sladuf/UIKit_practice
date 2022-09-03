//
//  ViewController.swift
//  example
//
//  Created by 김민령 on 2022/06/01.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBAction func sendPropertyData(_ sender: Any) {
        
        let propertyVC = propertyDataViewController(nibName: "propertyDataViewController", bundle: nil)
        
        propertyVC.passingData = "데이터 전달 완료 !"
        
        present(propertyVC, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "passingSegueData" {
            if let segueVC = segue.destination as? segueDataViewController{
                segueVC.passingData = "segue로 데이터 전달 완료 !"
            }
        }
    }
    
    @IBOutlet weak var dataLabel: UILabel!
    
    @IBAction func moveInstanctVC(_ sender: Any) {
        let instanceVC = instanceDataViewController(nibName: "instanceDataViewController", bundle: nil)
        
        instanceVC.mainVC = self
        present(instanceVC, animated: true)
    }
    
    
    @IBAction func moveDelegateVC(_ sender: Any) {
        let delegateVC = delegateDataViewController(nibName: "delegateDataViewController", bundle: nil)
        
        delegateVC.delegate = self
        self.present(delegateVC, animated: true)
        
    }
    
    
    @IBAction func moveClosureVC(_ sender: Any) {
        let closureVC = closureDataViewController(nibName: "closureDataViewController", bundle: nil)
        
        closureVC.closure = { str in
            self.dataLabel.text = str
        }
        
        present(closureVC, animated: true)
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let noti = Notification.Name("sendNoti")
        
        NotificationCenter.default.addObserver(self, selector: #selector(showNotiData), name: noti, object: nil)
    }
    
    
    @objc func showNotiData(notification : Notification){
        if let str = notification.userInfo?["str"] as? String{
            self.dataLabel.text = str
        }
    }
    
    @IBAction func moveNotificationVC(_ sender: Any) {
        let notiVC = notificationDataViewController(nibName: "notificationDataViewController", bundle: nil)
        
        present(notiVC, animated: true)
    }
    
    

}

extension ViewController: delegateDateViewControllerDelegate {
    func delegatePassingData(str: String) {
        dataLabel.text = str
    }
}
