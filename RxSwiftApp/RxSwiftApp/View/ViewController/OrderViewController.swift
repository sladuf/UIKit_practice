//
//  OrderViewController.swift
//  RxSwiftApp
//
//  Created by 김민령 on 2023/05/24.
//

import UIKit
import RxSwift

class OrderViewController: UIViewController {
    static let identifier = "OrderViewController"
    
    var viewModel : OrderViewModelType
    var disposeBag = DisposeBag()

    @IBOutlet weak var orderList: UITextView!
    @IBOutlet weak var itemsPriceLabel: UILabel!
    @IBOutlet weak var vatLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var orderListHeight: NSLayoutConstraint!
    
    
    init(_ viewModel : OrderViewModelType = OrderViewModel()){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        viewModel = OrderViewModel()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        bind()
    }
    
    func bind(){
        viewModel.orderedList
            .bind(to: orderList.rx.text)
            .disposed(by: disposeBag)
        
        
        viewModel.itemsPriceText
            .bind(to: itemsPriceLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.itemsVatText
            .bind(to: vatLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.totalPriceText
            .bind(to: totalPriceLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.totalItemCount
            .map{ [weak self] cnt in
                guard let size = self?.orderList.font?.lineHeight else { return 0 }
                return CGFloat(cnt) * size + 10
            }
            .bind(to: orderListHeight.rx.constant )
            .disposed(by: disposeBag)

    }

}
