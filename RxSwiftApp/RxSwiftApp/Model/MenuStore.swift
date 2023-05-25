

import Foundation
import RxSwift


class MenuStore {
    func fetchMenus() -> Observable<[MenuItem]> {
        struct Response: Decodable {
            let menus: [MenuItem]
        }

        return APIService.fetchMenusRx()
            .map { data in
                guard let response = try? JSONDecoder().decode(Response.self, from: data) else {
                    throw NSError(domain: "Decoding error", code: -1, userInfo: nil)
                }
                return response.menus
            }
    }
}
