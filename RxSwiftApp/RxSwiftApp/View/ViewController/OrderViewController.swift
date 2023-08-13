

import UIKit
import RxSwift
import ReactorKit

class OrderViewController: UIViewController, View, StoryboardView {
    
    static let identifier = "OrderViewController"
    
//    var viewModel : OrderViewModelType
    var disposeBag = DisposeBag()

    @IBOutlet weak var orderList: UITextView!
    @IBOutlet weak var itemsPriceLabel: UILabel!
    @IBOutlet weak var vatLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var orderListHeight: NSLayoutConstraint!
    
    
//    init(_ viewModel : OrderViewModelType = OrderViewModel()){
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }

//    required init?(coder aDecoder: NSCoder) {
//        viewModel = OrderViewModel()
//        super.init(coder: aDecoder)
//    }

//    override func viewDidLoad() {
//        bind()
//    }
    
//    func bind(){
//        viewModel.orderedList
//            .bind(to: orderList.rx.text)
//            .disposed(by: disposeBag)
//
//
//        viewModel.itemsPriceText
//            .bind(to: itemsPriceLabel.rx.text)
//            .disposed(by: disposeBag)
//
//        viewModel.itemsVatText
//            .bind(to: vatLabel.rx.text)
//            .disposed(by: disposeBag)
//
//        viewModel.totalPriceText
//            .bind(to: totalPriceLabel.rx.text)
//            .disposed(by: disposeBag)
//
//        viewModel.totalItemCount
//            .map{ [weak self] cnt in
//                guard let size = self?.orderList.font?.lineHeight else { return 0 }
//                return CGFloat(cnt) * size + 10
//            }
//            .bind(to: orderListHeight.rx.constant )
//            .disposed(by: disposeBag)
//
//    }
    
    func bind(reactor: OrderViewReactor) {
        bindState(reactor: reactor)
    }
    
    func bindState(reactor: OrderViewReactor){
        
        reactor.state.compactMap{ $0.menus }
            .distinctUntilChanged()
            .map{ $0.map{ "\($0.name) \($0.count)개\n"}.joined() }
            .bind(to: orderList.rx.text)
            .disposed(by: disposeBag)

        reactor.state.compactMap{ $0.price }
            .distinctUntilChanged()
            .map{ Currency.ko($0) }
            .bind(to: itemsPriceLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.compactMap{ $0.vat }
            .distinctUntilChanged()
            .map{ Currency.ko($0) }
            .bind(to: vatLabel.rx.text)
            .disposed(by: disposeBag)
        
        Observable.zip(reactor.state.compactMap{ $0.price }, reactor.state.compactMap{ $0.vat } ) { String($0 + $1) }
            .distinctUntilChanged()
            .bind(to: totalPriceLabel.rx.text)
            .disposed(by: disposeBag)
        
    }

}
