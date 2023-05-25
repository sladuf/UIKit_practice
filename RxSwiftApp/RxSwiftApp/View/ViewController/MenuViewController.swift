

import UIKit
import RxSwift
import RxCocoa

class MenuViewController: UIViewController {
    let disposeBag = DisposeBag()
    let viewModel : MenuViewModelType
    
    // MARK: - InterfaceBuilder Links
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var itemCountLabel: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    init(viewModel: MenuViewModelType = MenuViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        viewModel = MenuViewModel()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.fetch()
    }
    
    func bind(){
        
        viewModel.activated
            .map{ !$0 }
            .bind(to: activityIndicator.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.menus
            .bind(to: tableView.rx.items(cellIdentifier: MenuTableViewCell.cellID, cellType: MenuTableViewCell.self)) { idx,item,cell in
                cell.data.onNext(item)
                cell.changed
                    .map{ (item, $0) }
                    .bind(to: self.viewModel.updateMenuCount)
                    .disposed(by: cell.disposeBag)
                
            }.disposed(by: disposeBag)
        
        clearButton.rx.tap
            .bind(to: viewModel.clear)
            .disposed(by: disposeBag)
        
        viewModel.totalItemCount
            .map{ String($0) }
            .bind(to: itemCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.totalPrice
            .map{ Currency.ko($0) }
            .bind(to: totalPrice.rx.text)
            .disposed(by: disposeBag)
        
        orderButton.rx.tap
            .bind(to: viewModel.makeOrder)
            .disposed(by: disposeBag)
        
        viewModel.orderList
            .subscribe(onNext: {
                guard let vc = self.storyboard?.instantiateViewController(identifier: OrderViewController.identifier) as? OrderViewController else { return }
                vc.viewModel = OrderViewModel($0)
                
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        
    }
    
    
}

