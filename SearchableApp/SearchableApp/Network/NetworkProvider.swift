
import Foundation

class NetworkProvider {
    static let shared = NetworkProvider()
    var request : URLRequest
    
    private init(){
        
        request = URLRequest(url: NetworkManager.baseURL)
        request.addValue(NetworkManager.clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(NetworkManager.clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
    }
    
    func getNews(query: String, completionHandler : @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        var component = URLComponents(url: NetworkManager.baseURL, resolvingAgainstBaseURL: true)!
        component.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "display", value: "5")
        ]
        request.url = component.url
        return URLSession.shared.dataTask(with: request, completionHandler: completionHandler)
    }
    
}
