

import Foundation
import RxSwift

protocol MenuRepositoryType {
    func fetchMenus() -> Observable<[MenuItem]>
}

class MenuRepository : MenuRepositoryType {
    
    func fetchMenus() -> Observable<[MenuItem]> {
        struct Response: Decodable {
            let menus: [MenuItem]
        }
        
        return APIService.fetchMenusSingle()
            .map { result in
                switch result {
                case .success(let data):
                    guard let response = try? JSONDecoder().decode(Response.self, from: data) else {
                        throw NSError(domain: "Decoding error", code: -1, userInfo: nil)
                    }
                    return response.menus
                case .failure:
                    return []
                }
            }.asObservable()
    }
}
