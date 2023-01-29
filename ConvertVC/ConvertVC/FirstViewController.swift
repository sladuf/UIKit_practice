//
//  FirstViewController.swift
//  ConvertVC
//
//  Created by 김민령 on 2023/01/30.
//

import UIKit

class FirstViewController: UIViewController {
    
    private let label = UILabel()
    private lazy var backButton = UIButton()
    
    var senderString : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initAttribute()
        
        [label, backButton].forEach {
            self.view.addSubview($0)
        }
        initAutolayout()
        
    }
    
    
    func initAttribute(){
        self.view.backgroundColor = .white
        
        label.text = senderString ?? "FirstViewController"
        
        backButton = {
            let button = UIButton()
            
            button.setTitle("Back", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .systemBlue
            button.addTarget(self, action: #selector(tapBackButton), for: .touchUpInside)
            
            return button
            
        }()
        
    }
    
    func initAutolayout(){
        
        label.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            backButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            backButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            backButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }

}

@objc extension FirstViewController {
    
    func tapBackButton() {
        self.dismiss(animated: true)
    }
}
