

import Foundation
import RxSwift

protocol MenuViewModelType {
    var disposeBag : DisposeBag { get }
    var fetchMenus : AnyObserver<Void> { get }
    var clear : AnyObserver<Void> { get }
    var makeOrder : AnyObserver<Void> { get }
    
    var activated : Observable<Bool> { get }
    var errorMessage : AnyObserver<Error> { get }
    var menus : Observable<[ViewMenu]> { get }
    var updateMenuCount : AnyObserver<(menu: ViewMenu, cnt: Int)> { get }
    var totalItemCount: Observable<Int> { get }
    var totalPrice: Observable<Int> { get }
    var orderList : Observable<[ViewMenu]> { get }
    
    func fetch()
}

class MenuViewModel : MenuViewModelType{
    
    let disposeBag = DisposeBag()
    
    // MARK: - INPUT
    let fetchMenus: AnyObserver<Void>
    let clear: AnyObserver<Void>
    let makeOrder: AnyObserver<Void>
    
    // MARK: - OUTPUT
    let activated: Observable<Bool>
    let errorMessage: AnyObserver<Error>
    let menus: Observable<[ViewMenu]>
    let updateMenuCount: AnyObserver<(menu: ViewMenu, cnt: Int)>
    let totalItemCount: Observable<Int>
    let totalPrice: Observable<Int>
    let orderList: Observable<[ViewMenu]>
    

    init(domain : MenuStore = MenuStore()){
        let fetching = PublishSubject<Void>()
        let clearing = PublishSubject<Void>()
        let ordering = PublishSubject<Void>()
        
        let activating = BehaviorSubject(value: false)
        let error = PublishSubject<Error>()
        let menus = BehaviorSubject<[ViewMenu]>(value: [])
        let menuCount = PublishSubject<(menu: ViewMenu, cnt: Int)>()
        
        // MARK: - init INPUT
        fetchMenus = fetching.asObserver()
        clear = clearing.asObserver()
        makeOrder = ordering.asObserver()
        
        fetching
            .do(onNext: { _ in activating.onNext(true) })
            .flatMap(domain.fetchMenus)
            .map { $0.map { ViewMenu($0) }}
            .do(onNext: { _ in activating.onNext(false) })
            .do(onError: { error.onNext($0) })
            .subscribe(onNext: menus.onNext)
            .disposed(by: disposeBag)
    
        clearing
            .withLatestFrom(menus)
            .map{ $0.map{ $0.countUpdated(0) } }
            .subscribe(onNext: menus.onNext)
            .disposed(by: disposeBag)
    
    
        menuCount
            .map { $0.menu.countUpdated(max(0, $0.menu.count + $0.cnt)) }
            .withLatestFrom(menus) { menu, menus in
                menus.map{
                    guard $0.name == menu.name else { return $0 }
                    return menu
                }
            }
            .subscribe(onNext: menus.onNext)
            .disposed(by: disposeBag)
        
        totalItemCount = menus
            .map{ $0.map{ $0.count }.reduce(0, +) }
        
        totalPrice = menus
            .map{ $0.map{ $0.price * $0.count }.reduce(0, +) }
        
        
        orderList = ordering.withLatestFrom(menus)
            .map{ $0.filter{ $0.count > 0 } }
                
                
        // MARK: - init OUTPUT
        self.menus = menus
        activated = activating.distinctUntilChanged()
        errorMessage = error.asObserver()
        updateMenuCount = menuCount.asObserver()
        
    }
    
    func fetch(){
        fetchMenus.onNext(())
    }
    
}

