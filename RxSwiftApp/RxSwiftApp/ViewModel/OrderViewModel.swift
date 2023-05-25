
import Foundation
import RxSwift

protocol OrderViewModelType {
    var orderedList: Observable<String> { get }
    var itemsPriceText: Observable<String> { get }
    var itemsVatText: Observable<String> { get }
    var totalPriceText: Observable<String> { get }
    var totalItemCount : Observable<Int> { get }
}

class OrderViewModel : OrderViewModelType {
    let orderedList: Observable<String>
    let itemsPriceText: Observable<String>
    let itemsVatText: Observable<String>
    let totalPriceText: Observable<String>
    let totalItemCount: Observable<Int>
    
    init(_ selectedMenus: [ViewMenu] = []){
        let menus = Observable.just(selectedMenus)
        let price = menus.map{ $0.map{ $0.count * $0.price }.reduce(0, +) }
        let vat = price.map{ Int(Float($0) * 0.1 / 10 + 0.5) * 10 }
        
        orderedList = menus
            .map{ $0.map{ "\($0.name) \($0.count)개\n"}.joined() }
        
        itemsPriceText = price
            .map{ Currency.ko($0) }
        
        itemsVatText = vat
            .map{ Currency.ko($0) }
        
        totalPriceText = Observable.combineLatest(price, vat) { $0 + $1 }
            .map{ Currency.ko($0) }
        
        totalItemCount = menus
            .map{ $0.filter{ $0.count > 0 }.count }
        
    }
    
}
