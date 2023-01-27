//
//  ViewController.swift
//  TimerApp
//
//  Created by 김민령 on 2023/01/28.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    //strong reference 방지
    weak var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        let second = sliderValueToSecond(value: slider.value)
        label.text = "\(second)초"
    }
    
    @IBAction func tapReset(_ sender: Any) {
        /// timer 비활성화 함수
        timer?.invalidate()
        
        slider.setValue(0.5, animated: true)
        label.text = "초를 선택하세요"
    }
    
    @IBAction func tapStart(_ sender: Any) {
        timer?.invalidate()
        
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [self] _ in
            
            if slider.value > 0 {
                
                let second = sliderValueToSecond(value: slider.value)-1
                slider.value = Float(second) / Float(60)
                label.text = "\(second)초"
            }
            else {
                slider.value = 0
                label.text = "\(0)초"
                timer?.invalidate()
                
                ///sound name : alarm.caf (SystemSoundPreview)
                AudioServicesPlayAlertSound(SystemSoundID(1304))
            }
            
        })
    }
    
    func sliderValueToSecond(value : Float) -> Int {
        return Int(value * 60)
    }
    
}
