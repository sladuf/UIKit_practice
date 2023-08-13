

import Foundation
import RxSwift

let MenuUrl = "https://firebasestorage.googleapis.com/v0/b/rxswiftin4hours.appspot.com/o/fried_menus.json?alt=media&token=42d5cb7e-8ec4-48f9-bf39-3049e796c936"

class APIService {
    
    static func fetchMenusRx() -> Observable<Data> {
        return Observable.create { observer in
            fetchMenus { result in
                switch result {
                case .success(let data):
                    observer.onNext(data)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    static func fetchMenusSingle() -> Single<Result<Data,Error>> {
        return Single.create { single in
            fetchMenus { single(.success($0)) }
            return Disposables.create()
        }
    }

    
    static func fetchMenus(completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: URL(string: MenuUrl)!) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "no data", code: -1)))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
}
