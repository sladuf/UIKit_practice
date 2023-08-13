

import Foundation
import ReactorKit

class OrderViewReactor : Reactor {
    var initialState: State
    
    struct State {
        var menus: [ViewMenu]
        var price: Int
        var vat: Int
        
        init(menus: [ViewMenu], price: Int, vat: Int){
            self.menus = menus
            self.price = price
            self.vat = vat
        }
        
        fileprivate init(){
            self.init(menus: [], price: 0, vat: 0)
        }
    }
    
    enum Mutation {
        case setMenus([ViewMenu])
        case setPrice
        case setVat
    }
    
    enum Action {
        case fetchMenus([ViewMenu])
    }
    
    init(_ selectedMenus: [ViewMenu] = []) {
        self.initialState = State()
        
        let price = calPrice(selectedMenus)
        self.initialState = State(menus: selectedMenus,
                                  price: price,
                                  vat: calVat(price))
    }
    
    //action -> mutate
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchMenus(let menus):
            return .concat(
                .just(.setMenus(menus)),
                .just(.setPrice),
                .just(.setVat)
            )
        }
    }
    
    //mutate -> state
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setMenus(let menus):
            state.menus = menus
        case .setPrice:
            state.price = calPrice(state.menus)
        case .setVat:
            state.vat = calVat(state.price)
        }
        return state
    }
    
    func calPrice(_ menus: [ViewMenu]) -> Int {
        return menus.map { $0.count * $0.price }.reduce(0, +)
    }
    
    func calVat(_ price: Int) -> Int {
        return Int(Float(price) * 0.1 / 10 + 0.5) * 10
    }
}
