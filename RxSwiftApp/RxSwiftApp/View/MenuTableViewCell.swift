//
//  MenuTableViewCell.swift
//  RxSwiftApp
//
//  Created by 김민령 on 2023/05/21.
//

import UIKit
import RxSwift
import RxCocoa

class MenuTableViewCell: UITableViewCell {
    static let cellID = "MenuTableViewCell"
    
    // MARK: - InterfaceBuilder Links
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var count: UILabel!
    
    @IBAction func increaseButton(_ sender: UIButton) {
        changed.onNext(1)
    }
    @IBAction func decreaseButton(_ sender: UIButton) {
        changed.onNext(-1)
    }
    
    private let cellDisposeBag = DisposeBag()
    var disposeBag = DisposeBag() 
    let data : AnyObserver<ViewMenu>
    let changed : PublishSubject<Int>
    
    required init?(coder aDecoder: NSCoder) {
        let data = PublishSubject<ViewMenu>()
        let changing = PublishSubject<Int>()
        
        self.data = data.asObserver()
        changed = changing
        
        super.init(coder: aDecoder)
        
        data
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] menu in
                self?.label.text = menu.name
                self?.price.text = "\(menu.price)"
                self?.count.text = "\(menu.count)"
            })
            .disposed(by: cellDisposeBag)
        
    }
    
    override func prepareForReuse() {
        //changed subscribe dispose
        disposeBag = DisposeBag()
    }


}
