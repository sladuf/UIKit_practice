//
//  MyTableViewCell.swift
//  example
//
//  Created by 김민령 on 2022/06/11.
//

import Foundation
import UIKit

class MyTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var userProfileImg: UIImageView!
    
    @IBOutlet weak var userContentLabel: UILabel!
    
    
    
    
    //cell이 렌더링 될때
    override func awakeFromNib() {
        super.awakeFromNib()
        print("MyTableViewCell - awakeFromNib() called")
        
        userProfileImg.layer.cornerRadius = userProfileImg.frame.width/2
    }
}
